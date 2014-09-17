package ${basepackage}.action.base;

import java.util.List;

import ${basepackage}.po.${table.className};
import ${basepackage}.service.${table.className}Service;
import ${basepackage}.vo.${table.className}Vo;

/**
 * ${table.remarks}BaseAction
 *  @author zhangweilin
 */
public class ${table.className}ActionBase extends BaseAction
{

    /**
     * 
     */
    private static final long serialVersionUID = 3461050133727271908L;
    
    <#--单独对象-->
    protected ${table.className} ${table.className?uncap_first};
    <#--对象列表-->
    protected List<${table.className}> ${table.className?uncap_first}List;
    <#--vo对象-->
    protected ${table.className}Vo ${table.className?uncap_first}Vo;
    <#--相应的Service接口对象-->
    protected ${table.className}Service ${table.className?uncap_first}Service;
    
    <#--如果当前表的主键类型或名称与系统定义的不一样，则在各自的BaseAction中生成各自的主键-->
    <#if tablePkName!=table.pkName||tablePkType!=table.pkColumn.javaType>
    protected ${table.pkColumn.javaType} ${table.pkName?uncap_first};
    
    </#if>
    
    <#--setter和getter-->
    public ${table.className} get${table.className}()
    {
        return ${table.className?uncap_first};
    }
    public void set${table.className}(${table.className} ${table.className?uncap_first})
    {
        this.${table.className?uncap_first} = ${table.className?uncap_first};
    }
    public List<${table.className}> get${table.className}List()
    {
        return ${table.className?uncap_first}List;
    }
    public void set${table.className}List(List<${table.className}> ${table.className?uncap_first}List)
    {
        this.${table.className?uncap_first}List = ${table.className?uncap_first}List;
    }
    public ${table.className}Vo get${table.className}Vo()
    {
        return ${table.className?uncap_first}Vo;
    }
    public void set${table.className}Vo(${table.className}Vo ${table.className?uncap_first}Vo)
    {
        this.${table.className?uncap_first}Vo = ${table.className?uncap_first}Vo;
    }
    public void set${table.className}Service(${table.className}Service ${table.className?uncap_first}Service)
    {
        this.${table.className?uncap_first}Service = ${table.className?uncap_first}Service;
    }
    
    <#--如果当前表的主键类型或名称与系统定义的不一样，则在各自的BaseAction中生成各自的主键setter-->
    <#if tablePkName!=table.pkName||tablePkType!=table.pkColumn.javaType>
    public void set${table.pkName?cap_first}(${table.pkColumn.javaType} ${table.pkName?uncap_first})
    {
        this.${table.pkName?uncap_first}=${table.pkName?uncap_first};
    }
    
    </#if>
    
}
