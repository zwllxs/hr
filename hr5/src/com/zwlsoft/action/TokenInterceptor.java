package com.zwlsoft.action;

import java.lang.reflect.Method;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 返回 true 则通过，返回false,不通过，被拦截
 * @author zhangweilin
 *
 */
public class TokenInterceptor extends HandlerInterceptorAdapter
{
    @Override
    public boolean preHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler) throws Exception
    {
        
//        return true;
        if (handler instanceof HandlerMethod)
        {
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            Method method = handlerMethod.getMethod();
            Token annotation = method.getAnnotation(Token.class);
            if (annotation != null)
            {
                boolean needRemoveSession = annotation.remove();
                if (needRemoveSession)
                {
                    //重复提交。被拦掉
                    if (isRepeatSubmit(request))
                    {
                        request.setAttribute("error", "您已经提交过，无需重复提交");
                        request.setAttribute("type", "leave_message");
                        request.getRequestDispatcher("/WEB-INF/pages/web/index.jsp").forward(request, response);
                        return false;
                    }
//                    request.getSession().removeAttribute("token");
                }
                
                boolean needSaveSession = annotation.save();
                if (needSaveSession)
                {
                    //只有为空时，才是第一次，只有第一次，才重新生产token
//                    String clinetToken = request.getParameter("token");
//                    if(StringUtils.isEmpty(clinetToken))
//                    {
                        request.getSession().setAttribute("token",
                                UUID.randomUUID().toString());
//                    }
                    
                }
               
            }
//            request.getSession().removeAttribute("token");
            return true;
        }
        else
        {
            return super.preHandle(request, response, handler);
        }
    }
    
    /**
     * 是否重复提交
     * @param request
     * @return
     */
    private boolean isRepeatSubmit(HttpServletRequest request)
    {
        //本次服务端产生的token
        String serverToken = (String) request.getSession().getAttribute(
                "token");
        if (StringUtils.isEmpty(serverToken))
        {
//            request.getSession().removeAttribute("token");
            return false;
        }
        //客户端产生的token
        String clinetToken = request.getParameter("token");
        if (StringUtils.isEmpty(clinetToken))
        {
            return false;
        }
        //如果一样，表示不是重复提交，否则是重复提交
        if (!serverToken.equals(clinetToken))
        {
            return true;
        }
        return false;
    }
}
