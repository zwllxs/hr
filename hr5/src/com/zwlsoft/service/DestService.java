package com.zwlsoft.service;

import java.util.Map;

/**
 * 目的地业务接口
 * @author xiexun
 *
 */
public interface DestService {

	/**
	 * 查询目的地列表(已注入父目的地)
	 * @param param
	 * @return
	 */
	public void findDestList(Map<String, Object> param) ;
 
	
}