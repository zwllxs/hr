package com.zwl.core.tag.page.constants;

import com.zwl.core.page.PageInfo;

public class PageConstants
{
    //=========系统的一些默认值===========
    /**
     * 系统默认的每页的查询数目
     */
    public static final int perPageSize=20;
    
    /**
     * 系统默认的每页最小查询数目
     */
    public static final int minPageSize=1;
    
    /**
     * 系统默认的每页最大查询数目
     */
    public static final int maxPageSize=100;
    
    /**
     * 系统默认的修改查询时下拉列表时步长值
     */
    public static final int pageSizeSteps=1;
    
    /**
     * 系统默认采用UTF-8
     */
    public static final String encoding="UTF-8";
    
    /**
     * 系统默认的每页的查询数目
     */
    public static final String perPageSizeKey="zwl.perPageSize";
    
    /**
     * 系统默认的每页最小查询数目
     */
    public static final String minPageSizeKey="zwl.minPageSize";
    
    /**
     * 系统默认的每页最大查询数目
     */
    public static final String maxPageSizeKey="zwl.maxPageSize";
    
    /**
     * 系统默认的修改查询时下拉列表时步长值
     */
    public static final String pageSizeStepsKey="zwl.pageSizeSteps";
    
    /**
     * 系统字符集编码
     */
    public static final String encodingKey="zwl.encoding";
    
    /**
     * 分页
     */
    public static PageInfo pageInfo=null;
    
}
