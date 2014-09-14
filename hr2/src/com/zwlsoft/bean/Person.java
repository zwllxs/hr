package com.zwlsoft.bean;

import java.util.List;

/**
 * @author zhangweilin
 */
public class Person
{
    private String name;
    private Integer age;
    private boolean married=true;
    private List<String> roleList;
    private int sex=0;
    private String favoriteBall;
    private String introduction="自我介绍一下";
    

    public String getIntroduction()
    {
        return introduction;
    }

    public void setIntroduction(String introduction)
    {
        this.introduction = introduction;
    }

    public String getFavoriteBall()
    {
        return favoriteBall;
    }

    public void setFavoriteBall(String favoriteBall)
    {
        this.favoriteBall = favoriteBall;
    }

    public int getSex()
    {
        return sex;
    }

    public void setSex(int sex)
    {
        this.sex = sex;
    }

    public List<String> getRoleList()
    {
        return roleList;
    }

    public void setRoleList(List<String> roleList)
    {
        this.roleList = roleList;
    }

    public boolean isMarried()
    {
        return married;
    }

    public void setMarried(boolean married)
    {
        this.married = married;
    }

    public Person()
    {

    }

    public Person(String name, Integer age)
    {
        super();
        this.name = name;
        this.age = age;
    }

    public String getName()
    {
        return name;
    }
    public void setName(String name)
    {
        this.name = name;
    }
    public Integer getAge()
    {
        return age;
    }
    public void setAge(Integer age)
    {
        this.age = age;
    }

}
