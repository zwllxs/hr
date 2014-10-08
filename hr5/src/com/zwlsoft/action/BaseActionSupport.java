package com.zwlsoft.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.ognl.NoSuchPropertyException;
import org.apache.ibatis.ognl.Ognl;
import org.apache.ibatis.ognl.OgnlException;
import org.apache.log4j.Logger;
import org.apache.poi.util.IOUtils;
import org.springframework.ui.Model;


/**
 * ACTION基类,提供一些Web层常用的公共的方法
 * 
 * @author zhangweilin
 * 
 */
public class BaseActionSupport extends BaseCommonAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = -6335785306515453401L;
	protected Logger log = Logger.getLogger(this.getClass());
	public static final String SESSION_BACK_USER="SESSION_BACK_USER";
	
	
	protected String getMethod(HttpServletRequest request) {
		return request.getMethod();
	}

	@SuppressWarnings("unchecked")
	protected Map<String, Object> getParameters(HttpServletRequest request) {
		return request.getParameterMap();
	}

	protected String getRequestParameter(String key, HttpServletRequest request) {
		return request.getParameter(key);
	}

	protected void saveMessage(String msg, HttpServletRequest request) {
		request.setAttribute("messages", msg);
	}

	protected void errorMessage(String msg, HttpServletRequest request) {
		request.setAttribute("errorMessages", msg);
	}

	protected String getCookieValue(String cookieName, HttpServletRequest request) {
		Cookie cookie = getCookie(request, cookieName);
		return cookie == null ? null : cookie.getValue();
	}

	public static Cookie getCookie(HttpServletRequest request, String name) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(name)) {
					return cookie;
				}
			}
		}
		return null;
	}

	public void sendAjaxMsg(String msg, HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		try {
			PrintWriter out = response.getWriter();
			out.write(msg);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void sendAjaxMsg(String msg) {
		this.sendAjaxMsg(msg, request, response);
	}
	

	/**
	 * 发送Ajax请求结果json
	 * 
	 * @throws ServletException
	 * @throws IOException
	 */
	public void sendAjaxResultByJson(String json, HttpServletResponse response) {
		response.setContentType("application/json;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		try {
			PrintWriter out = response.getWriter();
			out.write(json);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void sendAjaxResultByJson(String json){
		this.sendAjaxResultByJson(json,response);
	}

	protected void setRequestAttribute(String key, Object value, HttpServletRequest request) {
		request.setAttribute(key, value);
	}

	/**
	 * 将文件写入附件
	 * 
	 * @param destFileName
	 * @param attachmentName
	 */
	public void writeAttachment(String destFileName, String attachmentName, HttpServletResponse response) {
		FileInputStream fin = null;
		OutputStream os = null;
		try {
			File f = new File(destFileName);
			if ((attachmentName == null) || "".equals(attachmentName)) {
				attachmentName = f.getName();
			}
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment; filename=" + attachmentName + ".xls");
			os = response.getOutputStream();
			fin = new FileInputStream(f);
			IOUtils.copy(fin, os);
			os.flush();
 			os.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			org.apache.commons.io.IOUtils.closeQuietly(fin); 
			org.apache.commons.io.IOUtils.closeQuietly(os);
		}
 
	}
	
	/**
	 * 提取登录用户ID
	 * @return
	 */
//	public String getLoginUserId(){
//		PermUser pu = getLoginUser();
//		if(null != pu){
//			return pu.getUserName();
//		}else{
//			return "";
//		}
//	}
	
//	protected boolean isBackUserLogin(){
//		return getLoginUser()!=null;
//	}
//	
//	protected PermUser getLoginUser(){
////		PermUser pu =new PermUser();
////		pu.setUserName("4028807b40e851100140e85110990000");
////		pu.setRealName("aaaaaa1");
//		PermUser pu = (PermUser)getSession(SESSION_BACK_USER);
//		return pu;
//	}
//	
	public void InitRequest2Field(HttpServletRequest request) throws Exception{
		@SuppressWarnings("unchecked")
		Enumeration<String> enumeration = request.getParameterNames();
		while (enumeration.hasMoreElements()) {
			String key = enumeration.nextElement();
			try {
				Ognl.setValue(key, this,request.getParameter(key));
			} catch (NoSuchPropertyException e) {
				e.printStackTrace();
			} catch(OgnlException e){
				e.printStackTrace();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	
	public void InitField2Response(Model model) throws Exception {
		if(model==null){
			return;
		}
		Class<?> cls = this.getClass(); 
        Method methlist[] = cls.getMethods(); 
        for (Method method : methlist) {
        	if(method.getName().length()>3 
        			&& "get".equals(method.getName().substring(0,3))
        			&& method.getParameterTypes().length==0
        			&& method.toString().indexOf("public")==0){
    			String methodName = method.getName().substring(3);
    			methodName = methodName.substring(0,1).toLowerCase();
    			methodName+=method.getName().substring(4);
    			try {
    				Object ret = method.invoke(this);
    				model.addAttribute(methodName,ret);
				} catch (Exception e) {
					e.printStackTrace();
				}
        	}
		}
	}
	
}