package com.zwl.core.tag.page.exception;

import java.io.IOException;

/**
 * 分页异常
* PageException.java Create on 2011-4-11     
*      
* Copyright (c) 2011-4-11 by wlzhang www.conngame.com   
*      
* @author <a href="zwllxs@163.com">wlzhang</a>     
* @version 1.0 
*
 */
@SuppressWarnings("serial")
public class PageException extends IOException
{

    public PageException()
    {
        super();
        // TODO Auto-generated constructor stub
    }

    public PageException(String message, Throwable cause)
    {
        super(message, cause);
        // TODO Auto-generated constructor stub
    }

    public PageException(String message)
    {
        super(message);
        // TODO Auto-generated constructor stub
    }

    public PageException(Throwable cause)
    {
        super(cause);
        // TODO Auto-generated constructor stub
    }

}
