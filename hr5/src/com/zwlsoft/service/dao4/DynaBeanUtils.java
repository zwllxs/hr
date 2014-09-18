package com.zwlsoft.service.dao4;

import java.util.Map;
import org.apache.commons.beanutils.DynaBean;
import org.apache.commons.beanutils.DynaClass;
import org.apache.commons.beanutils.DynaProperty;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public final class DynaBeanUtils
{
  private static Log logger = LogFactory.getLog(DynaBeanUtils.class);

  public static boolean dynaBeanToMap(DynaBean bean, Map map)
  {
    if (bean == null) {
      logger.debug("DynaBean is null!");
      return true;
    }

    if (map == null) {
      logger.debug("Map of Store DynaBean properties is null!");
      return true;
    }

    DynaClass dc = bean.getDynaClass();
    DynaProperty[] dp = dc.getDynaProperties();
    for (int i = 0; i < dp.length; ++i) {
      String properName = dp[i].getName();
      Object properValue = bean.get(properName);
      map.put(properName, properValue);
    }
    return true;
  }
}