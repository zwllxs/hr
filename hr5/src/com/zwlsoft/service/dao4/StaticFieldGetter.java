package com.zwlsoft.service.dao4;

import java.lang.reflect.Field;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class StaticFieldGetter
{
  private static Log _log = LogFactory.getLog(StaticFieldGetter.class);

  private static StaticFieldGetter _instance = new StaticFieldGetter();

  public static StaticFieldGetter getInstance()
  {
    return _instance;
  }

  public Object getFieldValue(String className, String fieldName)
  {
    Object obj = null;
    try
    {
      Class objClass = Class.forName(className);

      Field field = objClass.getField(fieldName);

      obj = field.get(objClass);
    }
    catch (Exception e) {
      _log.error(e);
    }

    return obj;
  }
}