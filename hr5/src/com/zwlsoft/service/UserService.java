package com.zwlsoft.service;

import com.zwlsoft.po.User;
import com.zwlsoft.service.dao.IBaseGenericDAO;

/**
 * 用户
 * @author zhangweilin
 *
 */
public interface UserService extends IBaseGenericDAO<User>
{

    /**
     * 用户登陆 
     * @param userName
     * @param password
     * @return
     */
    User login(String userName, String password);
//    public List<Country> getAll();
    
    /**
     * 用户登陆 
     * @param user
     */
    User login(User user);
}
