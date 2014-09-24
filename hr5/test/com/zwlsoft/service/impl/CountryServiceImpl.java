package com.zwlsoft.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.zwlsoft.po.Country;
import com.zwlsoft.service.CountryService;
import com.zwlsoft.service.dao.MyIbatisBaseDao;

@Repository(value="countryService")
public class CountryServiceImpl extends MyIbatisBaseDao<Country> implements CountryService
{

    @Override
    public List<Country> getAll()
    {
        // TODO Auto-generated method stub
        return null;
    }

}
