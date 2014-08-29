package com.zwl.core.util;

import java.io.IOException;
import java.io.StringWriter;
import java.util.Map;

import freemarker.cache.ClassTemplateLoader;
import freemarker.cache.TemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**      
 * FreemarkerUtil.java Create on 2011-4-9     
 *      
 * Copyright (c) 2011-4-9 by 伟林联游      
 *      
 * @author zhangweilin <a href="zwllxs@163.com">张伟林</a>     
 * freemarker工具类,
 */

public class FreemarkerUtil
{
    private static final Configuration cfg = new Configuration();
    
    /**
     * 根据模板文件和数字获取处理后的内容
     * @param map
     * @param templateFileName
     * @return
     * @throws IOException
     * @throws TemplateException
     */
    @SuppressWarnings("unchecked")
    public static String getContent(Map map,String templateFileName) throws IOException, TemplateException
    {
        Template t = getTemplate(templateFileName);
        return getContent(map, t); 
    }
    
    /**
     * 根据模板文件和数字获取处理后的内容
     * @param map
     * @param templateFileName
     * @return
     * @throws IOException
     * @throws TemplateException
     */
    @SuppressWarnings("unchecked")
    public static String getContent(Map map,Class clazz, String templateFileName) throws IOException, TemplateException
    {
        Template t = getTemplate(clazz,templateFileName);
        return getContent(map, t); 
    }
    
    /**
     *  根据模板文件和数字获取处理后的内容
     * @param map
     * @param templateFileName
     * @param encoding  编码集
     * @return
     * @throws IOException
     * @throws TemplateException
     */
    @SuppressWarnings("unchecked")
    public static String getContent(Map map,String templateFileName,String encoding) throws IOException, TemplateException
    {
        Template t = getTemplate(templateFileName,encoding);
        return getContent(map, t);
    }
    
    /**
     *  根据模板文件和数字获取处理后的内容
     * @param map
     * @param templateFileName
     * @param encoding  编码集
     * @return
     * @throws IOException
     * @throws TemplateException
     */
    @SuppressWarnings("unchecked")
    public static String getContent(Map map,Class clazz, String templateFileName,String encoding) throws IOException, TemplateException
    {
        Template t = getTemplate(clazz,templateFileName,encoding);
        return getContent(map, t);
    }

    /**
     * 获取处理后的内容
     * @param map
     * @param t
     * @return
     * @throws TemplateException
     * @throws IOException
     */
    @SuppressWarnings("unchecked")
    private static String getContent(Map map, Template t) throws TemplateException, IOException
    {
        // 最关键在这里，不使用与文件相关的Writer
        StringWriter stringWriter = new StringWriter();
        String content = "";

        t.process(map, stringWriter);
        content = stringWriter.toString();
        // 这里打印的就是通过模板处理后得到的字符串内容
        // System.out.println("stringWriter: "+stringWriter.toString());
        stringWriter.close();
        return content;
    }

    /**
     * 获取模板
     * @param templateFileName
     * @return
     * @throws IOException
     */
    private static Template getTemplate(String templateFileName) throws IOException
    {
        return cfg.getTemplate(templateFileName);
    }
    
    
    /**
     * 获取模板
     * @param templateFileName
     * @return
     * @throws IOException
     */
    @SuppressWarnings("unchecked")
    private static Template getTemplate(Class clazz, String templateFileName) throws IOException
    {
        TemplateLoader templateLoader=new ClassTemplateLoader(clazz,"");
        cfg.setTemplateLoader(templateLoader);
        return cfg.getTemplate(templateFileName);
    }
    
    /**
     * 获取模板
     * @param templateFileName
     * @return
     * @throws IOException
     */
    private static Template getTemplate(String templateFileName,String encoding) throws IOException
    {
        return cfg.getTemplate(templateFileName,encoding);
    }
    
    
    /**
     * 获取模板
     * @param templateFileName
     * @return
     * @throws IOException
     */
    @SuppressWarnings("unchecked")
    private static Template getTemplate(Class clazz, String templateFileName,String encoding) throws IOException
    {
        TemplateLoader templateLoader=new ClassTemplateLoader(clazz,"");
        cfg.setTemplateLoader(templateLoader);
        return cfg.getTemplate(templateFileName,encoding);
    }
    
    
}
