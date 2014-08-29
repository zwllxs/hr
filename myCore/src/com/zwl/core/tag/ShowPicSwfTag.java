package com.zwl.core.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.zwl.core.util.StringUtil;

/**
 * 显示图片或者flash,能自动处理大小和等比缩放等功能,后续有需求时再来开发
 * @author zhangweilin
 *
 */
@SuppressWarnings("serial")
public class ShowPicSwfTag extends TagSupport
{
    
    private String id;
    
    //图片或flash路径
    private String src="";
    
    /**
     * 宽度
     */
    private int width;
    
    /**
     * 高度
     */
    private int height;
    
    /**
     * 提示
     */
    private String alt;
    
    /**
     * 标题
     */
    private String title;
    
    /**
     * 边框
     */
    private int border;
    
    /**
     * 样式名
     */
    private String cssClass;
    
    /**
     * 样式
     */
    private String cssStyle;
    
    @Override
    public int doEndTag() throws JspException
    {
        JspWriter out = pageContext.getOut();
        
        // 自动识别后缀  
        String ext=StringUtil.getLastWords(src, false);
        try
        {
            
            StringBuffer sb=new StringBuffer();

            if (!StringUtil.isInvalid(id))
            {
                sb.append(" id=\"");
                sb.append(id);
                sb.append("\" ");
            }
            
            if (0!=width)
            {
                sb.append(" width=\"");
                sb.append(width);
                sb.append("\" ");
            }
            
            if (0!=height)
            {
                sb.append(" height=\"");
                sb.append(height);
                sb.append("\" ");
            }
            
            if (0!=border)
            {
                sb.append(" border=\"");
                sb.append(border);
                sb.append("\" ");
            }
            
            if (!StringUtil.isInvalid(alt))
            {
                sb.append(" alt=\"");
                sb.append(alt);
                sb.append("\" ");
            }
            
            if (!StringUtil.isInvalid(title))
            {
                sb.append(" title=\"");
                sb.append(title);
                sb.append("\" ");
            }
            
            if (!StringUtil.isInvalid(cssClass))
            {
                sb.append(" class=\"");
                sb.append(cssClass);
                sb.append("\" ");
            }

            if (!StringUtil.isInvalid(cssStyle))
            {
                sb.append(" style=\"");
                sb.append(cssStyle);
                sb.append("\" ");
            }
            
//            System.out.println("sb.toString(): "+sb.toString());
            if (!StringUtil.isInvalid(ext))
            {
                //flash
                if ("swf".equals(ext))
                {
                    out.print("<embed ");
                    out.print(sb.toString());
                    out.print(" src=\"");
                    out.print(src);
                    out.print("\"></embed>");
                }
                //图片
                else
                {
                    out.print("<img ");
                    out.print(sb.toString());
                    out.print(" src=\"");
                    out.print(src);
                    out.print("\"></img>");
                }
            }
        }
        catch (IOException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }

    public String getSrc()
    {
        return src;
    }

    public void setSrc(String src)
    {
        this.src = src;
    }

    /**
     * @return the width
     */
    public int getWidth()
    {
        return width;
    }

    /**
     * @param width the width to set
     */
    public void setWidth(int width)
    {
        this.width = width;
    }

    /**
     * @return the height
     */
    public int getHeight()
    {
        return height;
    }

    /**
     * @param height the height to set
     */
    public void setHeight(int height)
    {
        this.height = height;
    }

    /**
     * @return the alt
     */
    public String getAlt()
    {
        return alt;
    }

    /**
     * @param alt the alt to set
     */
    public void setAlt(String alt)
    {
        this.alt = alt;
    }

    /**
     * @return the title
     */
    public String getTitle()
    {
        return title;
    }

    /**
     * @param title the title to set
     */
    public void setTitle(String title)
    {
        this.title = title;
    }

    /**
     * @return the border
     */
    public int getBorder()
    {
        return border;
    }

    /**
     * @param border the border to set
     */
    public void setBorder(int border)
    {
        this.border = border;
    }

    /**
     * @return the cssClass
     */
    public String getCssClass()
    {
        return cssClass;
    }

    /**
     * @param cssClass the cssClass to set
     */
    public void setCssClass(String cssClass)
    {
        this.cssClass = cssClass;
    }

    /**
     * @return the cssStyle
     */
    public String getCssStyle()
    {
        return cssStyle;
    }

    /**
     * @param cssStyle the cssStyle to set
     */
    public void setCssStyle(String cssStyle)
    {
        this.cssStyle = cssStyle;
    }

    /**
     * @return the id
     */
    public String getId()
    {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(String id)
    {
        this.id = id;
    }

   
    
}
