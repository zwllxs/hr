package com.zwl.core.service.reflect;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;


/**
 * 用于service操作的util
 * @author zhangweilin
 *
 */
public class ServiceUtil
{

    /**
     * 通过批量删除的id序列,生成对应的po对象列表
     * @throws InvocationTargetException 
     * @throws NoSuchMethodException 
     * @throws IllegalAccessException 
     * @throws InstantiationException 
     * @throws ClassNotFoundException 
     * @throws IllegalArgumentException 
     * @throws SecurityException 
     */
    public static List<?> createList(String[] toDelBat, Class<?> clazz) throws SecurityException, IllegalArgumentException, ClassNotFoundException, InstantiationException, IllegalAccessException, NoSuchMethodException, InvocationTargetException
    {
        List<Object> l=new ArrayList<Object>();
        Object ojb=null;
        for (int i = 0; i < toDelBat.length; i++)
        {
            ojb=ServiceReflect.newInstanceById(clazz, toDelBat[i]);
            l.add(ojb);
        }
        return l;
    }

}
