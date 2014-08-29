package com.zwl.core.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.zwl.core.util.StringUtil;

/**
 * 自定义标签,专门用来处理搜索关键字的着色和长字符串截取输出
 * 
 * 如:<zwl:out content="${content }" end="14"/>,最多只显示14个字符,如果不指定start,默认从第一位开始截取
 * <zwl:out content="中华人民共和国中华人民共和国中华人民共和国" key="中" color="red" end="14" />:截取成14个字符,把所有的“中”变成红色
 * @author zhangweilin
 *
 */
@SuppressWarnings("serial")
public class TruncationSearchKeyColorTag extends TagSupport
{
    private String color="";  //要着的颜色
    private String key="";  //搜索的关键字,即要着色的关键字
    private String content="";  //要处理的字符串段
    //以什么方式结束要输出的字符串
    private String close="";
    
    //如果要截取字符串,则使用如下值
    private int start=0;  //截取的开始处
    private int end=-1;  //截取的结束处
    
    
    /*
     *  是否要将&nbsp等显示为空格,即是否以xml格式显示,false表示以xml格式显示,即&nbsp显示为空格
        true表示以原版显示,不排版
        默认下排版
     */
    private boolean escape=false; 
    @Override
    public int doEndTag() throws JspException
    {
        JspWriter out = pageContext.getOut(); 
        
        //先过滤掉html标签,如果截取的字符串里有html标签,那就没意义了
        content=StringUtil.convertHtml2Text(content);
//        System.out.println("color: "+color+" key: "+key+" content: "+content);
        try
        {
          //未指定颜色值,则默认为红色
            if ("".equals(color))  
            {
                color="red";
            }
            
            //指定了要截取的长度
            if (end>=0&&start>=0)
            {
                //只有结束值大于开始值才有效
                if (end>=start)
                {
                    //一定要在end小于字符串长度
                    if (end<=content.length())
                    {
                        content=content.substring(start,end);
                        //如果没有指定结束字符串
                        if ("".equals(close))
                        {
                            close="...";
                        }
                        content=content+close;
                    }
                    else
                    {
                        content=content.substring(start);
                    }
                }
            }
            
            //是否要以排版方式显示
            if (!escape) //如果为假,表示排版方式显示
            {
                content=content.replace("&nbsp;", "").replace("<br>", "");
            }
            
//            System.out.println("escape: "+escape+" content: "+content);
            
//            System.out.println("key: "+key);
            if (key!=null&&key!="")
            {
                content = content.replaceAll(key, "<font color=" + color + ">"
                        + key + "</font>");
            }
            
//            content=content.replace("\"", "\\'");
            out.print(content);
//            System.out.print(content);
            
        }
        catch (IOException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }
    
    
    public String getColor()
    {
        return color;
    }
    public void setColor(String color)
    {
        this.color = color;
    }
    public String getKey()
    {
        return key;
    }
    public void setKey(String key)
    {
        this.key = key;
    }
    public String getContent()
    {
        return content;
    }
    public void setContent(String content)
    {
        this.content = content;
    }


    public int getStart()
    {
        return start;
    }


    public void setStart(int start)
    {
        this.start = start;
    }


    public int getEnd()
    {
        return end;
    }


    public void setEnd(int end)
    {
        this.end = end;
    }


    public boolean isEscape()
    {
        return escape;
    }


    public void setEscape(boolean escape)
    {
        this.escape = escape;
    }


    public String getClose()
    {
        return close;
    }


    public void setClose(String close)
    {
        this.close = close;
    }
    
    
    
    
}
