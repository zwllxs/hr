package com.zwl.core.struts2.converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.zwl.core.util.StringUtil;


import ognl.DefaultTypeConverter;

public class DateConvert extends DefaultTypeConverter
{
    protected final transient Logger logger = LoggerFactory.getLogger(getClass());
    /*
     * 重写的方法
     */
    @SuppressWarnings("unchecked")
    @Override
    public Object convertValue(Map context, Object value, Class toType)
    {
        int validFormatIndex=0;
        String[] formarArr=new String[] {
                    "yyyy-MM-dd HH:mm:ss",
                    "yyyy-MM-dd HH-mm-ss",
                    "yyyy-MM-dd",
                    "yyyy/MM/dd",
                    "yyyy-MM-dd H:m",
                    "yyyy-MM-dd H:m:s",
                    "yyyyMMddHHmmss",
                    "yyyyMMdd",
                    "yyyy/dd/MM",
                    "yyyy-dd-MM"
                    };
        
        logger.debug("toType: "+toType);
        SimpleDateFormat sdf = null;
        if (Date.class == toType)
        {
            String[] dateArr = (String[]) value;
            logger.debug("dateArr[0]: "+dateArr[0]);
            if (StringUtil.isInvalid(dateArr[0]))
            {
                logger.debug("接收到日期参数为空,准备返回null ");
                return null;
            }
            for (int i = 0; i < formarArr.length; i++)
            {
                sdf = new SimpleDateFormat(formarArr[i]);
                try
                {
                    Date date = sdf.parse(dateArr[0]);
                    logger.debug("after converting: date: " + date);
                    validFormatIndex=i;
                    logger.debug("尝试使用格式 "+formarArr[i]+" 转换 "+dateArr[0]+" 成功,准备返回");
                    return date;
                }
                catch (ParseException e)
                {
//                    e.printStackTrace();
                    logger.debug("尝试使用格式 "+formarArr[i]+" 转换 "+dateArr[0]+" 异常");
                }
            }
        }

        if (String.class == toType)
        {
            Date date = (Date) value;
//            return "张伟林日期: " + sdf.format(date);
            sdf = new SimpleDateFormat(formarArr[validFormatIndex]);
            return sdf.format(date);
        }
        
        logger.warn("日期转换异常，您的日期参数格式极有可能非法，准备返回null");
        return null;
    }
}
