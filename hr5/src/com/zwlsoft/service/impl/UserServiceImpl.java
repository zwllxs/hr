package com.zwlsoft.service.impl;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import com.zwlsoft.exception.BusinessException;
import com.zwlsoft.po.User;
import com.zwlsoft.service.UserService;
import com.zwlsoft.service.dao.MyIbatisBaseDao;

@Repository(value="userService")
public class UserServiceImpl extends MyIbatisBaseDao<User> implements UserService
{

    @Override
    public User login(String userName, String password)
    {
        if (StringUtils.isEmpty(userName)||StringUtils.isEmpty(password))
        {
            throw new BusinessException("登陆失败，用户名密码不能为空");
        }
        User user0=new User(userName, password);
        //如果是按条件查询，则无法使用按id查询的id,而是用selectListBySelected
//        User user=selectOne(CrudSqlId.selectById.name(), user0);
        return login(user0);
    }

    @Override
    public User login(User user)
    {
        User user2=selectOne(CrudSqlId.selectListBySelected.name(), user);
        return user2;
    }

}
