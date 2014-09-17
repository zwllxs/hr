/*
 * Created on Jan 6, 2005
 *
 */
package cn.zwl.coder.generator.provider.db.model;

import java.util.LinkedHashMap;
import java.util.Map;

import cn.zwl.coder.generator.util.ListHashtable;

/**
 * @author zhangweilin
 * This class contains a list of all the tables for which foreign keys
 * exist for the containing SqlTable. It contains a reference to the parent
 * and also a Hashtable of foreign keys for each table 
 * 可能有多个外键表指向此表,但是每个外键表又可能有多个字段指向此表中的某一字段
 * 目前问题，在生成时拿不到外键
 */
public class ForeignKeys 
{

	protected Table parentTable;
	//可能同时有多个表指向一个表，此即外键集合,它与外键表形成映射关系
	protected ListHashtable associatedTables;
	
	protected Map<String, ForeignKey> foreignKeyMap;
	
	public void setForeignKeyMap(Map<String, ForeignKey> foreignKeyMap)
    {
        this.foreignKeyMap = foreignKeyMap;
    }
    public Map<String, ForeignKey> getForeignKeyMap()
    {
        return foreignKeyMap;
    }
    /**
	 * Constructor for Foreign Keys
	 */
	public ForeignKeys(Table table) {
		super();
		parentTable      = table;
		associatedTables = new ListHashtable();
		
		foreignKeyMap=new LinkedHashMap<String, ForeignKey>();
	}
	/**
	 * @param pkTableName  子表名，也即外键表名
	 * @param pkColumnName 外键字段
	 * @param fkColumnName  主表，也即父表,即被指向的那个列，如果是主键关联，则此一般为主键
	 * @param seq
	 */
	public void addForeignKey(String pkTableName, String pkColumnName,  String fkColumnName, Integer seq)
	{
        ForeignKey foreignKey = null;
        //注意，pkTableName是子表，是它指向当前表
        if (associatedTables.containsKey(pkTableName))
        {
            foreignKey = (ForeignKey) associatedTables.get(pkTableName);
        }
        else
        {
            foreignKey = new ForeignKey(parentTable, pkTableName);
            //一个表可能被多个表同时指向,被一个表指向就是一个外键。所以可能有一个表名对应多个外键的情况
            associatedTables.put(pkTableName, foreignKey);
        }

        //====增加了自己的Map=====
        ForeignKey foreignKey2 = null;
        if (foreignKeyMap.containsKey(pkTableName))
        {
            foreignKey2=foreignKeyMap.get(pkTableName);
        }
        else
        {
            foreignKey2=new ForeignKey(parentTable, pkTableName);
            foreignKeyMap.put(pkTableName, foreignKey2);
        }
        
        //每一个外键：即一个表指向另一表时，可能同时会有多个字段指向另一个中的一个或多个字段(此种情况还没怎么弄明白，此情况干脆先忽略不计)
        foreignKey.addColumn(pkColumnName, fkColumnName, seq);
        foreignKey2.addColumn(pkColumnName, fkColumnName, seq); //自己新加的
	}
	

	/**
	 * @return Returns the associatedTables.
	 */
	public ListHashtable getAssociatedTables() {
		return associatedTables;
	}
	public int getSize() {
		return getAssociatedTables().size();
	}
	public boolean getHasImportedKeyColumn(String aColumn) {
		boolean isFound = false;
		int numKeys = getAssociatedTables().size();
		for (int i=0;i<numKeys;i++) {
			ForeignKey aKey = (ForeignKey) getAssociatedTables().getOrderedValue(i);
			if (aKey.getHasImportedKeyColumn(aColumn)) {
				isFound = true;
				break;
			}
		}
		return isFound;
	}
	public ForeignKey getAssociatedTable(String name) {
		Object fkey = getAssociatedTables().get(name);
		if (fkey != null) {
			return (ForeignKey) fkey;
		}
		else return null;
	}
	/**
	 * @return Returns the parentTable.
	 */
	public Table getParentTable() {
		return parentTable;
	}
	public boolean getHasImportedKeyParentColumn(String aColumn) {
		boolean isFound = false;
		int numKeys = getAssociatedTables().size();
		for (int i=0;i<numKeys;i++) {
			ForeignKey aKey = (ForeignKey) getAssociatedTables().getOrderedValue(i);
			if (aKey.getHasImportedKeyParentColumn(aColumn)) {
				isFound = true;
				break;
			}
		}
		return isFound;
	}
	public ForeignKey getImportedKeyParentColumn(String aColumn) {
		ForeignKey aKey = null;
		int numKeys = getAssociatedTables().size();
		for (int i=0;i<numKeys;i++) {
			aKey = (ForeignKey) getAssociatedTables().getOrderedValue(i);
			if (aKey.getHasImportedKeyParentColumn(aColumn)) {
				break;
			}
		}
		return aKey;
	}
}
