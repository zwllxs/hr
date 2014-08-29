package com.zwl.core.tag;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

import com.zwl.core.util.StringUtil;


/**
 * 做参数的标签
 * 
 * @author wlzhang
 */
public class ParamTag extends BodyTagSupport
{
    /**
     * 
     */
    private static final long serialVersionUID = -5640967367729949585L;

    //要操作的参数或参数列表
    private String params;

    //要对参数做的操作类型
    /*
     * remove:移除此参数和参数值
     * replace:替换路径中指定的字符串
     */
    private String type;
    
    /**
     * 要替换的字符串
     */
    private String oldStr;
    
    /**
     * 替换后的字符串
     */
    private String newStr;
    
    
    @Override
    public int doStartTag() throws JspException
    {
        
        
        HttpServletRequest request=(HttpServletRequest)pageContext.getRequest();
        String uri=request.getQueryString();
        JspWriter out=pageContext.getOut();
        try
        {
            if (!StringUtil.isInvalid(uri))
            {
                
                if (!StringUtil.isInvalid(type))
                {
                    //移除路径中指定的参数
//                    if ("remove".equals(type))
                    if (type.contains("remove"))
                    {
                        if (StringUtil.isInvalid(params))
                        {
                            throw new JspException("当type为remove时，params不能为空");
                        }
                        else
                        {
                            String[] paramsArr = params.split(",");
                            for (String param : paramsArr)
                            {
                                uri = removeParam(uri, param);
                            }
                        }
                    }
                    
                    //替换路径中指定的字符串
                    if ("replace".contains(type))
                    {
                        uri=uri.replace(oldStr, newStr);
                    }
                    
                }
                out.print(uri);
                //            out.close();
            }
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        return SKIP_BODY;
    }

    /**
     * 移除请求参数中的指定参数和值
     * @param url
     * @param param
     * @return
     * @throws Exception
     */
    public String removeParam(String url, String param) throws JspException
    {
        int num1 = url.indexOf(param);
        if (-1 == num1)
        {
//            throw new JspException("找不到相应的属性");
            return "";
        }
        int num2 = url.indexOf("&", num1);
        int first = num1;
        int last = num2 + 1;
        if (-1 == num2)
        {
            last = url.length();
            if (0 != num1)
            {
                first = num1 - 1;
            }
        }
        String url2 = url.substring(first, last);
//        System.out.println("url2: " + url2);
        url = url.replace(url2, "");
//        System.out.println("url:  " + url);
        return url;
    }
    
    
    
    public int doEndTag()
    {
        return SKIP_BODY;
    }

    public String getParams()
    {
        return params;
    }

    public void setParams(String params)
    {
        this.params = params;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public String getOldStr()
    {
        return oldStr;
    }

    public void setOldStr(String oldStr)
    {
        this.oldStr = oldStr;
    }

    public String getNewStr()
    {
        return newStr;
    }

    public void setNewStr(String newStr)
    {
        this.newStr = newStr;
    }
}
