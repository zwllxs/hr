package com.zwl.core.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class PropertiesUtil
{
    protected final transient Logger logger = LoggerFactory.getLogger(getClass());
    private Properties pro = new Properties();
    private static String filePath = "";
    private static PropertiesUtil pu = null;

    @SuppressWarnings("static-access")
    public PropertiesUtil(String filePath)
    {
        this.filePath=filePath;
        getNewProperties(filePath);

    }

    /**
     * 获取属性文件实例
     */
    private void getNewProperties(String filePath)
    {
        try
        {
            this.pro.load(new FileInputStream(new File(filePath)));
        }
        catch (FileNotFoundException e)
        {
            e.printStackTrace();
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
    }

    /**
     * 初始化根目录值
     * @param path  项目根路径
     * @param file  读取的文件名
     * @param isNew  指定是否要强制重新读
     * @return
     */
    public static PropertiesUtil getPropertiesUtil(String path, String file,
            boolean isNew)
    {
        if (pu == null || isNew)
        {
            pu = new PropertiesUtil(path + file);
        }

        return pu;
    }
    
 
    
    /**
     * 初始化根目录值
     * @param path  项目根路径
     * @param file  读取的文件名
     * @return
     */
    public static PropertiesUtil getPropertiesUtil(String path, String file)
    {
        // System.out.println("pu: "+pu);
        if (pu == null)
        {
            pu = new PropertiesUtil(path + file);
        }
        return pu;
    }
    
    /**
     * 初始化根目录值
     * @param file  读取的文件名
     * @return
     */
    public static PropertiesUtil getPropertiesUtil(String file)
    {
        if (pu == null)
        {
            pu = new PropertiesUtil(file);
        }
        return pu;
    }

    /**
     * 重新设置指定键的值
     * @param key
     * @param value
     */
    public void setValue(String key, String value)
    {
        pro.setProperty(key, value);
    }

    /**
     * 读内容
     * @param key  要读取的指定的键
     * @return
     */
    public String read(String key)
    {
        if (pro.containsKey(key))
        {
            return pro.getProperty(key).trim();
        }
        return "";
    }

    /**
     * 将更新保存
     */
    @SuppressWarnings("static-access")
    public void save()
    {
        try
        {
            pro.store(new FileOutputStream(new File(this.filePath)), "updated");
        }
        catch (FileNotFoundException e)
        {
            e.printStackTrace();
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
    }

    
    /**
     * 获取所有键
     * @return
     */
    public Set<Object> getKeySet()
    {
        return pro.keySet();
    }
    
    
    /**
     * 关闭,每次操作完属性文件后,都要进行关闭
     */
    public void close()
    {
//        System.out.println("调用关闭方法");
        if (pro != null)
        {
            pro = null;
        }

        if (pu != null)
        {
            pu = null;
        }
    }

}
