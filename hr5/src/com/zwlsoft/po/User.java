package com.zwlsoft.po;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;

/**
 * 用户
 * @author zhangweilin
 *
 */
public class User extends AbstractEntity
{
    /**
     * 
     */
    private static final long serialVersionUID = 2136438298510238741L;
    
    public User()
    {
        // TODO Auto-generated constructor stub
    }
    
    public User(String userName, String password)
    {
        super();
        this.userName = userName;
        this.password = password;
    }

    /**
     * 
     */
    private Integer id;
        
    /**
     * 
     */
    private String name;
        
    /**
     * 
     */
//    @NotEmpty(message = "{user.name.error}")
    @NotEmpty(message = "用户名不能为空")
    private String userName;
        
    /**
     * 
     */
    private String password;
        
    /**
     * 
     */
    private String description;
        
    /**
     * 
     */
    private Date addTime;
        
    /**
     * 
     */
    private Date lastLoginTime;
        
    /**
     * 
     */
    private Date currLoginTime;
        
    /**
     * 
     */
    private Integer status;

    public Integer getId()
    {
        return id;
    }

    public void setId(Integer id)
    {
        this.id = id;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getUserName()
    {
        return userName;
    }

    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    public String getPassword()
    {
        return password;
    }

    public void setPassword(String password)
    {
        this.password = password;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public Date getAddTime()
    {
        return addTime;
    }

    public void setAddTime(Date addTime)
    {
        this.addTime = addTime;
    }

    public Date getLastLoginTime()
    {
        return lastLoginTime;
    }

    public void setLastLoginTime(Date lastLoginTime)
    {
        this.lastLoginTime = lastLoginTime;
    }

    public Date getCurrLoginTime()
    {
        return currLoginTime;
    }

    public void setCurrLoginTime(Date currLoginTime)
    {
        this.currLoginTime = currLoginTime;
    }

    public Integer getStatus()
    {
        return status;
    }

    public void setStatus(Integer status)
    {
        this.status = status;
    }
        
 
}
