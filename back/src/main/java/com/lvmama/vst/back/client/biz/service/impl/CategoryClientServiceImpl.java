package com.lvmama.vst.back.client.biz.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.lvmama.vst.back.biz.service.CategoryService;
import com.lvmama.vst.back.client.biz.service.CategoryClientService;

@Component("categoryClientRemote")
public class CategoryClientServiceImpl implements CategoryClientService {
	@Autowired
	CategoryService categoryService;

	@Override
	public void findCategoryById(Long id) {
		System.out.println("categoryService: " + categoryService);

	}

}
