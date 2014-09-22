package com.zwlsoft.utils;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.MethodUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;

import com.zwlsoft.exception.UnsupportDataTypeException;
import com.zwlsoft.service.dao4.DaoConstant;
import com.zwlsoft.service.dao4.MyBatisType;
import com.zwlsoft.service.dao4.NotCloumn;



/**
 * 
 * @author zhangweilin
 *
 */
public class DaoUtil
{
    private static Map<String, String> javaJdbcTypeMap=new HashMap<>();
   

    public static Field[] getAllFieldList(Object o)
    {
        return getAllFieldList(o.getClass());
    }
    
    public static Field[] getAllFieldList(Class clazz)
    {
//        List<String> fieldList = new ArrayList<>();
        Field[] field =clazz.getDeclaredFields(); // 获取实体类的所有属性，返回Field数组
//        System.out.println("field: " + field);
//        field=(Field[]) ArrayUtils.removeElement(field, "serialVersionUID");
        for (int i = 0; i < field.length; i++)
        {
//            System.out.println("field: "+field[i].getName());
            if ("serialVersionUID".equals(field[i].getName()))
            {
                field= (Field[]) ArrayUtils.removeElement(field, field[i]);
                break;
            }
        }
        
//        for (int i = 0; i < field.length; i++)
//        {
//            System.out.println("field: "+field[i].getName());
//        }
        return field;
    }
    
    /**
     * 获取有值的key values map ,拼接mybatis的动态 sql语句
     * @param obj
     * @return
     * @throws IntrospectionException
     * @throws IllegalAccessException
     * @throws IllegalArgumentException
     * @throws InvocationTargetException
     * @throws SecurityException 
     * @throws NoSuchFieldException 
     * @throws UnsupportDataTypeException 
     */
    @Deprecated
    public static Map<String, Map<String, String>> getStatementKeyValuesMap(Object obj) throws IntrospectionException, IllegalAccessException, IllegalArgumentException, InvocationTargetException, NoSuchFieldException, SecurityException, UnsupportDataTypeException 
    {
        Map<String,  Map<String, String>> keyValuesMap=new HashMap<String, Map<String, String>>();
//        Map<String, String[]> keyValuesMap=new HashMap<>();
        Field[] fieldArr=getAllFieldList(obj);
        for (Field field : fieldArr)
        {
//            System.out.println();
            PropertyDescriptor pd = new PropertyDescriptor(field.getName(),
                    obj.getClass());
            Method getMethod = pd.getReadMethod();// 获得get方法
            Object o = getMethod.invoke(obj);// 执行get方法返回一个Object
//            System.out.println("取值: name: "+field.getName()+" ,value: "+o);
//            if (null!=o)
//            {
//                System.out.println("类型: " + o.getClass().getSimpleName());
//            }
            //            boolean isPrimitive= o.getClass().isPrimitive();
//            Field type=o.getClass().getField("TYPE");
//            System.out.println("type: "+type);
//            Object o2=o.getClass().getField("TYPE").get(null);
//            System.out.println("o2: "+o2);
//            boolean isPrimitive= ((Class)o2).isPrimitive();
//            boolean isPrimitiveNull=getIsNullPrimitive(o);
//            Map<String, String> valuesMap=getValuesMap(field.getName(),o);
//            System.out.println("name: "+field.getName());

            checkIsPrimitive(obj,field);
            if (null != o)
            {
                Map<String, String> jdbcJavaTypeMap = getTypeValuesMap(field,o);
                if (null != jdbcJavaTypeMap)
                {
                    // System.out.println("field.getName(): "+field.getName());
                    // System.out.println("isPrimitive: "+isPrimitive);
                    //此处key为数据库字段名字
                    keyValuesMap.put(getColumnName(field.getName()), jdbcJavaTypeMap);
//                    keyValuesMap.put(field.getName(), new String[]{"22","333"});
                }
            }
        }
        return keyValuesMap;
    }

    /**
     * 获取属性名字和属性值
     * @param obj
     * @return
     * @throws IntrospectionException 
     * @throws InvocationTargetException 
     * @throws IllegalArgumentException 
     * @throws IllegalAccessException 
     * @throws NoSuchMethodException 
     * @throws UnsupportDataTypeException 
     */
    @Deprecated
    public static Map<String, Object> getKeyValuesMap(Object obj) throws IntrospectionException, IllegalAccessException, IllegalArgumentException, InvocationTargetException, NoSuchMethodException, UnsupportDataTypeException
    {
        
        List<MyBatisType> myBatisTypeList=new ArrayList<>();
        Map<String, Object>  map=new HashMap<>();
        Map<String, String> signMap=(Map<String, String>) MethodUtils.invokeMethod(obj, "getSignMap", null);
//      System.out.println("signMap: "+signMap);
        map.put(DaoConstant.signMapKey, signMap);
      
        Field[] fieldArr=getAllFieldList(obj);
        for (Field field : fieldArr)
        {
//            System.out.println();
            PropertyDescriptor pd = new PropertyDescriptor(field.getName(),
                    obj.getClass());
            Method getMethod = pd.getReadMethod();// 获得get方法
            Object o = getMethod.invoke(obj);// 执行get方法返回一个Object
            checkIsPrimitive(obj,field);  //禁止使用基础类型
            if (null!=o)
            {
//                System.out.println("类型 : "+o.getClass().getSimpleName());
                String jdbcType=javaJdbcTypeMap.get(o.getClass().getSimpleName());
                if (null!=javaJdbcTypeMap.get(o.getClass().getSimpleName()))
                {
                    //借道构建下list试试
                    MyBatisType myBatisType=new MyBatisType();
                    String sign=signMap.get(field.getName());
                    myBatisType.setCloumn(getColumnName(field.getName()));
                    myBatisType.setJdbcType(jdbcType);
                    myBatisType.setProperty(field.getName());
                    myBatisType.setSign(StringUtils.isNotEmpty(sign)?sign:"=");
//                    System.out.println("myBatisType: "+myBatisType);
                    myBatisTypeList.add(myBatisType);
                   
                    map.put(field.getName(), o);
                }
            }
        }
        MethodUtils.invokeMethod(obj, "setMyBatisTypeList", myBatisTypeList);
        return map;
    }
    
    /**
     * 给指定的bean生成 mybatis sql语句中必须的串
     * @param obj
     * @throws IntrospectionException
     * @throws IllegalAccessException
     * @throws IllegalArgumentException
     * @throws InvocationTargetException
     * @throws NoSuchMethodException
     * @throws UnsupportDataTypeException 
     */
    public static void setMyBatisType(Object obj) throws IntrospectionException, IllegalAccessException, IllegalArgumentException, InvocationTargetException, NoSuchMethodException, UnsupportDataTypeException
    {
        List<MyBatisType> HasValueMybatisTypeList=new ArrayList<>();//不包括非持久字段
        List<MyBatisType> allMybatisTypeList=new ArrayList<>();
        Map<String, String> signMap=(Map<String, String>) MethodUtils.invokeMethod(obj, "getSignMap", null);

        Field[] fieldArr=getAllFieldList(obj);
        for (Field field : fieldArr)
        {
//            System.out.println();
//            NotCloumn annotaion = field.getAnnotation(NotCloumn.class);
//            System.out.println("name: "+field.getName()+ ", annotaion: "+annotaion);
            PropertyDescriptor pd = new PropertyDescriptor(field.getName(),
                    obj.getClass());
            Method getMethod = pd.getReadMethod();// 获得get方法
            Object o = getMethod.invoke(obj);// 执行get方法返回一个Object
//            System.out.println("o.getClass().getName(): "+o.getClass().getName());
//            System.out.println("field.getType().getName(): "+field.getType().getName());
            String classType=field.getType().getSimpleName();
            
            checkIsPrimitive(obj,field);  //禁止使用基础类型

//          System.out.println("类型 : "+o.getClass().getSimpleName());
            String jdbcType=javaJdbcTypeMap.get(classType);
            if (null!=javaJdbcTypeMap.get(classType))
            {
                MyBatisType myBatisType=new MyBatisType();
                myBatisType.setCloumn(getColumnName(field.getName()));
                myBatisType.setProperty(field.getName());
                
                if (null!=o)
                {
                    String sign=signMap.get(field.getName());
                   
                    myBatisType.setJdbcType(jdbcType);
                    myBatisType.setSign(StringUtils.isNotEmpty(sign)?sign:"=");
//                    System.out.println("myBatisType: "+myBatisType);
                    HasValueMybatisTypeList.add(myBatisType);
                }
                
                NotCloumn annotaion = field.getAnnotation(NotCloumn.class);
                if (null==annotaion||!annotaion.value())
                {
                    allMybatisTypeList.add(myBatisType);
                }
            }
        }
        //注入有值的不为空的typeList
        MethodUtils.invokeMethod(obj, "setHasValueMybatisTypeList", HasValueMybatisTypeList);
        //注入所有字段与属性的映射对
        MethodUtils.invokeMethod(obj, "setAllMybatisTypeList", allMybatisTypeList);
    }
    
    private static Map<String, String> getTypeValuesMap(Field field,Object o) throws UnsupportDataTypeException
    {
        String typeName=o.getClass().getSimpleName();
//        System.out.println("typeName: "+typeName);
        String jdbcType=javaJdbcTypeMap.get(typeName);
        if (StringUtils.isEmpty(jdbcType))
        {
//            throw new UnsupportDataTypeException("自动装配类型不支持: "+o.getClass());
            return null;
        }
        Map<String, String> map=new HashMap<>();
        map.put(DaoConstant.nameKey,field.getName());
        map.put(DaoConstant.typeKey, "#{"+field.getName()+",jdbcType="+jdbcType+"}");
        return map;
    }
    
    public static String getColumnName(String str)
    {
        //"countryNameNameNameNameNameNameName"
        if (StringUtils.isNotEmpty(str))
        {
            return str.replaceAll("([a-z]+)?([A-Z][a-z]+)","$1_$2").toLowerCase();
        }
        return "";
    }

    private static void checkIsPrimitive(Object obj, Field field) throws UnsupportDataTypeException 
    {
        if (field.getType().isPrimitive())
        {
            throw new UnsupportDataTypeException("不支持基础类型："+field.getType().getName()+",类名: "+obj.getClass()+", 属性名: "+field.getName());
        }
    }
    
    /**
     * 是否是基础类型
     * @param o
     * @return
     * @throws IllegalArgumentException
     * @throws IllegalAccessException
     * @throws NoSuchFieldException
     * @throws SecurityException
     */
//    private static boolean checkIsPrimitive(Object o) 
//    {
//       
//        if (null==o)
//        {
//            return true;
//        }
//        try
//        {
//            System.out.println("判断类型:  "+o.getClass());
//            System.out.println("TYPE:  "+o.getClass().getField("TYPE"));
//            Object o2=o.getClass().getField("TYPE").get(null);
//            System.out.println("基础类型为:  "+o2);
//            boolean isPrimitive=((Class)o2).isPrimitive();
//            System.out.println("是否是基础上类型: "+isPrimitive);
//        }
//        catch (IllegalArgumentException | IllegalAccessException
//                | NoSuchFieldException | SecurityException e)
//        {
//            System.out.println("没有Type的类型:  "+o.getClass());
////            e.printStackTrace();
//        }
        
//        if (o instanceof Integer)
//        {
////            System.out.println("是int");
////            if (0==(int)o)
////            {
////                return true;
////            }
////            return false;
//            
//            System.out.println("o2222: "+o2);
//            System.out.println("o333: "+o2.getClass().isPrimitive());
//            if (o2.getClass().isPrimitive())
//            {
//                System.out.println("是基础类型");
//            }
//        }
//        else if(o instanceof Double)
//        {
//            if (0==(double)o)
//            {
//                return true;
//            }
//            return false;
//        }
//        else if(o instanceof Float)
//        {
//            if (0==(float)o)
//            {
//                return true;
//            }
//            return false;
//        }
//        else if(o instanceof Long)
//        {
//            if (0==(long)o)
//            {
//                return true;
//            }
//            return false;
//        }
//        else if(o instanceof Short)
//        {
//            if (0==(short)o)
//            {
//                return true;
//            }
//            return false;
//        }
//        else if(o instanceof Byte)
//        {
//            if (0==(byte)o)
//            {
//                return true;
//            }
//            return false;
//        }
//        String classType=o.getClass().getSimpleName();
//        String[] typeArr= {"String","Date"};
//        for (String type : typeArr)
//        {
//            if (type.equals(classType))
//            {
//                return false;
//            }
//        } 
//        
//        return false;
//    }
    static
    {
        javaJdbcTypeMap.put("Integer", "INTEGER");
        javaJdbcTypeMap.put("String", "VARCHAR");
        javaJdbcTypeMap.put("BigDecimal", "DECIMAL");
        javaJdbcTypeMap.put("BOOLEAN", "BOOLEAN");
        javaJdbcTypeMap.put("byte", "TINYINT");
        javaJdbcTypeMap.put("short", "SMALLINT");
        javaJdbcTypeMap.put("long", "BIGINT");
        javaJdbcTypeMap.put("float", "REAL");
        javaJdbcTypeMap.put("double", "FLOAT");
        javaJdbcTypeMap.put("Date", "TIMESTAMP");
    }
    
    
}
