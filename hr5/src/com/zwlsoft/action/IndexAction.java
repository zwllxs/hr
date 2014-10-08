package com.zwlsoft.action;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class IndexAction extends BaseActionSupport
{
     
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

    @RequestMapping("/web/{type}")
    public String type(@PathVariable("type") String type,Model model)
    {
        System.out.println("type: "+type);
        model.addAttribute("type",type);
        return "/web/index";
    }
    
    
}
