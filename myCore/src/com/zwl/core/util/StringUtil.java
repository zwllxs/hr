package com.zwl.core.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil
{

    /**
     * 判断是否为空
     */
    public static boolean isInvalid(String value)
    {
        return (value == null || value.trim().length() == 0);
    }


    /**
     * 将字符串转换成整型值，如果转换失败,则返回默认值
     * 
     * @param stringValue
     *            要转换的字符串
     * @param defValue
     *            如果转换失败,要返回的默认值
     * @return
     */
    public static int getInt(String stringValue, int defValue)
    {
        int intValue = defValue;
        if (!isInvalid(stringValue))
        {
            try
            {
                intValue = Integer.parseInt(stringValue);
            }
            catch (NumberFormatException e)
            {
                e.printStackTrace();
            }
        }
        return intValue;
    }


    /**
     * 如果参数1有效就返回参数1,否则返回参数2
     * @param str0
     * @param str1
     * @return
     */
    public static String getString(String str0, String str1)
    {
        return isInvalid(str0)?str1:str0;
    }
    
    
    /**
     * 在一个单词序列组成的字符串上,找出最后一个单词,
     * 如del_bat_Article中找到Article
     * 如load_Game中找到Game
     * 如load.ArtidclePage中找到ArtidclePage
     * @param str  要解析的字符串
     * @param isBeginWithCapital 规定要找的单词是否一定要大写开头,如果不规定一定要大写开头,那么addArticle这样的也会当作完整单词找出
     * @return
     */
    public static String getLastWords(String str,boolean isBeginWithCapital)
    {
        String exp="[a-zA-Z0-9]+\\b$";
        //如果要大写开头
        if (isBeginWithCapital)
        {
            exp="[A-Z][a-zA-Z0-9]+\\b$";
        }
        
        Pattern p=Pattern.compile(exp);
        Matcher m=p.matcher(str);
        while (m.find())
        {
            return m.group();
        }
        
        return "";
    }
    
    
    //从html代码中提取纯文本内容
    public static String convertHtml2Text(String htmlStr)
    {
        String textStr = "";
        java.util.regex.Pattern p_script;
        java.util.regex.Matcher m_script;
        java.util.regex.Pattern p_style;
        java.util.regex.Matcher m_style;
        java.util.regex.Pattern p_html;
        java.util.regex.Matcher m_html;

        try
        {
            String regEx_script = "<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>";// 定义script的正则表达式{或<script[^>]*?>[\s\S]*?<\/script>
            // }
            String regEx_style = "<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>"; // 定义style的正则表达式{或<style[^>]*?>[\s\S]*?<\/style>
            // }
            String regEx_html = "<[^>]+>"; // 定义HTML标签的正则表达式

            p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);
            m_script = p_script.matcher(htmlStr);
            htmlStr = m_script.replaceAll(""); // 过滤script标签

            p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);
            m_style = p_style.matcher(htmlStr);
            htmlStr = m_style.replaceAll(""); // 过滤style标签

            p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);
            m_html = p_html.matcher(htmlStr);
            htmlStr = m_html.replaceAll(""); // 过滤html标签
            
            htmlStr=htmlStr.replace("&nbsp;", "").replace("&gt;", ">").replace("&lt;", "<");
            htmlStr=htmlStr.replace("&amp;", "&");
            htmlStr=htmlStr.replace("&apos;", "'");
            htmlStr=htmlStr.replace("&quot;", "\"");
            
            
            textStr = htmlStr;

        }
        catch (Exception e)
        {
            System.err.println("Html2Text: " + e.getMessage());
        }

        return textStr;// 返回文本字符串
    }
    

    /**
     * SQL注入检查
     */
    public static boolean illegalString(String str) 
    {
        String illegal = "=|'|:|;|<|>|?|,|`|~|!|$|%|^|(|)|and|exec|insert|select|delete|update|count|*|%|chr|mid|master|truncate|char|declare|or";
        String[] s1 = illegal.split("\\|");
        boolean flag = false;
        for (int i = 0; i < s1.length; i++) {
            if (str.indexOf(s1[i]) != -1) {
                flag = true;
                break;
            }
        }
        return flag;
    }
    
    /**
     * 批量删除时从页面传来字符串id数组,用in语句,在此构成in里的序列 注意,此只是in里的序列,在service里还要有delete from
     * XXX where id in 语句
     * 
     * @author 张伟林
     */
    public static String getSqlInSeq(String[] toDelBat)
    {
        if (null == toDelBat || 0 == toDelBat.length)
        {
            return "('')";
        }
        StringBuffer doDelStrBuf = new StringBuffer();// 构建一个要删除的序列,以便能执行in语句
        StringBuffer hql = new StringBuffer();
        String toDelFinalStr = "";
        if (null != toDelBat)
        {
            for (int i = 0; i < toDelBat.length; i++)
            {
                String strDel = toDelBat[i];
                strDel = "'" + strDel + "'";
                doDelStrBuf.append(strDel).append(" , ");
            }
            toDelFinalStr = doDelStrBuf.toString();
            toDelFinalStr = toDelFinalStr.substring(0, toDelFinalStr
                    .lastIndexOf(","));

        }

        return hql.append("(").append(toDelFinalStr).append(")").toString();

    }
}
