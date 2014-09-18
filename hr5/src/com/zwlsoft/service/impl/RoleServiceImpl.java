package com.zwlsoft.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwlsoft.po.Role;
import com.zwlsoft.service.RoleService;
import com.zwlsoft.service.dao.RoleDao;

@Service
public class RoleServiceImpl implements RoleService
{
    @Autowired
    private RoleDao roleDao;
    
    @Override
    public List<Role> selectAllList()
    {
        List<Role> roleList=roleDao.selectAll();
        System.out.println("roleList: "+roleList);
        return roleList;
    }

}
