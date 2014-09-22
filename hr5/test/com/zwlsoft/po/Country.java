package com.zwlsoft.po;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.zwlsoft.service.dao4.NotCloumn;

/**
 * Description: Country Author: liuzh Update: liuzh(2014-06-06 13:38)
 */
public class Country extends AbstractEntity
{
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private Integer id;
    
    @NotCloumn
    private Integer id2;
    private String countryName;
    private String countryCode;
    
    @NotCloumn
    private Date date;//=new Date();
    private List<Role> roleList=new ArrayList<Role>();
    private Set<String> strSet=new HashSet<>();

    public Country()
    {
        // System.out.println("能调吗？");
//        setAllMethodList();
        // System.out.println("调完");

    }
 
    public String getCountryName()
    {
        return countryName;
    }

    public void setCountryName(String countryName)
    {
        this.countryName = countryName;
    }

    public String getCountryCode()
    {
        return countryCode;
    }

    public void setCountryCode(String countryCode)
    {
        this.countryCode = countryCode;
    }

    public Date getDate()
    {
        return date;
    }

    public void setDate(Date date)
    {
        this.date = date;
    }

    public List<Role> getRoleList()
    {
        return roleList;
    }

    public void setRoleList(List<Role> roleList)
    {
        this.roleList = roleList;
    }

    public Set<String> getStrSet()
    {
        return strSet;
    }

    public void setStrSet(Set<String> strSet)
    {
        this.strSet = strSet;
    }

    public Integer getId2()
    {
        return id2;
    }

    public void setId2(Integer id2)
    {
        this.id2 = id2;
    }

    public Integer getId()
    {
        return id;
    }

    public void setId(Integer id)
    {
        this.id = id;
    }
 
}
