package com.zwl.core.page;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.zwl.core.tag.page.constants.PageConstants;
import com.zwl.core.util.PropertiesUtil;
import com.zwl.core.util.StringUtil;

/**      
 * PagerFactory.java Create on 2011-5-5     
 *      
 * Copyright (c) 2011-5-5 by 天一      
 *      
 * @author zhangweilin <a href="zwllxs@163.com">张伟林</a>     
 * 构建线程安全的PageInfo
 */

public class PagerFactory
{
    private static final ThreadLocal<PageInfo> pageThreadLocal = new ThreadLocal<PageInfo>();
    protected transient static Logger logger = LoggerFactory.getLogger(PagerFactory.class);
    
    /**
     * 
     */
    private PagerFactory()
    {
    }
    
    /**
     * 获取PageInfo接口
     * @return
     */
    public static PageInfo getPageInfo()
    {
        init();
        PageInfo pageInfo0=pageThreadLocal.get();
        if (null==pageInfo0)
        {
            try
            {
                pageThreadLocal.set((PageInfo)PageConstants.pageInfo.clone());
            }
            catch (CloneNotSupportedException e)
            {
                e.printStackTrace();
            }
            pageInfo0=pageThreadLocal.get();
        }
        
        pageInfo0.setPageNo(1);
        return pageInfo0;
    }

    /**
     * 初始化Constants.pageInfo
     */
    private static void init()
    {
        String path=PagerFactory.class.getResource("/").getPath();
        if (null==PageConstants.pageInfo)
        {
            //加载系统配置文件
            PropertiesUtil pu=PropertiesUtil.getPropertiesUtil(path+"page.properties");
            
            //默认每页查询数
            String value = pu.read(PageConstants.perPageSizeKey);
            int pageSize=StringUtil.getInt(value, PageConstants.perPageSize);
            PageConstants.pageInfo=new StdPageInfo(pageSize);
            logger.debug("init pageInfo from "+path+"page.properties");  
        }
    }
}
