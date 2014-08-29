package com.zwl.core.db.datasource;

import java.io.File;
import java.lang.reflect.InvocationTargetException;
import java.net.URL;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Set;

import javax.sql.DataSource;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.ArrayUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

import com.zwl.core.db.datasource.exception.DataSourceException;
import com.zwl.core.db.datasource.reflect.Reflect;
import com.zwl.core.util.PropertiesUtil;
import com.zwl.core.util.StringUtil;

/**
 * 动态数据源,启动时初始化，使用时切换
* DynamicDataSource.java Create on 2011-4-17     
*      
* Copyright (c) 2011-4-17 by 伟林联游      
*      
* @author zhangweilin <a href="zwllxs@163.com">张伟林</a>     
*
 */
public class DynamicDataSource extends AbstractRoutingDataSource
{
    private static final Logger logger = LoggerFactory.getLogger(DynamicDataSource.class);
    private static final Map<String, DataSource> dataSourceMap = new HashMap<String, DataSource>();
    
    //优先查找根目录
    private static final String path="jdbc.properties";
    private static final String path2="conf"+File.separator+"jdbc.properties";

    private static final String proxyIpKey="proxy.ip";
    private static final String proxyPortKey="proxy.port";
    
    
    
    /**
     * 
     */
    public DynamicDataSource()
    {
//        System.out.println("创建DynamicDataSource: ");
    }
    
    private static final String dataSourceNameSetName="dataSourceNameSet";
    @Override
    protected Object determineCurrentLookupKey()
    {
        return DataSourcesHolder.getDataSourceName();
    }

    /**
     * 
     */
    @Override
    public void afterPropertiesSet()
    {
//        System.out.println("调用afterPropertiesSet 2");
        URL url=getClass().getClassLoader().getResource("");
        if (null==url)
        {
            throw new DataSourceException("获取环境路径错误，请把相关的那个核心包放到项目的lib下去");
        }
        logger.debug("path2: "+path2);
//        String filePath=url.getFile().substring(1)+path;
        String filePath=url.getFile()+path;
        logger.debug("尝试读取 "+filePath);
//        System.out.println("filePath: "+filePath);
        File file=new File(filePath);
        if (!file.exists())
        {
            String path0=filePath;
//            filePath=url.getFile().substring(1)+path2;
            filePath=url.getFile()+path2;
            logger.debug(path0+" 找不到，尝试读取 "+filePath);
            File file2=new File(filePath);
            if (!file2.exists())
            {
                logger.error(filePath+" 仍然找不到...");
            }
            
        }
        else
        {
            logger.debug("找到 "+filePath+", 开始加载...");
        }
//        System.out.println("filePath2: "+filePath);
        try
        {
            initDataSources(filePath);
        }
        catch (ClassNotFoundException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (InstantiationException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (IllegalAccessException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (InvocationTargetException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        super.afterPropertiesSet();
    }
    /**
     * 从现有的数据源池中获取数据源，如果没有，则返回被设置为默认的那个数据源
     */
    @Override
    protected DataSource determineTargetDataSource()
    {
//        System.out.println("调用determineTargetDataSource");
        String dataSourceKey=(String) determineCurrentLookupKey();
        if (!StringUtil.isInvalid(dataSourceKey))
        {
//            System.out.println("dataSourceMap.get(dataSourceKey): "+dataSourceMap.get(dataSourceKey));
            logger.debug("使用数据源 "+dataSourceKey);
            DataSource dataSource=dataSourceMap.get(dataSourceKey);
            if (null==dataSource)
            {
                try
                {
                    throw new DataSourceException("找不到名为 "+dataSourceKey+" 的数据源");
                }
                catch (DataSourceException e)
                {
                    e.printStackTrace();
                }
            }
            return dataSourceMap.get(dataSourceKey);
        }
        else
        {
//            System.out.println("default: "+dataSourceMap.get("default"));
            logger.debug("使用默认数据源");
            return dataSourceMap.get("default");
        }
//        return super.determineTargetDataSource();
        // return null;
    }

    /**
     * 初始化所有的数据源，启动监听调用
     * @param filePath
     * @throws Exception
     * @throws ClassNotFoundException
     * @throws InstantiationException
     * @throws IllegalAccessException
     * @throws InvocationTargetException
     * @throws SQLException 
     */
    public static void initDataSources(String filePath) throws DataSourceException,
            ClassNotFoundException, InstantiationException,
            IllegalAccessException, InvocationTargetException
    {
//        System.out.println("initDataSources: ");
        PropertiesUtil pu = PropertiesUtil.getPropertiesUtil(filePath);
        Set<Object> keySet = pu.getKeySet();
//        System.out.println("pu: "+pu.getKeySet());
        String dataSourceName = pu.read(dataSourceNameSetName);
        logger.debug("dataSourceSetName: "+dataSourceName);
        String proxyIp=pu.read(proxyIpKey);
        String proxyPort=pu.read(proxyPortKey);
        
        
        String[] dataSourceNameArr = dataSourceName.replace("，", ",").replaceAll(" ", "").split(",");
        if (null!=dataSourceNameArr)
        {
            logger.debug("找到 " + dataSourceNameArr.length + " 个数据源名称,分别为 "+ArrayUtils.toString(dataSourceNameArr));
        }
        else
        {
            throw new DataSourceException("找不到任何数据源名称,dataSourceNameSet不能为空");
        }
        // System.out.println(ArrayUtils.toString(dataSourceNameArr));
        int defaultDataSourceCount = 0;
        for (String dsName : dataSourceNameArr)
        {
            // 如果指定的数据源名称不存在，则抛
            if (!contain(dsName, keySet))
            {
                // throw new Exception("指定的数据源 "+dsName+" 不存在");
                logger.warn("指定的数据源 "+dsName+" 不存在");
            }
            else
            {
                Map<String, String> dataSourceConfMap = getDataSourceConfMap(dsName, keySet, pu);
//                System.out.println("dataSourceConfMap: "+dataSourceConfMap);
                logger.debug("从jdbc.properties中读取到: "+dsName+":  "+dataSourceConfMap);
                String className = dataSourceConfMap.get("class");
                if (StringUtil.isInvalid(className))
                {
                    throw new DataSourceException("必须为数据源 " + dsName + " 指定数据源类名");
                }
                Object obj = Reflect.newInstance(className);// 先测试下
                // System.out.println("dataSourceConfMap: "+dataSourceConfMap);

                BeanUtils.populate(obj, dataSourceConfMap);
                // System.out.println("obj: "+obj);
                DataSource dataSource = (DataSource) obj;
                
                if (!StringUtil.isInvalid(proxyIp)&&!StringUtil.isInvalid(proxyPort))
                {
                    Properties prop = System.getProperties();
                    prop.put("socksProxyHost", proxyIp);
                    prop.put("socksProxyPort", proxyPort);
                    
                    logger.info("启用了代理: "+proxyIp+":"+proxyPort);
                }
                try
                {
                    dataSource.getConnection();
                }
                catch (SQLException e)
                {
                    throw new DataSourceException("数据源: "+dsName,e);
                }
                String defaultt = dataSourceConfMap.get("default");
                // System.out.println("default: "+defaultt);
                if (!StringUtil.isInvalid(defaultt) && "true".equals(defaultt))
                {
                    defaultDataSourceCount++;
                    // 不能有两个或以上的默认数据源
                    if (defaultDataSourceCount > 1)
                    {
                        // 抛
                        throw new DataSourceException("不能有两个或以上的默认数据源: " + dsName);
                    }
                    dataSourceMap.put("default", dataSource);
                }
                dataSourceMap.put(dsName, dataSource);

                // String className=dataSource.get
                // System.out.println("className: "+className);
//                 System.out.println("conn: "+dataSource.getConnection());
            }
        }
        
        if (defaultDataSourceCount ==0)
        {
            // 抛
            throw new DataSourceException("请至少定义一个默认数据源");
//            System.out.println("请至少定义一个默认数据源: ");
        }
        
//        System.out.println("dataSourceMap: "+dataSourceMap);
        pu.close();
    }

    /**
     * 通过指定的数据源名，装配起配置的键值对
     * 
     * @param string
     * @param keySet
     * @return
     */
    private static Map<String, String> getDataSourceConfMap(String dsName,
            Set<Object> keySet, PropertiesUtil pu)
    {
        Map<String, String> dsConfMap = new HashMap<String, String>();
        for (Object object : keySet)
        {
            String key = (String) object;
            if (key.startsWith(dsName))
            {
                dsConfMap.put(key.replace(dsName + ".", ""), pu.read(key));
            }
        }
        return dsConfMap;
    }

    /**
     * 在属性文件的所有key中是否包含指定的以数据源名开头的键
     * 
     * @param string
     * @param keySet
     * @return
     */
    private static boolean contain(String string, Set<Object> keySet)
    {
        for (Object object : keySet)
        {
            String key = (String) object;
            if (key.startsWith(string))
            {
                return true;
            }
        }
        return false;
    }
}
