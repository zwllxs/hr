package com.zwlsoft.po;

import java.util.HashMap;
import java.util.Map;

import com.zwlsoft.utils.DaoUtil;


public abstract class AbstractEntity implements Entity
{
    
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private Map<String, String> signMap=null;
    public void putSignMap(String key,String value)
    {
        if (null==signMap)
        {
            signMap=new HashMap<String, String>();
        }
        signMap.put(DaoUtil.getColumnName(key), value);
    }
    public Map<String, String> getSignMap()
    {
        return signMap;
    }
//    public void setSignMap(Map<String, String> signMap)
//    {
//        this.signMap = signMap;
//    }
    
    
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
}
