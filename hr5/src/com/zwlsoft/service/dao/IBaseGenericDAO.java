package com.zwlsoft.service.dao;

import java.io.Serializable;
import java.util.List;

/**
 * 基于Mybatis的基础DAO接口
 * 
 * @author 赵士杰
 * 
 * @param <T> 业务实体类型
 * @param <Id> Id类型 ，如：String、Long、Integer 等
 */
public interface IBaseGenericDAO<T> {

    /**
     * 保存（持久化）对象
     * @param o 要持久化的对象
     * @return 执行成功的记录个数
     */
	public Integer save(T t);
	
	 
    /**
     * 直接执行sqlId
     * @param sqlId
     * @param paramObj
     * @return
     */
    int insert(String sqlId, Object paramObj);

    /**
     * 直接执行sqlId
     * @param sqlId
     * @return
     */
    int insert(String sqlId);
	
    /**
     * 删除指定的唯一标识符对应的持久化对象
     *
     * @param id 指定的唯一标识符
     * @return 删除的对象数量
     */
    public Integer deleteById(Serializable id);

    /**
     * 删除指定的唯一标识符数组对应的持久化对象
     *
     * @param ids 指定的唯一标识符数组
     * @return 删除的对象数量
     */
    public Integer deleteByIds(Serializable...ids);
    

    /**
     * 直接执行sqlId
     * @param sqlId
     * @return
     */
    int delete(String sqlId, Object paramObj);

    /**
     * 直接执行sqlId
     * @param sqlId
     * @return
     */
    int delete(String sqlId);
    
    /**
     * 直接执行sqlId
     * @param sqlId
     * @return
     */
    int update(String sqlId);
    
    /**
     * 直接执行sqlId
     * @param sqlId
     * @return
     */
    int update(String sqlId, Object paramObj);

    /**
     * 更新（持久化）对象. 
     * @param t 更新该参数有值的字段
     * @return
     */
	public Integer updateSelectedColumn(T t);
	
	/**
	 * 更新（持久化）对象
	 * @param t 更新所有的字段
	 * @return 执行成功的记录个数
	 */
	public Integer updateAllColumn(T t);

    /**
     * 获取指定的唯一标识符对应的持久化对象
     *
     * @param id 指定的唯一标识符
     * @return 指定的唯一标识符对应的持久化对象，如果没有对应的持久化对象，则返回null。
     */
	public T selectById(Serializable id);
	
    /**
     * 按id批量查
     * @param id
     * @return
     */
    List<T> selectByIds(Serializable...id);
	
    /**
     * 直接查询sqlId
     * @param sqlId
     * @param paramObj
     * @return
     */
    T selectOne(String sqlId, Object paramObj);

    /**
     * 直接查询sqlId
     * @param sqlId
     * @return
     */
    T selectOne(String sqlId);
    

//    List<T> selectListByExample(String sqlId, AbstractEntity abstractEntity);
    
    /**
     * 直接查询sqlId
     * @param sqlId
     * @param paramObj
     * @return
     */
    List<T> selectList(String sqlId, Object paramObj);

    /**
     * 直接查询sqlId
     * @param sqlId
     * @return
     */
    List<T> selectList(String sqlId);

    /**
     * 按指定对象模型查询列表
     * @param t
     * @return
     */
    List<T> selectListBySelected(T t);

}
