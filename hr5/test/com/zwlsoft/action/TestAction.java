package com.zwlsoft.action;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zwlsoft.po.Country;
import com.zwlsoft.po.Person;
import com.zwlsoft.service.CountryService;

@Controller
@RequestMapping("/test")
public class TestAction
{
    @Autowired
    private CountryService countryService;
    
    @RequestMapping(value = "/index")
    public String index() throws Exception
    {
        System.out.println("index");
        return "/hr/admin/index";
    }
    @RequestMapping(value = "/index.do")
    public String execute() throws Exception
    {
        System.out.println("execute");
        return "/hr/admin/index";
    }
    
//    @RequestMapping("/list") 
//    public String listCountry(PageInfo<Country> pageInfo){
//        System.out.println("分页: "+pageInfo);
//        return "list";
//    }
    
    
    @RequestMapping(value = "/form1/save22")
    public String save22(Person person)
    {
        System.out.println("person_SAVE22: " + person);
        return "ok";
    }
    
    
    @RequestMapping(value = "/form1/save33.html")
    public String save33(PageInfo pageInfo)
    {
        System.out.println("person_SAVE3344: " + pageInfo);
        return "ok";
    }
    
    
    @RequestMapping("/page/list")
    public String listCountry2(PageInfo pageInfo)
    {
        Country country=new Country(); 
        country.setId(30);
        country.putSignMap("id", ">"); 
        System.out.println("/page/list2: " + pageInfo);
//        PageHelper.startPage(1, 3);
        countryService.selectListBySelected(country,pageInfo);
//        countryService.selectListBySelected(country);
        return "ok";
    }
    
    
    
//    
//    /**
//     * 这种方式，PageInfo接不到值
//     * @param pageInfo
//     * @return
//     */
//    @RequestMapping("/list.do") 
//    public ModelAndView listCountry(PageInfo pageInfo){
//        
//        PageHelper.startPage(1, 3);
//        List<Country> countryList=new ArrayList<>();
////        PageInfo<Country> pageInfo=new PageInfo<>(countryList);
//        System.out.println("分页: "+pageInfo);
//        return null;
//    }
    
    /**
     * action的请求中可以不配置后缀
     * @param pageInfo
     * @return
     */
    @RequestMapping("/test/list") 
    public ModelAndView listCountry(PageInfo pageInfo){
        
        PageHelper.startPage(1, 3);
        List<Country> countryList=new ArrayList<>();
//        PageInfo<Country> pageInfo=new PageInfo<>(countryList);
        System.out.println("分页: "+pageInfo);
        return null;
    }

}
