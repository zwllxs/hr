package com.zwl.core.service.hqlbuilder;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
 

/**      
 * QueryConstants.java Create on 2011-5-8     
 *      
 * Copyright (c) 2011-5-8 by 天一
 *      
 * @author zhangweilin <a href="zwllxs@163.com">张伟林</a>     
 *     
 */

public class QueryConstants
{
    
    /**
     * 多条件查询时的查询类型的符号。如like,=,<,>,<=,>=,between,in,order
     */
    public static String selectType="like,=,<,>,<=,>=,between,in,order";
    
    /**
     * 多条件查询时的查询类型的符号列表。如like,=,<,>,<=,>=,between,in,order
     */
    public static List<String> queryTypeList=new ArrayList<String>();
    
    static
    {
        //将查询类型序列化成一个List
        String[] selectTypeArr=selectType.replace(" ", "").trim().split(",");
        queryTypeList=Arrays.asList(selectTypeArr);
    }
    
    
    /**
     * like查询
     */
    public static final int like=0;

    /**
     * 等于
     */
    public static final int equals=1;
    
    /**
     * 小于
     */
    public static final int lessThen=2;
    
    /**
     * 大于
     */
    public static final int greaterThen=3;
    
    /**
     * 小于等于
     */
    public static final int lessThenEquals=4;
    
    /**
     * 大于等于
     */
    public static final int greaterThenEquals=5;
    
    /**
     * 区间
     */
    public static final int between=6;
    
    /**
     * in
     */
    public static final int in=7;
    
    /**
     * order
     */
    public static final int order=8;
    
}
