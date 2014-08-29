package com.zwl.core.service.builder.exception;

/**
 * 构建多条件复杂查询时的异常
 * @author wlzhang
 *
 */
@SuppressWarnings("serial")
public class BuildHqlException extends RuntimeException
{

    /**
     * @param message
     * @param cause
     */
    public BuildHqlException(String message, Throwable cause)
    {
        super(message, cause);
        // TODO Auto-generated constructor stub
    }

    public BuildHqlException(Exception e)
    {
        super(e);
    }

    public BuildHqlException(String s)
    {
        super(s);
    }
}
