package com.zwlsoft.po;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.zwlsoft.service.dao.MyBatisType;
import com.zwlsoft.utils.DaoUtil;

/**
 * 所有po父类
 * @author zhangweilin
 *
 */
public abstract class AbstractEntity implements Entity
{
    
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    /**
     * 对应的操作符号 
     */
    private Map<String, String> signMap=null;
    /**
     * 是否自动sql
     */
    private boolean isAutoSql;
    
    /**
     * id集合，用来做in处理，一般为查询
     */
    private Serializable[] ids;
//    private List<Integer> idList;
    
    /**
     * 用来生成所有字段
     */
    private List<MyBatisType> allMybatisTypeList=null;
    /**
     * 用来生成有值的字段
     */
    private List<MyBatisType> hasValueMybatisTypeList=null;
    
    public void putSignMap(String key,String value)
    {
        if (null==signMap)
        {
            signMap=new HashMap<String, String>();
        }
        signMap.put(DaoUtil.getColumnName(key), value);
//        System.out.println("signMap: "+signMap);
    }
    public Map<String, String> getSignMap()
    {
        return signMap;
    }
//    public void setSignMap(Map<String, String> signMap)
//    {
//        this.signMap = signMap;
//    }
    public List<MyBatisType> getAllMybatisTypeList()
    {
        return allMybatisTypeList;
    }
    public void setAllMybatisTypeList(List<MyBatisType> allMybatisTypeList)
    {
        System.out.println("setAllMybatisTypeList: "+allMybatisTypeList);
        this.allMybatisTypeList = allMybatisTypeList;
    }
    public List<MyBatisType> getHasValueMybatisTypeList()
    {
        return hasValueMybatisTypeList;
    }
    public void setHasValueMybatisTypeList(List<MyBatisType> hasValueMybatisTypeList)
    {
        this.hasValueMybatisTypeList = hasValueMybatisTypeList;
    }
    public boolean isAutoSql()
    {
        return isAutoSql;
    }
    
    public void setAutoSql(boolean isAutoSql)
    {
        this.isAutoSql = isAutoSql;
    }
//    public int[] getIds()
//    {
//        return ids;
//    }
//    public void setIds(int[] ids)
//    {
//        this.ids = ids;
//    }
//    public Integer[] getIds()
//    {
//        return ids;
//    }
//    public void setIds(Integer[] ids)
//    {
//        this.ids = ids;
//    }
//    public List<Integer> getIdList()
//    {
//        return idList;
//    }
//    public void setIdList(List<Integer> idList)
//    {
//        this.idList = idList;
//    }
//    public Integer[] getIds()
//    {
//        return ids;
//    }
//    public void setIds(Integer[] ids)
//    {
//        this.ids = ids;
//    }  
// 
//    
//    private Field[] fieldArr;
//
//    private Map<String, Object> keyValuesMap =null;
//
//    protected Field[] setAllMethodList()
//    {
//        Field[] field = this.getClass().getDeclaredFields(); // 获取实体类的所有属性，返回Field数组
//        this.fieldArr = field;
//        return field;
//    }
//
//    public void buildKeyValues() throws IntrospectionException, IllegalAccessException, IllegalArgumentException, InvocationTargetException
//    {
//        if (null==keyValuesMap)
//        {
//            keyValuesMap = new HashMap<String, Object>();
//        }
//        else
//        {
//            return;
//        }
//        for (Field field : fieldArr)
//        {
//            PropertyDescriptor pd = new PropertyDescriptor(field.getName(),
//                    this.getClass());
//            Method getMethod = pd.getReadMethod();// 获得get方法
//            Object o = getMethod.invoke(this);// 执行get方法返回一个Object
//            System.out.println("o: "+o);
////            if (o instanceof Integer)
////            {
////                System.out.println("int类型");
////            }
////            else
////            {
//                keyValuesMap.put(field.getName(), o);
////            }
//        }
//    }
//
//    public Map<String, Object> getKeyValuesMap() throws IllegalAccessException, IllegalArgumentException, InvocationTargetException, IntrospectionException
//    {
//        System.out.println("getKeyValuesMap调用 : ");
//        if (null==keyValuesMap)
//        {
//            buildKeyValues();
//        }
//        return keyValuesMap;
//    }
//
//    public Field[] getFieldArr()
//    {
//        return fieldArr;
//    }
//
//    public void setKeyValuesMap(Map<String, Object> keyValuesMap)
//    {
//        this.keyValuesMap = keyValuesMap;
//    }
    public Serializable[] getIds()
    {
        return ids;
    }
    public void setIds(Serializable[] ids)
    {
        this.ids = ids;
    }
}
