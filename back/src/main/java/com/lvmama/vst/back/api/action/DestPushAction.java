package com.lvmama.vst.back.api.action;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lvmama.vst.back.BaseActionSupport;
import com.lvmama.vst.back.biz.service.DestService;


@SuppressWarnings("serial")
@Controller
@RequestMapping("/api/push/dest")
public class DestPushAction extends BaseActionSupport {
	
	/**
	 * 日志记录器
	 */
	private static final Log LOGGER = LogFactory.getLog(DestPushAction.class);
	

	
	@Autowired
	private DestService destService;
	
	
	
	/**
	 * 根据ID获得目的地
	 */
	@RequestMapping(value = "/searchDestById")
	@ResponseBody
	public Object searchDestById(Long destId){ 
		System.out.println("destService: "+destService);	
		return "";
	}
	
	 
}
