package cn.zwl.coder.generator.provider.db.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.zwl.coder.generator.GeneratorProperties;
import cn.zwl.coder.generator.util.StringUtil;
/**
 * 此可能称作系统变量表
 * @author zhangweilin
 *
 */
public class TableMap
{
    /**
     * 通过表名得到对应的表对象
     */
    public static final Map<String, Table> tableMap=new HashMap<String, Table>();
    
    /**
     * 读取配置文件中include.table的值
     */
    public static final List<String> includeTableList=new ArrayList<String>();
    
    /**
     * 读取配置文件中exclude.table的值
     */
    public static final List<String> excludeTableList=new ArrayList<String>();
    
    /**
     * 项目主要主键变量名称,默认值为id
     */
    public static final String tablePkName=StringUtil.emptyIf(GeneratorProperties.getProperty("table.pk.name"), "id");
    
    /**
     * 项目主要主键变量类型,默认类型为int
     */
    public static final String tablePkType=StringUtil.emptyIf(GeneratorProperties.getProperty("table.pk.type"), "int");
}
