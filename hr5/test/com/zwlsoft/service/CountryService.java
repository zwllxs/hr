package com.zwlsoft.service;

import java.util.List;

import com.zwlsoft.po.Country;
import com.zwlsoft.service.dao4.IBaseGenericDAO;

public interface CountryService extends IBaseGenericDAO<Country>
{
    public List<Country> getAll();
}
