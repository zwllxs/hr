/**
 * 
 */
package com.zwlsoft.action;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.github.pagehelper.PageInfo;


/**
 * Action的最顶层基类
 * @author zhangweilin
 *
 */
public abstract class BaseCommonAction implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4172813549905256587L;
	
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected Model model;
	/**
	 * 分页组件
	 */
	protected PageInfo pageInfo;

	/**
	 * session
	 */
    protected HttpSession session;
	
//	protected Object getSession(final String key){
//		if(StringUtils.isEmpty(key)){
//			return null;
//		}
//		return ServletUtil.getSession(HttpServletLocalThread.getRequest(), HttpServletLocalThread.getResponse(), key);
//	}
//	
//	protected void putSession(final String key,final Object obj){
//		ServletUtil.putSession(HttpServletLocalThread.getRequest(), HttpServletLocalThread.getResponse(), key, obj);
//	}
//	
//	
//	protected boolean hasLocalServer(){
//		String host = HttpServletLocalThread.getRequest().getLocalName();
//		if(host.contains("127.0.0.1")||host.contains("")){
//			return true;
//		}
//		return false;
//	}
//	
//	
//	protected Cookie getCookie(final String key){
//		return ServletUtil.getCookie(HttpServletLocalThread.getRequest(),
//				key);
//	}
//	
	/**
	 * 在拦截器后调用
	 * @param model
	 * @param request
	 * @param response
	 */
	@ModelAttribute
	public void setReqAndResp(Model model,HttpServletRequest request,HttpServletResponse response,PageInfo pageInfo){
		this.request = request;
		this.response = response;
		this.model = model;
		this.session=request.getSession();
		this.pageInfo=pageInfo;
		
		System.out.println("pageInfo3: "+pageInfo);
//		System.out.println("model: "+model);
//		System.out.println("request: "+request);
//		System.out.println("response: "+response);
		
//	    System.out.println("不设置了");
	}
	
//	protected HttpServletRequest getRequest() {
//		return this.request;  
//	}
//
//	protected HttpServletResponse getResponse() {
//		return  this.response;
//	}
//	
//	protected HttpSession getSession() {
//		return this.getRequest().getSession();
//	}
}
