package com.zwl.core.service.reflect;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

/**
 * 通过反射做一些自动操作
 * @author zhangweilin
 *
 */
public class ServiceReflect
{
    
    /**
     * 通过类的class和id,构建对象实例
     * @param clazz
     * @param id
     * @return
     * @throws SecurityException
     * @throws IllegalArgumentException
     * @throws ClassNotFoundException
     * @throws InstantiationException
     * @throws IllegalAccessException
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     */
    public static Object newInstanceById(Class<?> clazz,String id) throws SecurityException, IllegalArgumentException, ClassNotFoundException, InstantiationException, IllegalAccessException, NoSuchMethodException, InvocationTargetException
    {
        Object obj=Reflect.newInstance(clazz);
        setId(obj, id);
        return obj;
        
    }
    
    
    @SuppressWarnings("unchecked")
    private static void setId(Object obj,String id) throws SecurityException, NoSuchMethodException, IllegalArgumentException, IllegalAccessException, InvocationTargetException
    {
      //获得对象的类型    
        Class classType=obj.getClass(); 
        
      //获得对象的所有属性    
        Field[] fields=classType.getDeclaredFields();   
        
        for (int i = 0; i < fields.length; i++)
        {
            //获取数组中对应的属性    
            Field field=fields[i]; 
            //属性名
            String fieldName=field.getName();  
            
            //此处只对id属性做处理
            if ("id".equals(fieldName))
            {
                //构建setter和getter
                Method setId=classType.getMethod("setId", new Class[]{field.getType()});  
                Method getId=classType.getMethod("getId", new Class[]{});
                //调用源getter和setter
                setId.invoke(obj, new Object[]{id});
                getId.invoke(obj,new Object[] {});
                break;
            }
        }
    }
}
