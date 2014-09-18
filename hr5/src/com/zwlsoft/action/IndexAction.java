package com.zwlsoft.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zwlsoft.service.RoleService;

@Controller
@RequestMapping("/")
public class IndexAction {

    @Autowired
    private RoleService roleService;
    
	@RequestMapping(value = "/index")
	public String index() throws Exception {
		System.out.println("index");
		roleService.selectAllList();
		return "index";
	}
	@RequestMapping(value = "/index.do")
	public String execute() throws Exception {
		System.out.println("execute");
		roleService.selectAllList();
		return "index";
	}
	@RequestMapping(value = "/test/index.do")
	public String testIndex() throws Exception {
		return "/test/index";
	}

}
