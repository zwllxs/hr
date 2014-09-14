package com.zwlsoft.mapper;

import java.util.List;
import java.util.Map;

import com.zwlsoft.model.BaseModel;

/**
 * 此处所有接口，均无须实现，直接在 EmployeMapper.xml中有对应sqlId,即直接调方法名对应sqlId
 *<p>
 *description:
 *</p>
 * @author ex_zhangwl
 * @since 2013-7-12
 * @see
 */
public interface BaseMapper<T> {
	
	public void insert(T t) throws Exception;
	
	public void update(T t) throws Exception;
	
	public void updateBySelective(T t) throws Exception;
	
	public void delete(Long ids) throws Exception;
	
	
	public T selectById(Long Id) throws Exception;
	
	public Integer selectByModelCount(BaseModel  map) throws Exception;
	
	public Integer selectByMapCount(Map  map) throws Exception;
	
	public List<T> selectByModel(BaseModel model) throws Exception;
	
	public List<T> selectByMap(Map  map) throws Exception;
	
	
	
}
