package com.zwl.core.util;

import javax.servlet.ServletContext;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class SpringContextUtil {
	 public SpringContextUtil(){
	 }

	 public static WebApplicationContext getSpringContext(ServletContext sc){
	    return WebApplicationContextUtils.getWebApplicationContext(sc);
	 }

	 public static Object getBean(ServletContext sc, String name){
	     return getSpringContext(sc).getBean(name);
	 }

}
