package com.zwl.core.db.datasource;

/**
 * 切换要调用的数据源
* DataSourcesHolder.java Create on 2011-4-17     
*      
* Copyright (c) 2011-4-17 by 伟林联游      
*      
* @author zhangweilin <a href="zwllxs@163.com">张伟林</a>     
*
 */
public class DataSourcesHolder
{
    private static final ThreadLocal<String> contextHolder = new ThreadLocal<String>();
    
    /**
     * 切换要调用的数据源，
     * @param param  数据源名称，
     */
    public static void setDataSourceName(String param)
    {
        contextHolder.set(param);
    }

    public static String getDataSourceName()
    {
        return (String) contextHolder.get();
    }

    public static void clearDataSourceName()
    {
        contextHolder.remove();
    }
}
