package com.zwlsoft.service.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.zwlsoft.po.Role;

@Repository
public class RoleDao extends MyBatisDao {
    public RoleDao() {
    	super("role");
	}

    
	/**
	 * 查询当前目的子孙目的地列表
	 * @param destId
	 * @return
	 */
	public List<Role> selectAll(){
		return super.queryForList("selectAll");
	}
	
}