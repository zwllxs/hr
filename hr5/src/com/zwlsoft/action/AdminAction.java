package com.zwlsoft.action;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.pagehelper.PageInfo;
import com.zwlsoft.constant.Constant;
import com.zwlsoft.po.Country;
import com.zwlsoft.po.User;
import com.zwlsoft.service.CountryService;
import com.zwlsoft.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminAction extends BaseActionSupport
{
    @Autowired
    private UserService userService;
    
    @Autowired
    private CountryService countryService;
     
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
        
        
        return "/admin/index";
    }
    
    /**
     * 登陆
     * @return
     */
    @RequestMapping(value = "/login")
    public String login(User user)
    {
        String userName=user.getUserName();
        System.out.println("userName:  "+userName);
        String password=user.getPassword();
        User user1=userService.login(userName,password);
        System.out.println("user1: "+user1);
        //登陆 成功
        if (null!=user1)
        {
            session.setAttribute(Constant.adminSessionKey, user1);
            return "redirect:/admin/index.html";
        }
        return "login";
    }
    
    /**
     * 登陆
     * @return
     */
    @RequestMapping(value = "/login2")
    public String login2(@Valid User user,  BindingResult result)
    {
        String userName=user.getUserName();
        System.out.println("userName:  "+userName);
        String password=user.getPassword();
        
//        ObjectError objectError=new ObjectError("user.userName", "非法的用户名");
//        ObjectError objectError=new ObjectError("user.userName", "非法的用户名");
//        result.addError(objectError);
        
//        result.rejectValue("userName", "非法的用户名2");
//        result.addAllErrors(arg0);
        
        System.out.println("result.hasErrors(): "+result.hasErrors());
        System.out.println("result.getAllErrors(): "+result.getAllErrors());
       
        
        if (result.hasErrors())
        {
            return "/admin/login";
        }
        
        User user1=userService.login(userName,password);
        System.out.println("user1: "+user1);
        //登陆 成功
        if (null!=user1)
        {
            session.setAttribute(Constant.adminSessionKey, user1);
            return "redirect:/admin/index.html";
        }
        return "login";
    }

    @RequestMapping("/un_login")
    public String unLogin()
    {
        session.invalidate();
        return "/admin/login";
    }
    
    @RequestMapping("/page/list")
    public String listCountry2(PageInfo pageInfo)
    {
        Country country=new Country(); 
        country.setId(30);
        country.putSignMap("id", ">"); 
        System.out.println("/page/list2: " + pageInfo);
//        PageHelper.startPage(1, 3);
        System.out.println("pageInfo2: "+pageInfo);
        List<Country> countrylist=countryService.selectListBySelected(country,pageInfo);
        System.out.println("countrylist: "+countrylist);
//        countryService.selectListBySelected(country);
        return "ok";
    }
    
    /**
     * 分页不需要传分页组件了
     * @return
     */
    @RequestMapping("/page/list2")
    public String listCountry2()
    {
        Country country=new Country(); 
        country.setId(30);
        country.putSignMap("id", ">"); 
        System.out.println("/page/list3: " + pageInfo);
//        PageHelper.startPage(1, 3);
        System.out.println("pageInfo4: "+pageInfo);
        List<Country> countrylist=countryService.selectListBySelected(country,pageInfo);
        System.out.println("countrylist2: "+countrylist);
//        countryService.selectListBySelected(country);
        return "ok";
    }
}
