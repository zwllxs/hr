package com.zwlsoft.service.dao4;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.sun.xml.internal.bind.v2.model.core.ID;
import com.zwlsoft.po.AbstractEntity;
import com.zwlsoft.po.Entity;

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
     * 更新（持久化）对象
     * @param o 要持久化的对象
     * @return 执行成功的记录个数
     */
	public Integer update(T t);

    /**
     * 获取指定的唯一标识符对应的持久化对象
     *
     * @param id 指定的唯一标识符
     * @return 指定的唯一标识符对应的持久化对象，如果没有对应的持久化对象，则返回null。
     */
	public T getById(Serializable id);

    /**
     * 删除指定的唯一标识符对应的持久化对象
     *
     * @param Id 指定的唯一标识符
	 * @return 删除的对象数量
     */
	public Integer deleteById(Serializable Id);

    /**
     * 删除指定的唯一标识符数组对应的持久化对象
     *
     * @param Ids 指定的唯一标识符数组
	 * @return 删除的对象数量
     */
	public Integer deleteByIds(Serializable[] Ids);

    Map selectMap(String statement, String mapKey);

    int update(String statement);

    int insert(String statement, Object parameter);

    int insert(String statement);

    int update(String statement, Object parameter);

    int delete(String statement, Object parameter);

    int delete(String statement);

    List<T> selectListByExample(String statement, AbstractEntity abstractEntity);
    
    List<T> selectList(String statement, Object parameter);

    List<T> selectList(String statement);

    Object selectOne(String statement, Object parameter);

    Object selectOne(String statement);

    Map selectMap(String statement, Object parameter, String mapKey,
            RowBounds rowBounds);

    Map selectMap(String statement, Object parameter, String mapKey);

}
