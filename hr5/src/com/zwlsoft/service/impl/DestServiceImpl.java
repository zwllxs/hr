package com.zwlsoft.service.impl;

import java.util.Map;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zwlsoft.service.DestService;
import com.zwlsoft.service.dao.RoleDao;
@Service
public class DestServiceImpl implements DestService {

	private static final Log LOG = LogFactory.getLog(DestServiceImpl.class);

	@Autowired
	private RoleDao bizDestDao;

	@Override
	public void findDestList(Map<String, Object> param) {
		System.out.println("bizDestDao: "+bizDestDao);
	}
 
}
