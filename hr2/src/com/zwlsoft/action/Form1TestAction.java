package com.zwlsoft.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.DataBinder;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.zwlsoft.bean.Person;
import com.zwlsoft.bean.Person2;
import com.zwlsoft.utils.PersonValidator;

/**
 * 表单tag
 * 
 * @author zhangweilin
 */
@Controller
public class Form1TestAction extends MultiActionController
{

    private final static Logger log = Logger
            .getLogger(Form1TestAction.class);

    /**
     * 表单验证
     * @param binder
     */
    @InitBinder
    public void initBinder(DataBinder binder)
    {
        binder.setValidator(new PersonValidator());
    }

    @RequestMapping("/form1/show{valid1}")
    public ModelAndView showForm1(@PathVariable("valid1") String valid1)
    {
        System.out.println("valid1: "+valid1);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("test", "张伟林");
        map.put("command", new Person("张伟林1(默认为command)", 22)); // 如果页面表单标签中未要绑定的属性，则默认值为command
        // map.put("command", new Person()); //如果页面表单标签中未要绑定的属性，则默认值为command

        // 提供选定值 (list只能让value和text都一样)
        List<String> roleList = new ArrayList<String>();
        roleList.add("1");
        roleList.add("2");
        roleList.add("5");
        roleList.add("6");

        // //提供选项()
        List<String> role2List = new ArrayList<String>();
        // role2List.add("1");
        // role2List.add("2");
        // role2List.add("3");
        // role2List.add("第四个");
        // role2List.add("5");
        // role2List.add("6");
        // role2List.add("7");
        // role2List.add("8");
        // role2List.add("9");

        // (map能让value和text不一样,value是key,text是value)
        Map<String, String> map2 = new HashMap<String, String>();
        map2.put("1", "第一个");
        map2.put("2", "第二个");
        map2.put("3", "第三个");
        map2.put("4", "第四个");
        map2.put("5", "第五个");

        Person person = new Person("张伟林1(值被改为person)", 32);
        person.setRoleList(roleList);

        // 单选radiobuttons或select
        Map<Integer, String> ballMap = new HashMap<Integer, String>();
        ballMap.put(1, "篮球");
        ballMap.put(2, "足球");
        ballMap.put(3, "乒乓球");
        ballMap.put(4, "羽毛球");
        ballMap.put(5, "排球");
        person.setFavoriteBall("3");

        map.put("person", person); // 如果页面表单标签中未要绑定的属性，则默认值为command
        map.put("role2List", role2List);
        map.put("map2", map2);
        map.put("ballMap", ballMap);
        return new ModelAndView(valid1+"form1", map);
    }

    /**
     * 如果是使用 method=RequestMethod.DELETE，则需要配置相应过滤器 HiddenHttpMethodFilter
     * 
     * @param person
     * @return
     */
    @RequestMapping(value = "/form1/save1.do", method = RequestMethod.DELETE)
    public String save1(Person person)
    {
        System.out.println("person: " + person);
        return "ok";
    }

    /**
     * 有表单校验(实现接口)
     * @param person
     * @param errors
     * @return
     */
    @RequestMapping(value = "/form1/save2.do")
    public  ModelAndView save2(@Validated  Person person,  Errors errors)
    {
        System.out.println("person: " + person);
        System.out.println("errors.hasFieldErrors(): " + errors.hasFieldErrors());
        System.out.println("errors.getAllErrors(): "+errors.getAllErrors());
        if (errors.hasFieldErrors())
        {
            return new ModelAndView("validform1");
        }
        return new ModelAndView("validform1");
    }
    
    /**
     * 有表单校验(注解式)
     * @param person
     * @param errors
     * @return
     */
    @RequestMapping(value = "/form1/save3.do")
    public  String save3(@Valid  Person2 person,  BindingResult result,Model model)
    {
        System.out.println("person2: " + person);
        System.out.println("result.hasErrors(): "+result.hasErrors());
        System.out.println("result.getAllErrors(): "+result.getAllErrors());
        model.addAttribute("test", "张伟林");
        if (result.hasErrors())
        {
            return "validform1";
        }
        return "validform1";
    }

}
