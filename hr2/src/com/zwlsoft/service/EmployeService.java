package com.zwlsoft.service;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwlsoft.mapper.EmployeMapper;

/**
 * 
 * <br>
 * <b>功能：</b>EmployeService<br>
 * <b>作者：</b>罗泽军<br>
 * <b>日期：</b> Dec 9, 2011 <br>
 * <b>版权所有：<b>版权所有(C) 2011，WWW.VOWO.COM<br>
 */
@Service("employeService")
public class EmployeService<T> extends BaseService<T> {
	private final static Logger log= Logger.getLogger(EmployeService.class);
	

	

	@Autowired
    private EmployeMapper<T> mapper;

		
	public EmployeMapper<T> getMapper() {
		return mapper;
	}

}
