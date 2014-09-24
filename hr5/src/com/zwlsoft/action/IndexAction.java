package com.zwlsoft.action;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zwlsoft.po.Country;

@Controller
@RequestMapping("/")
public class IndexAction
{
    @RequestMapping(value = "/index")
    public String index() throws Exception
    {
        System.out.println("index");
        return "index";
    }
    @RequestMapping(value = "/index.do")
    public String execute() throws Exception
    {
        System.out.println("execute");
        return "index";
    }
    
//    @RequestMapping("/list") 
//    public String listCountry(PageInfo<Country> pageInfo){
//        System.out.println("分页: "+pageInfo);
//        return "list";
//    }
    
    @RequestMapping("/list.do") 
    public ModelAndView listCountry(PageInfo pageInfo){
        
        PageHelper.startPage(1, 3);
        List<Country> countryList=new ArrayList<>();
//        PageInfo<Country> pageInfo=new PageInfo<>(countryList);
        System.out.println("分页: "+pageInfo);
        
        
        
        return null;
    }

}
