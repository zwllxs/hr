//package com.zwlsoft.service.dao4;
//
//import org.apache.commons.beanutils.PropertyUtils;
//import org.apache.commons.logging.Log;
//import org.apache.commons.logging.LogFactory;
//
//public class BeanUtil
//{
//  private static Log _log = LogFactory.getLog(BeanUtil.class);
//
//  public static boolean getBoolean(Object bean, String param)
//  {
//    return getBoolean(bean, param, false);
//  }
//
//  public static boolean getBoolean(Object bean, String param, boolean defaultValue)
//  {
//    Boolean beanValue = null;
//
//    if (bean != null) {
//      try {
//        beanValue = (Boolean)PropertyUtils.getSimpleProperty(bean, param);
//      }
//      catch (Exception e)
//      {
//        _log.error(e);
//      }
//    }
//
//    if (beanValue == null) {
//      return defaultValue;
//    }
//
//    return beanValue.booleanValue();
//  }
//
//  public static double getDouble(Object bean, String param)
//  {
//    return getDouble(bean, param, 0.0D);
//  }
//
//  public static double getDouble(Object bean, String param, double defaultValue)
//  {
//    Double beanValue = null;
//
//    if (bean != null) {
//      try {
//        beanValue = (Double)PropertyUtils.getSimpleProperty(bean, param);
//      }
//      catch (Exception e)
//      {
//        _log.error(e);
//      }
//    }
//
//    if (beanValue == null) {
//      return defaultValue;
//    }
//
//    return beanValue.doubleValue();
//  }
//
//  public static int getInteger(Object bean, String param)
//  {
//    return getInteger(bean, param, 0);
//  }
//
//  public static int getInteger(Object bean, String param, int defaultValue)
//  {
//    Integer beanValue = null;
//
//    if (bean != null) {
//      try {
//        beanValue = (Integer)PropertyUtils.getSimpleProperty(bean, param);
//      }
//      catch (Exception e)
//      {
//        _log.error(e);
//      }
//    }
//
//    if (beanValue == null) {
//      return defaultValue;
//    }
//
//    return beanValue.intValue();
//  }
//
//  public static long getLong(Object bean, String param)
//  {
//    return getLong(bean, param, 0L);
//  }
//
//  public static long getLong(Object bean, String param, long defaultValue)
//  {
//    Long beanValue = null;
//
//    if (bean != null) {
//      try {
//        beanValue = (Long)PropertyUtils.getSimpleProperty(bean, param);
//      }
//      catch (Exception e)
//      {
//        _log.error(e);
//      }
//    }
//
//    if (beanValue == null) {
//      return defaultValue;
//    }
//
//    return beanValue.longValue();
//  }
//
//  public static Object getObject(Object bean, String param)
//  {
//    Object beanValue = null;
//
//    if (bean != null) {
//      try {
//        beanValue = PropertyUtils.getSimpleProperty(bean, param);
//      }
//      catch (Exception e) {
//        _log.error(e);
//      }
//    }
//
//    return beanValue;
//  }
//
//  public static String getString(Object bean, String param) {
//    return getString(bean, param, "");
//  }
//
//  public static String getString(Object bean, String param, String defaultValue)
//  {
//    String beanValue = null;
//
//    if (bean != null) {
//      try {
//        beanValue = (String)PropertyUtils.getSimpleProperty(bean, param);
//      }
//      catch (Exception e)
//      {
//        _log.error(e);
//      }
//    }
//
//    if (beanValue == null) {
//      return defaultValue;
//    }
//
//    return beanValue;
//  }
//}