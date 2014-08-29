package com.zwl.core.db.datasource.exception;

/**      
 * DataSourceException.java Create on 2011-4-17     
 *      
 * Copyright (c) 2011-4-17 by 伟林联游      
 *      
 * @author zhangweilin <a href="zwllxs@163.com">张伟林</a>     
 *     
 */

public class DataSourceException extends RuntimeException
{

    /**
     * 
     */
    private static final long serialVersionUID = 1218895892012682138L;

    /**
     * 
     */
    public DataSourceException()
    {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @param message
     * @param cause
     */
    public DataSourceException(String message, Throwable cause)
    {
        super(message, cause);
        // TODO Auto-generated constructor stub
    }

    /**
     * @param message
     */
    public DataSourceException(String message)
    {
        super(message);
        // TODO Auto-generated constructor stub
    }

    /**
     * @param cause
     */
    public DataSourceException(Throwable cause)
    {
        super(cause);
        // TODO Auto-generated constructor stub
    }

}
