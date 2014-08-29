package com.zwl.core.db.datasource.aop;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

import org.springframework.aop.MethodBeforeAdvice;

import com.zwl.core.db.datasource.DataSourcesHolder;

/**
 * 
* SessionBeforeAdvice.java Create on 2011-4-19     
*      
* Copyright (c) 2011-4-19 by 伟林联游      
*      
* @author zhangweilin <a href="zwllxs@163.com">张伟林</a>     
* 事务前
 */
public class SessionBeforeAdvice implements MethodBeforeAdvice
{

    public void before(Method method, Object[] args, Object targetObj) throws Throwable
    {
//        System.out.println("SessionBeforeAdvice: before");

        /**
         * 根据注释参数设置当前DataSource
         */
        Annotation[] annotation = method.getAnnotations();
//        System.out.println("annotation: "+annotation.length);
        for (Annotation tag : annotation)
        {
            String temp = ((DataSourceName) tag).name();
//            System.out.println("before: "+temp);
            if (temp != null)
            {
                DataSourcesHolder.setDataSourceName(temp);
            }
        }

    }

}
