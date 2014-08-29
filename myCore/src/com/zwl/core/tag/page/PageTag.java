package com.zwl.core.tag.page;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.zwl.core.tag.page.constants.PageConstants;
import com.zwl.core.tag.page.exception.PageException;
import com.zwl.core.util.FreemarkerUtil;
import com.zwl.core.util.PropertiesUtil;
import com.zwl.core.util.StringUtil;

import freemarker.template.TemplateException;

/**
 * 此适用于后台管理的分页
 * 它能随意改变每页的分页数量，使用如下：
 * <p:page totalSize="${pageInfo.totalSize}" perPageSize="${pageInfo.perPageSize}" cssStyle="STYLE1" />
 * <p:page totalSize="${pageInfo.totalSize}" style="list" perPageSize="${pageInfo.perPageSize}" cssStyle="STYLE1" />
 * style有两个值:默认为"standard",标准分页，"list",列表方式分页,建议不设置此值
 * @author wlzhang
 *
 */
public class PageTag extends BodyTagSupport
{
    protected final transient Logger logger = LoggerFactory.getLogger(getClass());
    
    private String filePath="templates/";
    private String configFilePath="/WEB-INF/classes/page.properties";
    private String basePath="";
    private String encoding=PageConstants.encoding;
    
    
    /**
     * 
     */
    private static final long serialVersionUID = 2367181643547131008L;
    
    /**
     * 当前页
     */
    private int currentPageNo = 1;
    
    /**
     * 总页数
     */
    private int totalPageNum = 0;
    
    /**
     * 总条数
     */
    private int totalSize = 0;
    
    /**
     * URL地址
     */
    private String url = "";
    
    /**
     * 页面样式
     */
    private String cssStyle = "";
    
    /**
     * 每页数量
     */
    private int perPageSize ;

    /**
     * 分页样式
     */
    private String pageStyle="";
    
    /**
     * 如果是列表方式的分页，此表示每一次显示的页码段,此是标签属性
     */
    private int sect; 
    
    /**
     * 如果是ajax分页，则ajax要调用的javascript函数名
     */
    private String function;
    
    /**
     * 如果是ajax分页，则ajax调用javascript函数时要请求的action名
     */
    private String action;

    /**
     * 是否有页面重写
     */
    private String rewrite;

    /**
     * 使用了重写的地址的填补路径
     */
    private String path;

    /**
     * 地址结束后缀
     */
    private String endWith = "";
    
    
    @SuppressWarnings("unchecked")
    public int doStartTag()
    {
        if(perPageSize == 0)
        {
            perPageSize = PageConstants.perPageSize;
        }
        HttpServletRequest request = (HttpServletRequest) pageContext
                .getRequest();
        url = request.getQueryString();
        basePath=pageContext.getServletContext().getRealPath("");
        File file=new File(basePath+configFilePath);
        PropertiesUtil pu=null;
        
        if (file.exists())
        {
            pu = PropertiesUtil.getPropertiesUtil(file.getAbsolutePath());
            encoding=StringUtil.getString(pu.read(PageConstants.encodingKey),PageConstants.encoding);
        }
        
        if (url != null)
        {
            if (!StringUtil.isInvalid(request.getParameter("perPageSize")))
            {
                perPageSize = StringUtil.getInt(request.getParameter("perPageSize"), perPageSize);
            }
            else if (perPageSize == 0)
            {
                
                if (!file.exists())
                {
                    logger.warn("找不到page.properties,系统将采用默认值:perPageSize="+PageConstants.perPageSize);
                    perPageSize=PageConstants.perPageSize;
                }
                else
                {
                    int perPageSize0=StringUtil.getInt(pu.read(PageConstants.perPageSizeKey), PageConstants.perPageSize);
                    perPageSize = perPageSize0;
                }
            }
            String pageNo = request.getParameter("pageNo");
            if (pageNo != null)
            {
                try
                {
                    
                    currentPageNo = Integer.parseInt(request.getParameter("pageNo"));
                }
                catch (NumberFormatException nfex)
                {
                    currentPageNo = 1;
                }
            }
            else
            {
                currentPageNo = 1;
            }
        }
        else
        {
            url = "";
            currentPageNo = 1;
        }
        
        totalPageNum = this.getTotalSize() / perPageSize;
        if (totalSize > totalPageNum * perPageSize)
        {
            totalPageNum++;
        }
        
        if (currentPageNo <= 0)
        {
            currentPageNo = 1;
        }
        else if(currentPageNo > totalPageNum)
        {
            currentPageNo = totalPageNum;
        }
        
        JspWriter out=pageContext.getOut();
        
        //freemarker开始
         Map map=new HashMap();
        //不同的分页样式需要的值和处理方式都不一样
        //标准分页
        pageStyle="".equals(pageStyle)?"standard":pageStyle; 
//        if ("standard".equals(pageStyle))
        if (pageStyle.startsWith("standard"))
        {
            matcher("&?perPageSize=\\d{1,2}&pageNo=\\d{1,5}");
            
            int start=0;
            int end=0;
            int steps=0;
            if (!file.exists())
            {
                logger.warn("找不到page.properties,系统将采用默认值:start="+PageConstants.minPageSize);
                logger.warn("找不到page.properties,系统将采用默认值:end="+PageConstants.maxPageSize);
                logger.warn("找不到page.properties,系统将采用默认值:steps="+PageConstants.pageSizeSteps);
                start=PageConstants.minPageSize;
                end=PageConstants.maxPageSize;
                steps=PageConstants.pageSizeSteps;
            }
            else
            {
                String startStr = pu.read(PageConstants.minPageSizeKey);
                String endStr = pu.read(PageConstants.maxPageSizeKey);
                String stepsStr = pu.read(PageConstants.pageSizeStepsKey);
                
                start=StringUtil.getInt(startStr, PageConstants.minPageSize);
                end=StringUtil.getInt(endStr, PageConstants.maxPageSize);
                steps=StringUtil.getInt(stepsStr, PageConstants.pageSizeSteps);
            }
            
            
            //标准方式使用
            map.put("start", start);
            map.put("end", end);
            map.put("steps", steps);
        }
//        else if ("list".equals(pageStyle)||"list_yk".equals(pageStyle)||"list_yk2".equals(pageStyle))
        else if (pageStyle.startsWith("list"))
        {
//            
//            //验证是否是ajax分页，如果是则必要有function和action
//            if (pageStyle.contains("ajax"))
//            {
//                if (StringUtil.isInvalid(function))
//                {
//                    try
//                    {
//                        throw new PageException("ajax分页,function不能为空 ");
//                    }
//                    catch (PageException e)
//                    {
//                        e.printStackTrace();
//                    }
//                }
//            }
//            
//            if (pageStyle.contains("ajax"))
//            {
//                if (StringUtil.isInvalid(action))
//                {
//                    try
//                    {
//                        throw new PageException("ajax分页,action不能为空 ");
//                    }
//                    catch (PageException e)
//                    {
//                        e.printStackTrace();
//                    }
//                }
//            }
            
            matcher("&?pageNo=\\d{1,5}");
            map.put("sect", sect);
//            map.put("function", function);
//            map.put("action", action);
            
            if (sect<=0)
            {
                try
                {
                    throw new PageException("list分页需要指定sect值");
                }
                catch (PageException e)
                {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
            
        }
       

        //验证是否是ajax分页，如果是则必要有function和action
        if (pageStyle.contains("ajax"))
        {
            if (StringUtil.isInvalid(function))
            {
                try
                {
                    throw new PageException("ajax分页,function不能为空 ");
                }
                catch (PageException e)
                {
                    e.printStackTrace();
                }
            }
        }
        
        if (pageStyle.contains("ajax"))
        {
            if (StringUtil.isInvalid(action))
            {
                try
                {
                    throw new PageException("ajax分页,action不能为空 ");
                }
                catch (PageException e)
                {
                    e.printStackTrace();
                }
            }
        }
        
        //ajax分页变量
        map.put("function", function);
        map.put("action", action);
        
        map.put("currentPageNo", currentPageNo);
        map.put("totalPageNum", totalPageNum);
        map.put("totalSize", totalSize);
        map.put("url", url);
        map.put("cssStyle", cssStyle);
        map.put("perPageSize", perPageSize);
        map.put("rewrite", Boolean.valueOf(rewrite));
        map.put("path", path);
        map.put("endWith", endWith);
      
        try
        {
            String content="";
            content=FreemarkerUtil.getContent(map, PageTag.class, filePath+"page_"+pageStyle+".ftl",encoding );
//            System.out.println("content3: "+content);
            out.println(content); 
//                out.close();
        }
        catch (TemplateException e)
        {
            e.printStackTrace();
        }
        catch (IOException e)
        {
            try
            {
                throw new PageException("找不到此分页样式: "+pageStyle,e);
            }
            catch (PageException e1)
            {
                e1.printStackTrace();
            }
        }
            //freemarker结束
        return SKIP_BODY;
    }
    
    public void setCssStyle(String cssStyle) {
        this.cssStyle = cssStyle;
    }

    public int doEndTag(){
        return SKIP_BODY;
    }
    
    /**
     * 正则表达式替换URL信息
     */
    private String matcher(String regex)
    {
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(url);
        url = matcher.replaceAll("");
        if (!StringUtil.isInvalid(url))
        {
            url += "&";
        }
        return url;
    }
    
    public void release(){
        super.release();
    }

    public int getTotalSize()
    {
        return totalSize;
    }

    public void setTotalSize(int totalSize)
    {
        this.totalSize = totalSize;
    }

    public int getPerPageSize()
    {
        return perPageSize;
    }

    public void setPerPageSize(int perPageSize)
    {
        this.perPageSize = perPageSize;
    }

    /**
     * @return the sect
     */
    public int getSect()
    {
        return sect;
    }

    /**
     * @param sect the sect to set
     */
    public void setSect(int sect)
    {
        this.sect = sect;
    }

    /**
     * @return the pageStyle
     */
    public String getPageStyle()
    {
        return pageStyle;
    }

    /**
     * @param pageStyle the pageStyle to set
     */
    public void setPageStyle(String pageStyle)
    {
        this.pageStyle = pageStyle;
    }

    /**
     * @return the function
     */
    public String getFunction()
    {
        return function;
    }

    /**
     * @param function the function to set
     */
    public void setFunction(String function)
    {
        this.function = function;
    }

    /**
     * @return the action
     */
    public String getAction()
    {
        return action;
    }

    /**
     * @param action the action to set
     */
    public void setAction(String action)
    {
        this.action = action;
    }

    /**
     * @return the rewrite
     */
    public String getRewrite()
    {
        return rewrite;
    }

    /**
     * @param rewrite the rewrite to set
     */
    public void setRewrite(String rewrite)
    {
        this.rewrite = rewrite;
    }

    /**
     * @return the path
     */
    public String getPath()
    {
        return path;
    }

    /**
     * @param path the path to set
     */
    public void setPath(String path)
    {
        this.path = path;
    }

    /**
     * @return the endWith
     */
    public String getEndWith()
    {
        return endWith;
    }

    /**
     * @param endWith the endWith to set
     */
    public void setEndWith(String endWith)
    {
        this.endWith = endWith;
    }
}
