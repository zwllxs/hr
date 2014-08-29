package com.zwl.core.service.reflect;

import java.lang.reflect.InvocationTargetException;

/**
 * 通过反射做一些自动操作
 * @author zhangweilin
 *
 */
public class Reflect
{

    /**
     * 通过id和类,获取其实例,但是此实例不会有任何的初始值,只是有一个引用而已
     * @param clazz
     * @return
     * @throws ClassNotFoundException
     * @throws InstantiationException
     * @throws IllegalAccessException
     * @throws SecurityException
     * @throws IllegalArgumentException
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     */
    public static Object newInstance(Class<?> clazz) throws ClassNotFoundException, InstantiationException, IllegalAccessException, SecurityException, IllegalArgumentException, NoSuchMethodException, InvocationTargetException
    {
        Class<?> c=Class.forName(clazz.getName());
        Object obj=c.newInstance();
        return obj;
    }
    
    
    /**
     * 根据指定类名创建对象
     * @param className
     * @return
     * @throws ClassNotFoundException
     * @throws InstantiationException
     * @throws IllegalAccessException
     */
    public static Object newInstance(String className) throws ClassNotFoundException, InstantiationException, IllegalAccessException
    {
        Class<?> c=Class.forName(className);
        Object obj=c.newInstance();
        return obj;
    }
    
    
}
