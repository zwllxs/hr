package com.zwlsoft.service.dao.exception;

/**
 *  
 * @author zhangweilin
 *
 */

public class UnsupportDataTypeException extends Exception
{

    /**
     * 
     */
    private static final long serialVersionUID = 1218895892012682138L;

    /**
     * 
     */
    public UnsupportDataTypeException()
    {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @param message
     * @param cause
     */
    public UnsupportDataTypeException(String message, Throwable cause)
    {
        super(message, cause);
        // TODO Auto-generated constructor stub
    }

    /**
     * @param message
     */
    public UnsupportDataTypeException(String message)
    {
        super(message);
        // TODO Auto-generated constructor stub
    }

    /**
     * @param cause
     */
    public UnsupportDataTypeException(Throwable cause)
    {
        super(cause);
        // TODO Auto-generated constructor stub
    }

}
