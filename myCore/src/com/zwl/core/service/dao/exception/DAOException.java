package com.zwl.core.service.dao.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;

/**
 * @author zhangweilin
 */
public class DAOException extends DataAccessException
{
    private static final long serialVersionUID = 2037965146165551242L;
    protected final Logger logger = LoggerFactory.getLogger(getClass());

    /**
     * @param message
     */
    public DAOException(String message)
    {
        super(message);
        logger.error(message);
    }
    
    /**
     * @param message
     * @param cause
     */
    public DAOException(String message, Throwable cause)
    {
        super(message, cause);
        logger.error(message,cause);
    }
}
