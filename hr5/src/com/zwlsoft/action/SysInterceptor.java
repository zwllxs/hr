package com.zwlsoft.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.zwlsoft.constant.Constant;
import com.zwlsoft.po.User;
import com.zwlsoft.service.UserService;

public class SysInterceptor implements HandlerInterceptor
{
    private Logger log = Logger.getLogger(SysInterceptor.class);

    @Autowired
    private UserService userService;
    
    private String[] exclude;
    
    public SysInterceptor()
    {
        // TODO Auto-generated constructor stub
    }

    private String mappingURL;// 利用正则映射到需要拦截的路径

    public void setMappingURL(String mappingURL)
    {
        this.mappingURL = mappingURL;
    }

    /**
     * 在业务处理器处理请求之前被调用 如果返回false 从当前的拦截器往回执行所有拦截器的afterCompletion(),再退出拦截器链
     * 如果返回true 执行下一个拦截器,直到所有的拦截器都执行完毕 再执行被拦截的Controller 然后进入拦截器链,
     * 从最后一个拦截器往回执行所有的postHandle() 接着再从最后一个拦截器往回执行所有的afterCompletion()
     * 进action前调用
     */
    @Override
    public boolean preHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler) throws Exception
    {
        System.out.println("handler: " + handler.getClass());
        System.out.println("userService: " + userService);
//        String userName=request.getParameter("userName");
//        String password=request.getParameter("password");
//        User user=userService.login(userName,password);
//        System.out.println("user: "+user);
        
        // TODO Auto-generated method stub
//        log.info("==============执行顺序: 1、preHandle================");
//        String url = request.getRequestURL().toString();//请求全路径
//        if (handler instanceof HandlerMethod)
//        {
//            HandlerMethod handlerMethod=(HandlerMethod) handler;
//            System.out.println("handlerMethod:  "+handlerMethod);
//        }
        
//        String url = request.getRequestURL().toString();//请求全路径
        String url = request.getServletPath();
        url=url.replaceAll("\\..*", "");
        if (null!=exclude)
        {
            for (String excludePath : exclude)
            {
                //如果请求的是不需要拦截的
                if (excludePath.equals(url))
                {
                    System.out.println("不需要拦截");
                    return true;
                }
            }
        }
        
        System.out.println("exclude: "+StringUtils.join(exclude,","));
        System.out.println("url: "+url);
        
        //第一步，核验登陆
        HttpSession session=request.getSession();
        User user=(User) session.getAttribute(Constant.adminSessionKey);
        if (null==user)
        {
            System.out.println("未登陆");
            //未登陆.跳到登陆页面
//            request.getRequestDispatcher("/login.jsp").forward(request, response);
            request.getRequestDispatcher("/WEB-INF/pages/admin/login.jsp").forward(request, response);
            return false;
        }
        System.out.println("拦截 : "+user);
        return true;
    }

    // 在业务处理器处理请求执行完成后,生成视图之前执行的动作
    @Override
    public void postHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception
    {
        // TODO Auto-generated method stub
        log.info("==============执行顺序: 2、postHandle================");
    }

    /**
     * 在DispatcherServlet完全处理完请求后被调用
     * 当有拦截器抛出异常时,会从当前拦截器往回执行所有的拦截器的afterCompletion()
     */
    @Override
    public void afterCompletion(HttpServletRequest request,
            HttpServletResponse response, Object handler, Exception ex)
            throws Exception
    {
        // TODO Auto-generated method stub
        log.info("==============执行顺序: 3、afterCompletion================");
    }

    public String[] getExclude()
    {
        return exclude;
    }

    public void setExclude(String[] exclude)
    {
        this.exclude = exclude;
    }

}
