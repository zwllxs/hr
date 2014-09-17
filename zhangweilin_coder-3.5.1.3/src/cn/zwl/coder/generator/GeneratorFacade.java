package cn.zwl.coder.generator;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.zwl.coder.generator.provider.db.DbTableFactory;
import cn.zwl.coder.generator.provider.db.model.Table;
import cn.zwl.coder.generator.provider.db.model.TableMap;
import cn.zwl.coder.generator.provider.java.model.JavaClass;
import cn.zwl.coder.generator.util.BeanUtil;
import cn.zwl.coder.generator.util.StringUtil;

/**
 * @author zhangweilin
 */
public class GeneratorFacade
{

    public GeneratorFacade()
    {
        //初始化表配置信息
        initTableConfig();
    }

    /**
     * 初始化表配置信息
     */
    private void initTableConfig()
    {
        //初始化一些必要信息,
        //读取指定表和排除表信息
        String includeTable=GeneratorProperties.getProperty("include.table");
        String excludeTable=GeneratorProperties.getProperty("exclude.table");
        
//        System.out.println("includeTable: "+includeTable);
//        System.out.println("excludeTable: "+excludeTable);
        
        //初始化指定表
        if (!StringUtil.isInvalid(includeTable))
        {
            String[] includeTableArr=includeTable.split(",");
            for (String string : includeTableArr)
            {
                TableMap.includeTableList.add(string.trim());   
            }
        }
        
        //初始化排除表
        if (!StringUtil.isInvalid(excludeTable))
        {
            String[] excludeTableArr=excludeTable.split(",");
            for (String string : excludeTableArr)
            {
                TableMap.excludeTableList.add(string.trim());   
            }
        }
        
//        System.out.println("TableMap.includeTableList: "+TableMap.includeTableList);
//        System.out.println("TableMap.excludeTableList: "+TableMap.excludeTableList);
    }

    /**
     * 打印所有的表名
     * 
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public void printAllTableNames() throws Exception
    {
        List tables = DbTableFactory.getInstance().getAllTables();
        System.out.println("\n----All TableNames BEGIN----");
        for (int i = 0; i < tables.size(); i++)
        {
            String sqlName = ((Table) tables.get(i)).getSqlName();
            System.out.println("g.generateTable(\"" + sqlName + "\");");
        }
        System.out.println("----All TableNames END----");
    }

    /**
     * 生成所有的表
     * 
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public void generateByAllTable() throws Exception
    {
        List<Table> tables = DbTableFactory.getInstance().getAllTables();
        
        //测试
//        Table table=tables.get(0);
//        System.out.println("\n\ngetClassName: "+table.getClassName());
//        Map map=BeanHelper.describe(table); 
//        Set<Entry> s=map.entrySet();
//        for (Entry entry : s)
//        {
//            Object key=entry.getKey();
//            Object value=entry.getValue();
//            System.out.println("key: "+key);
//            System.out.println("value: "+value);
//        }
        
        for (int i = 0; i < tables.size(); i++)
        {
            //生成指定表名的相关模块
//            System.out.println("表名: "+tables.get(i).getSqlName()+" , 注释: "+tables.get(i).getRemarks());
            generateByTable(tables.get(i).getSqlName());
        }
    }

    /**
     * 根据表名,生成相应模块
     * @param tableName
     * @throws Exception
     */
    public void generateByTable(String tableName) throws Exception
    {
        //构建生成器
        Generator g = createGeneratorForDbTable();

        //根据表名得到表,貌似在这里对表进行了重新定义
        Table table = DbTableFactory.getInstance().getTable(tableName);
        generateByTable(g, table);
    }

    /**
     * 根据表准备生成
     * @param g
     * @param table
     * @throws Exception
     */
    private void generateByTable(Generator g, Table table) throws Exception
    {
        //生成器模型，包含模板的所有键值对和文件路径键值对
        GeneratorModel m = GeneratorModel.newFromTable(table);
        String displayText = table.getSqlName() + " => " + table.getClassName();
        generateBy(g, m, displayText);
    }

    public void generateByTable(String tableName, String className)
            throws Exception
    {
        Generator g = createGeneratorForDbTable();
        Table table = DbTableFactory.getInstance().getTable(tableName);
        table.setClassName(className);
        generateByTable(g, table);
    }

    public void generateByClass(Class clazz) throws Exception
    {
        Generator g = createGeneratorForJavaClass();
        GeneratorModel m = GeneratorModel.newFromClass(clazz);
        String displayText = "JavaClass:" + clazz.getSimpleName();
        generateBy(g, m, displayText);
    }

    /**
     * 生成
     * @param g
     * @param m
     * @param displayText
     * @throws Exception
     */
    private void generateBy(Generator g, GeneratorModel m, String displayText) throws Exception
    {
        System.out.println("***************************************************************");
        System.out.println("* BEGIN generate " + displayText);
        System.out.println("***************************************************************");
        List<Exception> exceptions = g.generateBy(m.templateModel,m.filePathModel);
        if (exceptions.size() > 0)
        {
            System.err.println("[Generate Error Summary]");
            for (Exception e : exceptions)
            {
                System.err.println("[GENERATE ERROR]:" + e);
                e.printStackTrace();
            }
        }
    }

    public void clean() throws IOException
    {
        Generator g = createGeneratorForDbTable();
        g.clean();
    }

    /**
     * 为数据库表创建生成器,设置代码生成的相关属性
     * @return
     */
    public Generator createGeneratorForDbTable()
    {
        
        Generator g = new Generator();
        //模板根目录
//        System.out.println("模板根目录 : "+GeneratorProperties.getRequiredProperty("template_dir_root"));
        g.setTemplateRootDir(new File(GeneratorProperties.getRequiredProperty("template_dir_root")).getAbsoluteFile());
        //设置输出目录,值从属性文件中读取而来
        g.setOutRootDir(GeneratorProperties.getRequiredProperty("outRoot"));
        return g;
    }

    private Generator createGeneratorForJavaClass()
    {
        Generator g = new Generator();
        g.setTemplateRootDir(new File("template/javaclass").getAbsoluteFile());
        g.setOutRootDir(GeneratorProperties.getRequiredProperty("outRoot"));
        return g;
    }

    /**
     * 生成器模型
     * @author zhangweilin
     *
     */
    public static class GeneratorModel
    {
        //模板的所有键值对，包括属性配置文件中的所有信息
        public Map templateModel;
        //文件路径的所有键值对，包括属性配置文件中的所有信息
        public Map filePathModel;

        public GeneratorModel(Map templateModel, Map filePathModel)
        {
            super();
            this.templateModel = templateModel;
            this.filePathModel = filePathModel;
        }

        /**
         * 将表对象所有属性及属性文件读入内存,
         * 在编写模板文件时，哪些能生成，哪些不能生成,如何生成，都取决于此
         * @param table
         * @return
         */
        @SuppressWarnings("unchecked")
        public static GeneratorModel newFromTable(Table table)
        {
            //模板模型,即模板文件中的内容， 此能通过table.*的形式取table中的值
            Map templateModel = new HashMap();
            templateModel.putAll(GeneratorProperties.getProperties());//将整个属性文件读入，要知道Properties类也实现了Map接口
            templateModel.put("table", table);//拿到表对象
//            templateModel.putAll(BeanUtil.describe(TableMap.tableMap));//数据库表名与Table对象映射
            templateModel.put("tableMap",TableMap.tableMap);//数据库表名与Table对象映射
            templateModel.put("tablePkName",TableMap.tablePkName);//项目主要主键变量名称,默认值为id
            templateModel.put("tablePkType",TableMap.tablePkType);//项目主要主键变量类型,默认类型为int 

            //文件模型，即文件名本身，在做文件名本身的动态生成时，直接取table里的属性的值，而不通过table.*
            Map filePathModel = new HashMap();
            filePathModel.putAll(GeneratorProperties.getProperties());  //将整个属性文件读入，要知道Properties类也实现了Map接口
            
//            System.out.println("GeneratorProperties.getProperties(): "+GeneratorProperties.getProperties());
            
            filePathModel.putAll(BeanUtil.describe(table));//拿到指定表的所有属性名和属性值
            return new GeneratorModel(templateModel, filePathModel);
        }

        public static GeneratorModel newFromClass(Class clazz)
        {
            Map templateModel = new HashMap();
            templateModel.putAll(GeneratorProperties.getProperties());
            templateModel.put("clazz", new JavaClass(clazz));

            Map filePathModel = new HashMap();
            filePathModel.putAll(GeneratorProperties.getProperties());
            filePathModel.putAll(BeanUtil.describe(clazz));
            return new GeneratorModel(templateModel, filePathModel);
        }
    }
}
