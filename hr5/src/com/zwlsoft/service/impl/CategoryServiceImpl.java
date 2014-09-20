package com.zwlsoft.service.impl;

import java.util.Map;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwlsoft.action.BusinessException;
import com.zwlsoft.service.CategoryService;
import com.zwlsoft.service.dao.RoleDao;

@Service
public class CategoryServiceImpl implements CategoryService {

	private static final Log LOG = LogFactory.getLog(CategoryServiceImpl.class);

	@Autowired
	RoleDao bizDestDao;

	@Override
	public void findCategoryList(Map<String, Object> params) throws BusinessException {
		 System.out.println("bizDestDao: "+bizDestDao);
	}
	
	 
}