package com.zwlsoft.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class IndexAction {

	@RequestMapping(value = "/index")
	public String index() throws Exception {
		System.out.println("index");
		return "index";
	}
	@RequestMapping(value = "/index.do")
	public String execute() throws Exception {
		System.out.println("execute");
		return "index";
	}
	@RequestMapping(value = "/test/index.do")
	public String testIndex() throws Exception {
		return "/test/index";
	}

}
