package util.json;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * JSON工具类
 * @author 赵士杰
 *
 */
public class DateJsonValueProcessor
    implements JsonValueProcessor
{

    public DateJsonValueProcessor(String datePattern)
    {
        try
        {
            dateFormat = new SimpleDateFormat(datePattern);
        }
        catch(Exception ex)
        {
            logger.info(ex);
            dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        }
    }

    public Object processArrayValue(Object value, JsonConfig jsonConfig)
    {
        return process(value);
    }

    public Object processObjectValue(String key, Object value, JsonConfig jsonConfig)
    {
        return process(value);
    }

    private Object process(Object value)
    {
        try
        {
            return dateFormat.format((Date)value);
        }
        catch(Exception ex)
        {
            return null;
        }
    }

    private static Log logger = LogFactory.getLog(DateJsonValueProcessor.class);
    public static final String DEFAULT_DATE_PATTERN = "yyyy-MM-dd";
    private DateFormat dateFormat;

}


