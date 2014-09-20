package com.zwl.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.zwl.core.service.ServiceImpl;
import com.zwlsoft.po.Country;
@Service
public class DestServiceImpl  extends ServiceImpl<Country> implements DestService {


	@Override
	public void findDestList(Map<String, Object> param) {
//		System.out.println("bizDestDao: "+bizDestDao);
	}
 
}
