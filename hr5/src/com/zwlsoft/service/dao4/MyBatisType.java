package com.zwlsoft.service.dao4;

public class MyBatisType
{
    private String property;
    
    private String sign;
    
    private String cloumn;
    
    private String jdbcType;


    public String getSign()
    {
        return sign;
    }

    public void setSign(String sign)
    {
        this.sign = sign;
    }

    public String getCloumn()
    {
        return cloumn;
    }

    public void setCloumn(String cloumn)
    {
        this.cloumn = cloumn;
    }

    public String getJdbcType()
    {
        return jdbcType;
    }

    public void setJdbcType(String jdbcType)
    {
        this.jdbcType = jdbcType;
    }

    public String getProperty()
    {
        return property;
    }

    public void setProperty(String property)
    {
        this.property = property;
    }

    @Override
    public String toString()
    {
        return "MyBatisType [property=" + property + ", sign=" + sign
                + ", cloumn=" + cloumn + ", jdbcType=" + jdbcType + "]";
    }
    
    
}
