package com.zwl.core.db.datasource.aop;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

/**      
 * DataSourceName.java Create on 2011-4-19     
 *      
 * Copyright (c) 2011-4-19 by 伟林联游      
 *      
 * @author zhangweilin <a href="zwllxs@163.com">张伟林</a>     
 *     
 */

/**
 * 定义源注释
 * 此采用源注释的方式来切换数据源
 */
@Retention(RetentionPolicy.RUNTIME)   
public @interface DataSourceName
{
    /**
     * 接收源注释里的指定的值
     * @return
     */
    public String name();
}
