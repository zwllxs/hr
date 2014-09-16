package com.lvmama.vst.back.biz.service.impl;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lvmama.vst.back.BusinessException;
import com.lvmama.vst.back.biz.dao.BizDestDao;
import com.lvmama.vst.back.biz.service.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {

	private static final Log LOG = LogFactory.getLog(CategoryServiceImpl.class);

	@Autowired
	BizDestDao bizDestDao;

	@Override
	public void findCategoryList(Map<String, Object> params) throws BusinessException {
		 System.out.println("bizDestDao: "+bizDestDao);
	}
	
	 
}