/*
 * Created on Jan 1, 2005
 */
package cn.zwl.coder.generator.provider.db.model;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import cn.zwl.coder.generator.provider.db.DbTableFactory;
import cn.zwl.coder.generator.util.ListHashtable;

/**
 * 外键
 * @author 张伟林
 */
public class ForeignKey
{

    protected String relationShip = null;
    protected String firstRelation = null;
    protected String secondRelation = null;
    protected Table parentTable;
    protected String pkTableName;
    protected ListHashtable columns;
    protected Map<Integer, String> pkColumnMap;

    protected ListHashtable parentColumns;
    protected Map<String, String> parentColumnMap;
    
    /**
     * @return the parentColumnMap
     */
    public Map<String, String> getParentColumnMap()
    {
        return parentColumnMap;
    }
    protected Map<String, String> fkColumnMap;

    public ForeignKey(Table aTable, String pkTableName)
    {
        super();
        parentTable = aTable;
        this.pkTableName = pkTableName;
        columns = new ListHashtable();
        parentColumns = new ListHashtable();
        parentColumnMap=new HashMap<String, String>();
        
        pkColumnMap=new LinkedHashMap<Integer, String>();
        fkColumnMap=new LinkedHashMap<String, String>();
    }
    public String getParentTableName()
    {
        return parentTable.getSqlName();
    }
    /**
     * 每一个外键：即一个表指向另一表时，可能同时会有多个字段指向另一个中的一个或多个字段
     * @param pkColumnName
     * @param seq
     */
    public void addColumn(String pkColumnName, String fkColumnName, Integer seq)
    {
//        System.out.println("找到外键: pkColumnName: "+pkColumnName+" , fkColumnName: "+fkColumnName+" , pkTableName: "+pkTableName);
        columns.put(seq, pkColumnName);
        parentColumns.put(seq, fkColumnName);
        parentColumnMap.put(seq+"", fkColumnName);

        pkColumnMap.put(seq, pkColumnName);
        fkColumnMap.put(seq+"", fkColumnName);
    }
    public String getColumn(String parentCol)
    {
        // return the associated column given the parent column
//        Object key = parentColumns.getKeyForValue(parentCol);
//        String col = (String) columns.get(key);
        
        String col= parentColumnMap.get(parentCol);
        // System.out.println("get Column for" +parentCol);
        // System.out.println("key = "+key);
        // System.out.println("col="+col);
        // System.out.println("ParentColumns = "+parentColumns.toString());
        return col;
    }
    /**
	 * 
	 */
    private void initRelationship()
    {
        firstRelation = "";
        secondRelation = "";
        Table foreignTable = null;
        try
        {
            foreignTable = (Table) DbTableFactory.getInstance().getTable(
                    pkTableName);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        List<Column> parentPrimaryKeys = parentTable.getPkColumnList();
        List<Column> foreignPrimaryKeys = foreignTable.getPkColumnList();

//        if (hasAllPrimaryKeys(parentPrimaryKeys, parentColumns))
        if (hasAllPrimaryKeys(parentPrimaryKeys, parentColumnMap))
        {
            firstRelation = "one";
        }
        else
        {
            firstRelation = "many";
        }

        if (hasAllPrimaryKeys(foreignPrimaryKeys, columns))
        {
            secondRelation = "one";
        }
        else
        {
            secondRelation = "many";
        }

        relationShip = firstRelation + "-to-" + secondRelation;

    }
    private boolean hasAllPrimaryKeys(List<Column> pkeys, Map<String, String> parentColumnMap)
    {
        boolean hasAll = true;
        // if size is not equal then false
        int numKeys = pkeys.size();
        if (numKeys != parentColumnMap.size())
        {
            return false;
        }

        for (int i = 0; i < numKeys; i++)
        {
            Column col =pkeys.get(i);
            String columnName = col.getColumnName();
//            if (!cols.contains(columnName))
            if (!parentColumnMap.containsValue(columnName))
            {
                return false;
            }
        }

        return hasAll;
    }
    public boolean isParentColumnsFromPrimaryKey()
    {
        boolean isFrom = true;
//        List<Column> keys = parentTable.getPkColumnList();
        int numKeys = getParentColumns().size();
        for (int i = 0; i < numKeys; i++)
        {
            String pcol = (String) getParentColumns().getOrderedValue(i);
            if (!primaryKeyHasColumn(pcol))
            {
                isFrom = false;
                break;
            }
        }
        return isFrom;
    }
    private boolean primaryKeyHasColumn(String aColumn)
    {
        boolean isFound = false;
        int numKeys = parentTable.getPkColumnList().size();
        for (int i = 0; i < numKeys; i++)
        {
            Column sqlCol =parentTable.getPkColumnList().get(i);
            String colname = sqlCol.getColumnName();
            if (colname.equals(aColumn))
            {
                isFound = true;
                break;
            }
        }
        return isFound;
    }
    public boolean getHasImportedKeyColumn(String aColumn)
    {
        boolean isFound = false;
        List cols = getColumns().getOrderedValues();
        int numCols = cols.size();
        for (int i = 0; i < numCols; i++)
        {
            String col = (String) cols.get(i);
            if (col.equals(aColumn))
            {
                isFound = true;
                break;
            }
        }
        return isFound;
    }
    /**
     * @return Returns the firstRelation.
     */
    public String getFirstRelation()
    {
        if (firstRelation == null)
            initRelationship();
        return firstRelation;
    }
    public Table getSqlTable()
    {
        Table table = null;
        try
        {
            table = (Table) DbTableFactory.getInstance().getTable(pkTableName);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return table;
    }
    /**
     * @return Returns the parentTable.
     */
    public Table getParentTable()
    {
        return parentTable;
    }
    /**
     * @return Returns the relationShip.
     */
    public String getRelationShip()
    {
        if (relationShip == null)
            initRelationship();
        return relationShip;
    }
    /**
     * @return Returns the secondRelation.
     */
    public String getSecondRelation()
    {
        if (secondRelation == null)
            initRelationship();
        return secondRelation;
    }
    /**
     * @return Returns the parentColumns.
     */
    public ListHashtable getParentColumns()
    {
        return parentColumns;
    }

    public boolean getHasImportedKeyParentColumn(String aColumn)
    {

        boolean isFound = false;
        List cols = getParentColumns().getOrderedValues();
        int numCols = cols.size();
        for (int i = 0; i < numCols; i++)
        {
            String col = (String) cols.get(i);
            if (col.equals(aColumn))
            {
                isFound = true;
                break;
            }
        }
        return isFound;
    }
    public Map<Integer, String> getPkColumnMap()
    {
        return pkColumnMap;
    }
    public void setPkColumnMap(Map<Integer, String> pkColumnMap)
    {
        this.pkColumnMap = pkColumnMap;
    }
    public ListHashtable getColumns()
    {
        return columns;
    }
    public Map<String, String> getFkColumnMap()
    {
        return fkColumnMap;
    }
    public String getPkTableName()
    {
        return pkTableName;
    }
}
