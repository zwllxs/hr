package cn.zwl.coder.generator.provider.db.model;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import cn.zwl.coder.generator.provider.db.DbTableFactory;
import cn.zwl.coder.generator.util.StringUtil;

/**
 * @author zhangweilin
 */
public class Table
{
    //一个表可能被多个表指向,所以其实在ForeignKeys内部中有一个外键集合
    /**
     * 此处的外键并还没有赋值
     */
    private ForeignKeys exportedKeys;
    private ForeignKeys importedKeys;
    
    private String catalog = DbTableFactory.getInstance().getCatalog();
 
    private String schema = DbTableFactory.getInstance().getSchema();

    public static final String PKTABLE_NAME = "PKTABLE_NAME";
    public static final String PKCOLUMN_NAME = "PKCOLUMN_NAME";
    public static final String FKTABLE_NAME = "FKTABLE_NAME";
    public static final String FKCOLUMN_NAME = "FKCOLUMN_NAME";
    public static final String KEY_SEQ = "KEY_SEQ";
    
    // 数据库中的表名
    String sqlName;

    // 注释
    String remarks;

    String customClassName;
    /** the name of the owner of the synonym if this table is a synonym */
    //
    private String ownerSynonymName = null;
    
    //当前表的列集合，不明白为什么要用Set集合？
    Set<Column> columns = new LinkedHashSet<Column>();
    
    //主键列表，其实一般一个表只有一个主键
    private List<String> pkNameList = new ArrayList<String>();

    public Set<Column> getColumns()
    {
        return columns;
    }
    public void setColumns(Set columns)
    {
        this.columns = columns;
    }
    public String getOwnerSynonymName()
    {
        return ownerSynonymName;
    }
    public void setOwnerSynonymName(String ownerSynonymName)
    {
        this.ownerSynonymName = ownerSynonymName;
    }
 
    public String getSqlName()
    {
        return sqlName;
    }
    public void setSqlName(String sqlName)
    {
        this.sqlName = sqlName;
    }
    public String getRemarks()
    {
        return remarks;
    }
    public void setRemarks(String remarks)
    {
        this.remarks = remarks;
    }
    public void addColumn(Column column)
    {
        columns.add(column);
    }

    public void setClassName(String customClassName)
    {
        this.customClassName = customClassName;
    }
    
    /**
     * 获取当前表应该生成的对应的实体类名，如表名为admint_t,那对应类名应该为Admin或AdminT,
     * 此方法实现从表名转换成类名，当有不同的规则时，重写此方法
     * 
     * @return
     */
    public String getClassName()
    {
//        String defaultValue = StringUtil
//                .makeAllWordFirstLetterUpperCase(StringUtil
//                        .toUnderscoreName(getSqlName()));
        StringBuffer sb=new StringBuffer();
        //规则：去掉单词连接符，并且第一个字母大写，同时去掉最后一个单词
        Pattern p = Pattern.compile("[a-zA-Z0-9]+[^[a-zA-Z0-9]$]"); // 
        Matcher m = p.matcher(getSqlName());
        m.reset();
        while (m.find())
        {
            sb.append(StringUtil.changFirstWord(m.group(),StringUtil.toUpperCase));
        }
        return sb.toString();
//        return StringUtil.emptyIf(customClassName, defaultValue);
    }
    public String getTableAlias()
    {
        return StringUtil.emptyIf(getRemarks(), getClassName());
    }
    public String getClassNameLowerCase()
    {
        return getClassName().toLowerCase();
    }
    public String getUnderscoreName()
    {
        return getSqlName().toLowerCase();
    }

    public String getClassNameFirstLower()
    {
        return StringUtil.uncapitalize(getClassName());
    }

    public String getConstantName()
    {
        return StringUtil.toUnderscoreName(getClassName()).toUpperCase();
    }

    public boolean isSingleId()
    {
        return getPkCount() == 1 ? true : false;
    }

    public boolean isCompositeId()
    {
        return getPkCount() > 1 ? true : false;
    }

    public boolean isNotCompositeId()
    {
        return !isCompositeId();
    }

    public int getPkCount()
    {
        int pkCount = 0;
        for (Column c : columns)
        {
            if (c.isPk())
            {
                pkCount++;
            }
        }
        return pkCount;
    }
//    /**
//     * use getPkColumns()
//     * 
//     * @deprecated
//     */
//    public List getCompositeIdColumns()
//    {
//        return getPkColumns();
//    }

    /**
     * 遍历所有列以 获取到主键例，注意，是列对象
     * @return
     */
    public List<Column> getPkColumnList()
    {
        List<Column> results = new ArrayList<Column>();
        for (Column c : getColumns())
        {
            if (c.isPk())
            {
                results.add(c);
            }
        }
        return results;
    }
    
    /**
     * 获取主键列
     * 一般一个表只有一个主键，所以本项目只考虑一个表一个主键的情况,
     * @return
     */
    public Column getPkColumn()
    {
        List<Column> columnList=getPkColumnList();
        if (columnList.isEmpty())
        {
            throw new RuntimeException("表 ["+getSqlName()+"]没有定义外键");
        }
        return columnList.get(0);
    }
    
    /**
     * 获取主键名
     * 一般一个表只有一个主键，所以本项目只考虑一个表一个主键的情况,
     * @return
     */
    public String getPkName()
    {
        List<String> pkNameList=getPkNameList();
        if (pkNameList.isEmpty())
        {
            throw new RuntimeException("表 ["+getSqlName()+"]没有定义外键");
        }
        return pkNameList.get(0);
    }
    

    /**
     * 获取到所有非主键列
     * @return
     */
    public List<Column> getNotPkColumnList()
    {
        List<Column> results = new ArrayList<Column>();
        for (Column c : getColumns())
        {
            if (!c.isPk())
                results.add(c);
        }
        return results;
    }
    
    public Column getIdColumn()
    {
        for (Column c : getColumns())
        {
            if (c.isPk())
                return c;
        }
        return null;
    }

    public void initImportedKeys(DatabaseMetaData meta)
            throws java.sql.SQLException
    {
        
//        System.out.println("catalog: "+catalog);
//        System.out.println("schema: "+schema);
        // get imported keys a
        //外键，即当前表指向别的表
        ResultSet rs = meta.getImportedKeys(catalog, schema, this.sqlName);

        while (rs.next())
        {
            String pkTableName = rs.getString(PKTABLE_NAME);  //主键表表名
            String pkColumnName = rs.getString(PKCOLUMN_NAME);   //主键字段列名
            String fkTableName = rs.getString(FKTABLE_NAME);  //外键表表名
            String fkColumnName = rs.getString(FKCOLUMN_NAME);   //外键字段列名
            String seq = rs.getString(KEY_SEQ);  //一个表可能会有多个外键，此即获取当前是排第几的外键,即外键所在的序列(还有问题)
            Integer iseq = new Integer(seq);
            System.out.println(getClassName()+" 找到指向其它表的外键字段:fktable:  "+fkTableName+" ,pktable: "+pkTableName+" ,  seq: "+seq);
            getImportedKeys().addForeignKey(pkTableName, pkColumnName, fkColumnName, iseq);
        }
        rs.close();
    }

    /**
     * This method was created in VisualAge.
     */
    public void initExportedKeys(DatabaseMetaData meta) throws java.sql.SQLException
    {
        // get Exported keys

        //被指向,即别人指向自己
        ResultSet fkeys = meta.getExportedKeys(catalog, schema, this.sqlName);

        while (fkeys.next())
        {
            //主键表,在此也就是当前表,也就是被指的表,此又叫父表
//            String pktable = fkeys.getString(PKTABLE_NAME);
            //被指的列，如果是主键关联，则此就是主键,此又叫父表列
            String pkcol = fkeys.getString(PKCOLUMN_NAME);
            //外键表，也就是fktable有一个外键列指向pktable表
            String fktable = fkeys.getString(FKTABLE_NAME);
            //外键字段
            String fkcol = fkeys.getString(FKCOLUMN_NAME);
            String seq = fkeys.getString(KEY_SEQ);
            Integer iseq = new Integer(seq);
            getExportedKeys().addForeignKey(fktable, fkcol, pkcol, iseq);
        }
        fkeys.close();
    }

    /**
     * @return Returns the exportedKeys.
     */
    public ForeignKeys getExportedKeys()
    {
        if (exportedKeys == null)
        {
            exportedKeys = new ForeignKeys(this);
        }
        return exportedKeys;
    }
    /**
     * @return Returns the importedKeys.
     */
    public ForeignKeys getImportedKeys()
    {
        if (importedKeys == null)
        {
            importedKeys = new ForeignKeys(this);
        }
        return importedKeys;
    }

    public String toString()
    {
        return "Database Table:" + getSqlName() + " to ClassName:"
                + getClassName();
    }
    public List<String> getPkNameList()
    {
        return pkNameList;
    }
    public void setPkNameList(List<String> pkNameList)
    {
        this.pkNameList = pkNameList;
    }

}
