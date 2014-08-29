package com.zwl.core.service.vo;

import java.util.List;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

/**
 * 智能的多条件查询vo
 * @author wlzhang
 *
 */
public class QueryVo
{
    //页面上接收的属性名
    private String propertyName;
    
    //页面上接收的属性值
    private Object propertyValue;
    
    //查询类型
    private int queryType;
    
    //查询参数数组,它存储的是一些索引号，如第几个属性名，等等
    private List<Integer> paramList;

    public String getPropertyName()
    {
        return propertyName;
    }

    public void setPropertyName(String propertyName)
    {
        this.propertyName = propertyName;
    }

    public Object getPropertyValue()
    {
        return propertyValue;
    }

    public void setPropertyValue(Object propertyValue)
    {
        this.propertyValue = propertyValue;
    }

    public int getQueryType()
    {
        return queryType;
    }

    public void setQueryType(int queryType)
    {
        this.queryType = queryType;
    }

    public List<Integer> getParamList()
    {
        return paramList;
    }

    public void setParamList(List<Integer> paramList)
    {
        this.paramList = paramList;
    }
    
    public String toString()
    {
        return ReflectionToStringBuilder.reflectionToString(this,
                ToStringStyle.MULTI_LINE_STYLE);
    }
}
