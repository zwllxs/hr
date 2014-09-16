package com.lvmama.vst.back.biz.service;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lvmama.vst.back.biz.dao.BizDestDao;
@Service
public class DestServiceImpl implements DestService {

	private static final Log LOG = LogFactory.getLog(DestServiceImpl.class);

	@Autowired
	private BizDestDao bizDestDao;

	@Override
	public void findDestList(Map<String, Object> param) {
		System.out.println("bizDestDao: "+bizDestDao);
	}
 
}
