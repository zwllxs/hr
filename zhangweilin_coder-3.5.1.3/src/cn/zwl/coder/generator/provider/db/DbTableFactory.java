package cn.zwl.coder.generator.provider.db;


import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import cn.zwl.coder.generator.GeneratorProperties;
import cn.zwl.coder.generator.provider.db.model.Column;
import cn.zwl.coder.generator.provider.db.model.Table;
import cn.zwl.coder.generator.provider.db.model.TableMap;
import cn.zwl.coder.generator.util.GLogger;
/**
 * 
 * @author badqiu
 * @email badqiu(a)gmail.com
 */
public class DbTableFactory {

	
	private Connection connection;
	private static DbTableFactory instance = null;
	
	private DbTableFactory() {
		init();
	}

	private void init()
    {
        String driver = GeneratorProperties.getRequiredProperty("jdbc.driver");
        try
        {
            Class.forName(driver);
        }
        catch (ClassNotFoundException e)
        {
            throw new RuntimeException("not found jdbc driver class:[" + driver
                    + "]", e);
        }
    }
	
	/**
	 * 单例获取工厂实例
	 * @return
	 */
	public synchronized static DbTableFactory getInstance()
    {
        if (instance == null)
        {
            instance = new DbTableFactory();
        }
        return instance;
    }
	
	public String getCatalog()
    {
        return GeneratorProperties.getNullIfBlank("jdbc.catalog");
    }

	public String getSchema()
    {
        return GeneratorProperties.getNullIfBlank("jdbc.schema");
    }

	/**
	 * 获取数据库连接
	 * @return
	 * @throws SQLException
	 */
    public Connection getConnection() throws SQLException
    {
        if (connection == null || connection.isClosed())
        {
            connection = DriverManager.getConnection(GeneratorProperties
                    .getRequiredProperty("jdbc.url"), GeneratorProperties
                    .getRequiredProperty("jdbc.username"), GeneratorProperties
                    .getProperty("jdbc.password"));
        }
        return connection;
    }

    /**
     * 获取所有的表列表
     * @return
     * @throws Exception
     */
    public List getAllTables() throws Exception
    {
        Connection conn = getConnection();
        return getAllTables(conn);
    }
	
    public Table getTable(String sqlTableName) throws Exception
    {
        Table t = _getTable(sqlTableName);
        if (t == null && !sqlTableName.equals(sqlTableName.toUpperCase()))
        {
            t = _getTable(sqlTableName.toUpperCase());
        }
        if (t == null && !sqlTableName.equals(sqlTableName.toLowerCase()))
        {
            t = _getTable(sqlTableName.toLowerCase());
        }

        if (t == null)
        {
            throw new RuntimeException("not found table with give name:"
                    + sqlTableName);
        }
        return t;
    }

	private Table _getTable(String sqlTableName) throws SQLException 
	{
		Connection conn = getConnection();
		DatabaseMetaData dbMetaData = conn.getMetaData();
//		System.out.println("sqlTableName: "+sqlTableName);
		/**
		 * sqlTableName此时只是一个表达式，即符合这个正则的表名
		 */
		ResultSet rs = dbMetaData.getTables(getCatalog(), getSchema(), sqlTableName, null);
		while(rs.next()) 
		{
			Table table = createTable(conn, rs);
//			System.out.println("table: "+table.getSqlName());
			return table;
		}
		return null;
	}

	/**
	 * 创建表,在这里获取了数据库中必要信息，获取创建表的必要元素,即组织数据结构
	 * @param conn 连接
	 * @param rs 结果集
	 * @return
	 * @throws SQLException
	 */
    private Table createTable(Connection conn, ResultSet rs) throws SQLException
    {
        String realTableName = null;
        try
        {
//            ResultSetMetaData rsMetaData = rs.getMetaData();
//            String schemaName = rs.getString("TABLE_SCHEM") == null ? "" : rs.getString("TABLE_SCHEM");
            //获取表名
            realTableName = rs.getString("TABLE_NAME");
            
            //TABLE_TYPE为表类型，table type. Typical types are "TABLE", "VIEW", "SYSTEM TABLE", "GLOBAL TEMPORARY", "LOCAL TEMPORARY", "ALIAS", "SYNONYM". 
            String tableType = rs.getString("TABLE_TYPE");
            
            //REMARKS表示为注释
            String remarks = rs.getString("REMARKS");
            if (remarks == null && isOracleDataBase())
            {
                remarks = getOracleTableComments(realTableName);
            }

            Table table = new Table();
            table.setSqlName(realTableName);
            table.setRemarks(remarks);//此获取表注释并不起作用,所以采用查系统表的方式 (mysql)
            
            //在上面的那一行，获取不到表注释，为了解决此问题，只能从系统表获取，目前暂时只支持mysql
            setTableRemarks(conn, table);

            //如果是oracle数据库，则设置其所属者
            if ("SYNONYM".equals(tableType) && isOracleDataBase())
            {
                table.setOwnerSynonymName(getSynonymOwner(realTableName));
            }

            //完成了表的内部结构大部分的构造,如主键
            retriveTableColumns(table);

            //寻找有哪些表有外键指向此表
            table.initExportedKeys(conn.getMetaData());
            //寻找此表有哪些外键指向别的表
            table.initImportedKeys(conn.getMetaData());
            return table;
        }
        catch (SQLException e)
        {
            throw new RuntimeException("create table object error,tableName:" + realTableName, e);
        }
    }

    /**
     * 从系统表获取到表的注释并进行解析，目前暂时只支持mysql
     * @param conn
     * @param table
     * @throws SQLException
     */
    private void setTableRemarks(Connection conn, Table table)
            throws SQLException
    {
        //获取数据库类型
        DatabaseMetaData dbMetaData = conn.getMetaData();
        String dataBaseProductName=dbMetaData.getDatabaseProductName();
        //如果是mysql,则从mysql的系统表里查询表注释
        if ("MySQL".equals(dataBaseProductName))
        {
            String sql="select TABLE_COMMENT from information_schema.TABLES where TABLE_SCHEMA = ? and TABLE_NAME = ? ";
            String catalog=conn.getCatalog();
            PreparedStatement pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, catalog);
            pstmt.setString(2, table.getSqlName());
            ResultSet rs=pstmt.executeQuery();
            if (rs.next())
            {
                String comment=rs.getString(1);
                comment=comment.contains("; InnoDB")?comment.replaceAll(";.*$", "").replaceAll("表$", ""):"[未知实体]";
                table.setRemarks(comment);
            }
        }
    }
	
    /**
     * 通过连接，获取Table列表
     * @param conn
     * @return
     * @throws SQLException
     */
    private List<Table> getAllTables(Connection conn) throws SQLException
    {
        DatabaseMetaData dbMetaData = conn.getMetaData();
        //getTables，获取表信息，参数4为null,表示获取其它的,  如果仅仅是获取表名，则{ "TABLE" }即可
        
//        System.out.println("getCatalog(): "+getCatalog());
//        System.out.println("getSchema(): "+getSchema());
        ResultSet rs = dbMetaData.getTables(getCatalog(), getSchema(), null,null);
        List<Table> tables = new ArrayList<Table>();
        while (rs.next())
        {
            Table table = createTable(conn, rs);
//            System.out.println("table.getPkCount(): "+table.getPkCount());
//            System.out.println("table.getPkColumnList(): "+table.getPkColumnList());
//            System.out.println("table.getPkNameList(): "+table.getPkNameList());
//            System.out.println("table.getPkName(): "+table.getPkName());
//            System.out.println("table.getPkColumn(): "+table.getPkColumn().getJavaType());
//            System.out.println();
            
            //如果指定了include,则优先此
            if (!TableMap.includeTableList.isEmpty())
            {
//                System.out.println("指定了include: ");
                //只有被指定过的表，才参与生成
                if (TableMap.includeTableList.contains(table.getSqlName()))
                {
                    TableMap.tableMap.put("tableName_" + table.getSqlName(),table);
                    tables.add(table);
                }
            }
            //如果指定了exclude 
            else if (!TableMap.excludeTableList.isEmpty())
            {
//                System.out.println("指定了exclude :");
                //只有被指定过的表，才参与生成
                if (!TableMap.excludeTableList.contains(table.getSqlName()))
                {
                    TableMap.tableMap.put("tableName_" + table.getSqlName(),table);
                    tables.add(table);
                }
            }
            //如果两个都没指定
            else
            {
                TableMap.tableMap.put("tableName_"+table.getSqlName(), table);
                tables.add(table);
            }
        }
        return tables;
    }

	private boolean isOracleDataBase() {
		boolean ret = false;
		try {
			ret = (getMetaData().getDatabaseProductName().toLowerCase()
					.indexOf("oracle") != -1);
		} catch (Exception ignore) {
		}
		return ret;
	}
	   
   private String getSynonymOwner(String synonymName)  {
	      PreparedStatement ps = null;
	      ResultSet rs = null;
	      String ret = null;
	      try {
	         ps = getConnection().prepareStatement("select table_owner from sys.all_synonyms where table_name=? and owner=?");
	         ps.setString(1, synonymName);
	         ps.setString(2, getSchema());
	         rs = ps.executeQuery();
	         if (rs.next()) {
	            ret = rs.getString(1);
	         }
	         else {
	            String databaseStructure = getDatabaseStructureInfo();
	            throw new RuntimeException("Wow! Synonym " + synonymName + " not found. How can it happen? " + databaseStructure);
	         }
	      } catch (SQLException e) {
	         String databaseStructure = getDatabaseStructureInfo();
	         GLogger.error(e.getMessage(), e);
	         throw new RuntimeException("Exception in getting synonym owner " + databaseStructure);
	      } finally {
	         if (rs != null) {
	            try {
	               rs.close();
	            } catch (Exception e) {
	            }
	         }
	         if (ps != null) {
	            try {
	               ps.close();
	            } catch (Exception e) {
	            }
	         }
	      }
	      return ret;
	   }
   
   private String getDatabaseStructureInfo() {
	      ResultSet schemaRs = null;
	      ResultSet catalogRs = null;
	      String nl = System.getProperty("line.separator");
	      StringBuffer sb = new StringBuffer(nl);
	      // Let's give the user some feedback. The exception
	      // is probably related to incorrect schema configuration.
	      sb.append("Configured schema:").append(getSchema()).append(nl);
	      sb.append("Configured catalog:").append(getCatalog()).append(nl);

	      try {
	         schemaRs = getMetaData().getSchemas();
	         sb.append("Available schemas:").append(nl);
	         while (schemaRs.next()) {
	            sb.append("  ").append(schemaRs.getString("TABLE_SCHEM")).append(nl);
	         }
	      } catch (SQLException e2) {
	         GLogger.warn("Couldn't get schemas", e2);
	         sb.append("  ?? Couldn't get schemas ??").append(nl);
	      } finally {
	         try {
	            schemaRs.close();
	         } catch (Exception ignore) {
	         }
	      }

	      try {
	         catalogRs = getMetaData().getCatalogs();
	         sb.append("Available catalogs:").append(nl);
	         while (catalogRs.next()) {
	            sb.append("  ").append(catalogRs.getString("TABLE_CAT")).append(nl);
	         }
	      } catch (SQLException e2) {
	         GLogger.warn("Couldn't get catalogs", e2);
	         sb.append("  ?? Couldn't get catalogs ??").append(nl);
	      } finally {
	         try {
	            catalogRs.close();
	         } catch (Exception ignore) {
	         }
	      }
	      return sb.toString();
    }
	   
	private DatabaseMetaData getMetaData() throws SQLException {
		return getConnection().getMetaData();
	}
	
	/**
	 * 对表结构里的各属性做一些完善
	 * @param table
	 * @throws SQLException
	 */
	private void retriveTableColumns(Table table) throws SQLException 
	{
	      GLogger.debug("-------setColumns(" + table.getSqlName() + ")");

	      //得到当前表的主键列表
	      List<String> pkNameList = getTablePkNameList(table);
//	      table.setPrimaryKeyColumns(pkNameList);
	      table.setPkNameList(pkNameList);
	      
	      //索引列或者唯一列
	      List indices = new LinkedList();
	      // maps index names to a list of columns in the index
	      //索引列名对应的索引名称
	      Map<String, String> uniqueIndices = new HashMap<String, String>();
	      // maps column names to the index name.
	      //索引名称对应的列集合？？？？？
	      Map uniqueColumns = new HashMap();
	      ResultSet indexRs = null;

	      try {

	         if (table.getOwnerSynonymName() != null) {
	            indexRs = getMetaData().getIndexInfo(getCatalog(), table.getOwnerSynonymName(), table.getSqlName(), false, true);
	         }
	         else {
	            indexRs = getMetaData().getIndexInfo(getCatalog(), getSchema(), table.getSqlName(), false, true);
	         }
	         while (indexRs.next()) 
	         {
	            //得到索引列名
	            String columnName = indexRs.getString("COLUMN_NAME");
	            if (columnName != null) {
	               GLogger.debug("index:" + columnName);
	               indices.add(columnName);
	            }

	            // now look for unique columns
	            String indexName = indexRs.getString("INDEX_NAME");//索引名称
	            boolean nonUnique = indexRs.getBoolean("NON_UNIQUE");

	            if (!nonUnique && columnName != null && indexName != null) {
	               List l = (List)uniqueColumns.get(indexName);
	               if (l == null) {
	                  l = new ArrayList();
	                  uniqueColumns.put(indexName, l);
	               }
	               l.add(columnName);
	               uniqueIndices.put(columnName, indexName);
	               GLogger.debug("unique:" + columnName + " (" + indexName + ")");
	            }
	         }
	      } catch (Throwable t) {
	         // Bug #604761 Oracle getIndexInfo() needs major grants
	         // http://sourceforge.net/tracker/index.php?func=detail&aid=604761&group_id=36044&atid=415990
	      } finally {
	         if (indexRs != null) {
	            indexRs.close();
	         }
	      }

	      //得到当前表的所有的列对象集合
	      List columns = getTableColumns(table, pkNameList, indices, uniqueIndices, uniqueColumns);

	      for (Iterator i = columns.iterator(); i.hasNext(); ) {
	         Column column = (Column)i.next();
	         table.addColumn(column);//不明白为什么要用Set
	      }

	      // In case none of the columns were primary keys, issue a warning.
	      if (pkNameList.size() == 0) {
	         GLogger.warn("WARNING: The JDBC driver didn't report any primary key columns in " + table.getSqlName());
	      }
	}

	/**
	 * 获取表中所有的列
	 * @param table
	 * @param primaryKeys
	 * @param indices
	 * @param uniqueIndices
	 * @param uniqueColumns
	 * @return
	 * @throws SQLException
	 */
	private List getTableColumns(Table table, List primaryKeys, List indices, Map uniqueIndices, Map uniqueColumns) throws SQLException {
		// get the columns
	      List columns = new LinkedList();
	      ResultSet columnRs = getColumnsResultSet(table);
	      
	      while (columnRs.next()) 
	      {
	         int sqlType = columnRs.getInt("DATA_TYPE");//类型
	         String sqlTypeName = columnRs.getString("TYPE_NAME");//Data source dependent type name
	         String columnName = columnRs.getString("COLUMN_NAME");//列名称
	         String columnDefaultValue = columnRs.getString("COLUMN_DEF");  //该列的默认值
	         
	         String remarks = columnRs.getString("REMARKS");  //该列的注释
	         //获取oracle的列注释
	         if(remarks == null && isOracleDataBase()) 
	         {
	        	 remarks = getOracleColumnComments(table.getSqlName(), columnName);
	         }
	         
	         // if columnNoNulls or columnNullableUnknown assume "not nullable"
	         boolean isNullable = (DatabaseMetaData.columnNullable == columnRs.getInt("NULLABLE"));//是否可以是null值
	         int size = columnRs.getInt("COLUMN_SIZE");//列大小，应该为列数目
	         int decimalDigits = columnRs.getInt("DECIMAL_DIGITS");//the number of fractional digits. Null is returned for data types where DECIMAL_DIGITS is not applicable.

	         //当前列是否是主键
	         boolean isPk = primaryKeys.contains(columnName);
	         //当前列是否是索引列
	         boolean isIndexed = indices.contains(columnName);
	         String uniqueIndex = (String)uniqueIndices.get(columnName);
	         List columnsInUniqueIndex = null;
	         if (uniqueIndex != null) {
	            columnsInUniqueIndex = (List)uniqueColumns.get(uniqueIndex);
	         }

	         //是否是唯一索引
	         boolean isUnique = columnsInUniqueIndex != null && columnsInUniqueIndex.size() == 1;
	         if (isUnique) 
	         {
	            GLogger.debug("unique column:" + columnName);
	         }
	         
	         //列
	         Column column = new Column(
	               table,
	               sqlType,
	               sqlTypeName,
	               columnName,
	               size,
	               decimalDigits,
	               isPk,
	               isNullable,
	               isIndexed,
	               isUnique,
	               columnDefaultValue,
	               remarks);
	         columns.add(column);
	    }
	    columnRs.close();
		return columns;
	}

	/**
	 * 获取到列的结果集
	 * @param table
	 * @return
	 * @throws SQLException
	 */
	private ResultSet getColumnsResultSet(Table table) throws SQLException {
		ResultSet columnRs = null;
	    if (table.getOwnerSynonymName() != null) {
	         columnRs = getMetaData().getColumns(getCatalog(), table.getOwnerSynonymName(), table.getSqlName(), null);
	    } else {
	         columnRs = getMetaData().getColumns(getCatalog(), getSchema(), table.getSqlName(), null);
	    }
		return columnRs;
	}

	/**
	 * 获取主键列表,一个表一般只有一个主键，为什么此处使用列表，难道是为了适应复合主键???
	 * 获取到主键列的列名，注意此只是列名而已
	 * @param table
	 * @return
	 * @throws SQLException
	 */
	private List<String> getTablePkNameList(Table table) throws SQLException 
	{
		// get the primary keys
	      List<String> primaryKeysList = new LinkedList<String>();
	      ResultSet rs = null;
	      //如果同义词不为空，则为oracle
	      if (table.getOwnerSynonymName() != null) 
	      {
	         rs = getMetaData().getPrimaryKeys(getCatalog(), table.getOwnerSynonymName(), table.getSqlName());
	      }
	      //非oracle数据库
	      else 
	      {
	         rs = getMetaData().getPrimaryKeys(getCatalog(), getSchema(), table.getSqlName());
	      }
	      
	      while (rs.next()) 
	      {
	          //获取主键列名
	         String columnName = rs.getString("COLUMN_NAME");
	         GLogger.debug("primary key:" + columnName);
	         primaryKeysList.add(columnName);
	      }
	      rs.close();
		return primaryKeysList;
	}

	/**
	 * 获取oracle的注释
	 * @param table
	 * @return
	 */
    private String getOracleTableComments(String table)
    {
        String sql = "SELECT comments FROM user_tab_comments WHERE table_name='"
                + table + "'";
        return queryForString(sql);
    }

	private String queryForString(String sql) {
		Statement s = null;
		ResultSet rs = null;
		try {
			s =  getConnection().createStatement();
			rs = s.executeQuery(sql);
			if(rs.next()) {
				return rs.getString(1);
			}
			return null;
		}catch(SQLException e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(s != null)
					s.close();
				if(rs != null) rs.close();
			} catch (SQLException e) {
			}
		}
	}
	
	private String getOracleColumnComments(String table,String column)  {
		String sql = "SELECT comments FROM user_col_comments WHERE table_name='"+table+"' AND column_name = '"+column+"'";
		return queryForString(sql);
	}
	
}
