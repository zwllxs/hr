package com.zwl.core.scheduling.quartz;

import java.io.File;
import java.net.URL;
import java.text.ParseException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.CronTriggerBean;

import com.zwl.core.util.PropertiesUtil;
import com.zwl.core.util.StringUtil;
/**
 * 从自己的配置文件中读取定时规则表达式
 * @author zhangweilin
 *
 */
public class ZwlCronTrigger extends CronTriggerBean
{
    private static final Logger logger = LoggerFactory.getLogger(ZwlCronTrigger.class);
    
    /**
     * 
     */
    private static final long serialVersionUID = 1811273886905373909L;

    /**
     * sys.properties里配置的key对应的值
     * @param sysKey
     * @throws ParseException
     */
    public void setSysKey(String sysKey) throws ParseException
    {
        
        URL url=getClass().getClassLoader().getResource("");
        String filePath=url.getFile();
        filePath=filePath+"conf"+File.separator+"sys.properties";
        logger.debug("加载 "+filePath);
        PropertiesUtil pu=PropertiesUtil.getPropertiesUtil(filePath);
        String cronExpression=pu.read(sysKey);
        logger.debug("从"+sysKey+"中读取到值为: "+cronExpression);
        if (StringUtil.isInvalid(cronExpression))
        {
            throw new ParseException("请在conf"+File.separator+"sys.properties 中定义合理 "+sysKey+" 值", 0);
        }
        setCronExpression(cronExpression);
    }
   
}
