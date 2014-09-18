package com.zwlsoft.po;

public class Role
{
    private int id;
    
    private String name;    
    
    private String purviewKey;    
    
    private String description;

    public int getId()
    {
        return id;
    }

    public void setId(int id)
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

    public String getPurviewKey()
    {
        return purviewKey;
    }

    public void setPurviewKey(String purviewKey)
    {
        this.purviewKey = purviewKey;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }    
}
