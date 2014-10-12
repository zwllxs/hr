package com.zwlsoft.action;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zwlsoft.po.RequireMent;
import com.zwlsoft.po.User;
import com.zwlsoft.service.RequireMentService;

@Controller
@RequestMapping("/")
public class IndexAction extends BaseActionSupport
{
    @Autowired
    private RequireMentService requireMentService;
     
    /**
     * 首页
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/index")
    public String index() throws Exception
    {
        System.out.println("index");
//        System.out.println("getRequest(): "+getRequest());
//        System.out.println("getRequest()2: "+getRequest().getParameter("name"));
        model.addAttribute("type","index");
        
        return "/web/index";
    }

    /**
     * 不同的链接，加载不同的子页面
     * @param type
     * @param model
     * @return
     */
    @Token
    @RequestMapping("/web/{type}")
    public String type(@PathVariable("type") String type,Model model)
    {
        System.out.println("type: "+type);
        model.addAttribute("type",type);
        return "/web/index";
    }
    
    /**
     * 提交需求
     */
    @Token
    @RequestMapping("/submit_require_ment")
    public String submitRequireMent(@Valid RequireMent requireMent,BindingResult result)
    {
        System.out.println("requireMent: "+requireMent);
        requireMentService.save(requireMent);
        
        model.addAttribute("ok","提交成功，我们将会在第一时间联系您");
        model.addAttribute("type","leave_message");
        return "/web/index";
    }
    
}
