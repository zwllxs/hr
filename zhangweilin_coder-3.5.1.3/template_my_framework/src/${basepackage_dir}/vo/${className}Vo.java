package ${basepackage}.vo;

<#--智能导入Date类型-->
<#assign isDate=false />
<#list table.columns as c>
    <#if c.javaType="Date"&&!isDate>
import java.util.Date;
<#assign isDate=true />
    </#if>
</#list>

/**
 * ${table.remarks}
 * @author zhangweilin
 *
 */
public class ${table.className}Vo 
{
    /**
     * 
     */
    private static final long serialVersionUID = 2136438298510238741L;

<#-- 表的普通字段,即po的普通属性 -->
<#assign isFK=false />
<#list table.columns as c>
    <#--得到当前表所有的外键-->
    <#list table.importedKeys.foreignKeyMap?keys as key>
        <#--得到当前外键的所有外键字段-->
        <#list table.importedKeys.foreignKeyMap[key].fkColumnMap?keys as key2>
            <#--如果外键字段与当前属性名一样，则此属性不输出-->
            <#if table.importedKeys.foreignKeyMap[key].fkColumnMap[key2]?replace('_', '')?lower_case=c.columnName?lower_case>
                <#assign isFK=true />
            </#if>
        </#list>
    </#list>
    <#--如果是主键，也不输出-->
    <#if c.isPK>
         <#assign isFK=true />
    </#if>
<#if isFK=false>
    /**
     * ${c.remarks}
     */
    private ${c.javaType} ${c.columnName?uncap_first};
</#if>
        <#assign isFK=false />
        
</#list>
<#--外键，也即对象引用,在确定对象类型时还是有问题，待解决-->
<#list table.importedKeys.foreignKeyMap?keys as key>
    
    private ${tableMap['tableName_'+key].className}Vo ${tableMap['tableName_'+key].className?uncap_first}Vo;
</#list>

<#--po的普通属性的setter和getter-->
<#assign isFK=false />
<#list table.columns as c>
    <#--得到当前表所有的外键-->
    <#list table.importedKeys.foreignKeyMap?keys as key>
        <#--得到当前外键的所有外键字段-->
        <#list table.importedKeys.foreignKeyMap[key].fkColumnMap?keys as key2>
            <#--如果外键字段与当前属性名一样，则此属性不输出-->
            <#if table.importedKeys.foreignKeyMap[key].fkColumnMap[key2]?replace('_', '')?lower_case=c.columnName?lower_case>
                <#assign isFK=true />
            </#if>
        </#list>
    </#list>
    <#--如果是主键，也不输出-->
    <#if c.isPK>
         <#assign isFK=true />
    </#if>
<#if isFK=false>
    public void set${c.columnName}(${c.javaType} ${c.columnName?uncap_first})
    {
        this.${c.columnName?uncap_first} = ${c.columnName?uncap_first};
    }
    
    public ${c.javaType} get${c.columnName}()
    {
        return ${c.columnName?uncap_first};
    }
</#if>
<#assign isFK=false />
</#list>

<#--外键属性的setter和getter-->
<#list table.importedKeys.foreignKeyMap?keys as key>

    public void set${tableMap['tableName_'+key].className}Vo(${tableMap['tableName_'+key].className}Vo ${tableMap['tableName_'+key].className?uncap_first}Vo)
    {
        this.${tableMap['tableName_'+key].className?uncap_first}Vo = ${tableMap['tableName_'+key].className?uncap_first}Vo;
    }

    public ${tableMap['tableName_'+key].className}Vo get${tableMap['tableName_'+key].className}Vo()
    {
        return ${tableMap['tableName_'+key].className?uncap_first}Vo;
    }
</#list>
}
