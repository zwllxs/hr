package com.zwl.core.tag;

import java.io.IOException;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.zwl.core.util.JsonUtil;



/**
 * 当结果列表中有来自下拉select菜单时,此时只需要显示其文本值即可,此标签用来显示来自select的文本值,
 * 客户端通过传一个下拉列表集合和持久化的具体值,即可在结果列表中直接显示选中的值
 * 
 * 它的使用如:
 * <zwl:showSelectedText list="#{'10':'新闻','20':'问答','30':'关于我们'}" value="20"/>
 * @author zhangweilin
 *
 */
@SuppressWarnings("serial")
public class ShowSelectTextTag extends TagSupport
{
    /**
     * 接收来自客户端的列表集合
     */
    private String list;
    
    /**
     * 接收来自客户端选中的对应的value值
     */
    private String value;
    
    /**
     * 当通过list取不到值，即没有相应的键值对时，要显示的默认值
     */
    private String defaultText;
   
    @Override
    public int doEndTag() throws JspException
    {
        JspWriter out = pageContext.getOut(); 
        Map<String, String> map=JsonUtil.getKeyValueMap(list.replaceAll("#", ""));
        try
        {
            value=value==null?"":value;
            String[] valueArr=value.split(",");
            StringBuffer sb=new StringBuffer();
            String result="";
            String str;
            boolean isHave=false;
            for (int i = 0; i < valueArr.length; i++)
            {
                str = map.get(valueArr[i]);
                defaultText = defaultText == null ? "" : defaultText;
                str = str == null ? defaultText : str.trim();
                sb.append(str).append(" , ");
                isHave=true;
            }
            if (isHave)
            {
                result = sb.toString().trim().substring(0, sb.length() - 2);
            }
            out.print(result);
        }
        catch (IOException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }

    public String getList()
    {
        return list;
    }

    public void setList(String list)
    {
        this.list = list;
    }

    public String getValue()
    {
        return value;
    }

    public void setValue(String value)
    {
        this.value = value;
    }

    public String getDefaultText()
    {
        return defaultText;
    }

    public void setDefaultText(String defaultText)
    {
        this.defaultText = defaultText;
    }
    
}
