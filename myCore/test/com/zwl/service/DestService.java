package com.zwl.service;

import java.util.Map;

import com.zwl.core.service.Service;
import com.zwlsoft.po.Country;

/**
 * 目的地业务接口
 * @author xiexun
 *
 */
public interface DestService extends Service<Country> {

	/**
	 * 查询目的地列表(已注入父目的地)
	 * @param param
	 * @return
	 */
	public void findDestList(Map<String, Object> param) ;
 
	
}