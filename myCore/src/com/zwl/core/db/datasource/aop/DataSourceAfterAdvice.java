package com.zwl.core.db.datasource.aop;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

import org.springframework.aop.AfterReturningAdvice;
import org.springframework.aop.ThrowsAdvice;

import com.zwl.core.db.datasource.DataSourcesHolder;

/**
 * 事务后
* DataSourceAfterAdvice.java Create on 2011-4-19     
*      
* Copyright (c) 2011-4-19 by 伟林联游      
*      
* @author zhangweilin <a href="zwllxs@163.com">张伟林</a>     
*
 */
public class DataSourceAfterAdvice implements AfterReturningAdvice,
        ThrowsAdvice
{

    /**
     * 后拦截，清除无错误情况下的当前线程信息(回复默认DataSource)。
     */
    public void afterReturning(Object returnObj, Method method, Object[] args,
            Object targetObj) throws Throwable
    {
//        System.out.println("DataSourceAfterAdvice: afterReturning");
        clear(method);
    }

    /**
     * 异常拦截，清除存在异常情况下的当前线程信息(回复默认DataSource)。
     * 
     * @param method
     * @param args
     * @param target
     * @param throwable
     */
    public void afterThrowing(Method method, Object[] args, Object target,
            RuntimeException throwable)
    {
        clear(method);
    }

    private void clear(Method method)
    {
        // 销毁当前线程数据源
        Annotation[] annotation = method.getAnnotations();
        for (Annotation tag : annotation)
        {
//            System.out.println("before: "+((DataSourceName) tag).name());
            if (((DataSourceName) tag).name() != null)
            {
                DataSourcesHolder.clearDataSourceName();
            }
        }
    }
}
