package com.zwl.core.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.directwebremoting.WebContextFactory;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionProxy;
import com.opensymphony.xwork2.util.ValueStack;

/**
 * 全部与servlet相关的操作
* ServletUtil.java Create on 2011-4-9     
*      
* Copyright (c) 2011-4-9 by 伟林联游      
*      
* @author zhangweilin <a href="zwllxs@163.com">张伟林</a>     
*
 */
public class ServletUtil
{
    public ServletUtil()
    {
    }

    /**
     * 获取request
     * 
     * @return
     */
    public static HttpServletRequest getRequest()
    {
        return ServletActionContext.getRequest();
    }

    /**
     * 获取response
     * 
     * @return
     */
    public static HttpServletResponse getResponse()
    {
        return ServletActionContext.getResponse();
    }

    /**
     * 获取struts2封装的Session
     * 
     * @return
     */
    @SuppressWarnings("unchecked")
    public static Map getSession()
    {
        return ServletActionContext.getContext().getSession();
    }

    /**
     * 获取servlet原生session
     * 
     * @return
     */
    public static HttpSession getHttpSession()
    {
        return getRequest().getSession();
    }

    /**
     * 获取dwr的session
     * @return
     */
    public static HttpSession getDwrHttpSession()
    {
        return WebContextFactory.get().getSession(); 
    }
    
    /**
     * 获取dwr request
     * @return
     */
    public static HttpServletRequest getDwrHttpServletRequest()
    {
        return WebContextFactory.get().getHttpServletRequest(); 
    }
    
    
    /**
     * 获取dwr response
     * @return
     */
    public static HttpServletResponse getDwrHttpServletResponse()
    {
        return WebContextFactory.get().getHttpServletResponse(); 
    }
    
    /**
     * 获取Servlet上下文
     * 
     * @return
     */
    public static ServletContext getServletContext()
    {
        return ServletActionContext.getServletContext();
    }
    
    /**
     * 写出
     * @return
     */
    public static PrintWriter getPrintWriter()
    {
        try
        {
            return getResponse().getWriter();
        }
        catch (IOException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * 获取struts2上下文
     * 
     * @return
     */
    private static ActionContext getContext()
    {
        return ServletActionContext.getContext();
    }

    /**
     * 获取action名
     * 
     * @return
     */
    public static String getActionName()
    {
        return getContext().getName();
    }

    /**
     * 获取Action代理
     * 
     * @return
     */
    public static ActionProxy getProxy()
    {
        return getContext().getActionInvocation().getProxy();
    }

    /**
     * 获取命名空间名称
     * 
     * @return
     */
    public static String getActionNameSpace()
    {
        return getProxy().getNamespace();
    }

    /**
     * 利用原生servlet的request获取页面参数值
     * 
     * @param name
     * @return
     */
    public static String getParameter(String name)
    {
        return getRequest().getParameter(name);
    }

    /**
     * 获取参数集合
     * 
     * @return
     */
    @SuppressWarnings("unchecked")
    public static Map getParameters()
    {
        return getContext().getParameters();
    }

    /**
     * 获取值栈,与webwork不同.webwork中为OgnlValueStack,而不是ValueStack
     * 
     * @return
     */
    public static ValueStack getValueStack()
    {
        return getContext().getValueStack();
    }

    /**
     * 未知使用
     * 
     * @param key
     * @return
     */
    public static Object getActionValue(String key)
    {
        return getContext().get(key);
    }

    /**
     * 手动给action值栈里加值
     * 
     * @param key
     * @param value
     */
    public static void putActionValue(String key, Object value)
    {
        getContext().put(key, value);
    }

    /**
     * 获取请求路径的参数部分
     * 
     * @return
     */
    @SuppressWarnings("unchecked")
    public static String getParameterString()
    {
        Map ps = getParameters();
        StringBuffer sb = new StringBuffer();
        for (Iterator iterator = ps.keySet().iterator(); iterator.hasNext();)
        {
            String key = (String) iterator.next();
            String values[] = (String[]) ps.get(key);
            String as[];
            int j = (as = values).length;
            for (int i = 0; i < j; i++)
            {
                String value = as[i];
                sb.append(key).append("=").append(value).append("&");
            }

        }

        if (sb.length() > 0 && sb.charAt(sb.length() - 1) == '&')
            sb.substring(0, sb.length() - 1);
        return sb.toString();
    }

    

    /**
     * 获得IP地址
     * @return
     */
    public static String getIp()
    {
        String ip = getRequest().getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
        {
            ip = getRequest().getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
        {
            ip = getRequest().getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
        {
            ip = getRequest().getRemoteAddr();
        }
        return ip;
    }
    
    public static int getIpAddrInt(String ip){
    	String[] ipArr = ip.split("\\.");
    	return Integer.parseInt(ipArr[0])*256*256*256+Integer.parseInt(ipArr[1])*256*256+Integer.parseInt(ipArr[2])*256+Integer.parseInt(ipArr[3]);
    }
    
    /**
     * 获取浏览器端项目根路径
     * @return
     */
    public static String getBasePath()
    {
        HttpServletRequest request=getRequest();
        StringBuffer sb=new StringBuffer();
        String portPath ="";
        if (request.getServerPort()!=80)
        {
            portPath = ":"+request.getServerPort();
        }
        String path=sb.append(request.getScheme()).append("://").append(request.getServerName()).append(portPath).append(request.getContextPath()).toString();
        return path;
    }
    
    /**
     * 获取主机名
     * @return
     */
    public static String getServerName()
    {
        return getRequest().getServerName();
    }
    
    /**
     * 获得二级域名
     * @return
     */
    public static String get2DoMainName()
    {
        String path=getServerName();
        String uesrName = "";
        if(path.contains("."))
        {
            uesrName=path.substring(0, path.indexOf("."));
        }
        return uesrName;
    }
   
    /**
     * 删除cookie
     * @param key
     */
    public static void deleteCookie(String key)
    {
        Cookie cookie = new Cookie(key, null);    
        cookie.setMaxAge(0); //设置为0为立即删除该Cookie    
        getResponse().addCookie(cookie);
    }
    
    /**
     * Cookie添加
     * 
     * @return
     */
    public static void addCookie(String key, String value, int maxAge)
    {
        Cookie cookie = new Cookie(key, value);
        cookie.setMaxAge(maxAge);
        getResponse().addCookie(cookie);
    }
    /**
     * Cookie取得
     * 
     * @return
     * @throws Exception
     */
    public static String readCookie(String key)
    {
        Cookie[] cookies = getRequest().getCookies();
        if (null == cookies)
        {
            return null;
        }
        for (Cookie cookie : cookies)
        {
            if (cookie.getName().equals(key))
            {
                return cookie.getValue();
            }
        }
        return null;
    }
}
