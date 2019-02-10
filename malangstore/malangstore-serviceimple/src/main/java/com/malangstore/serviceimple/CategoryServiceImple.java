package com.malangstore.serviceimple;

import com.malangstore.beans.Subcategory;
import com.malangstore.dao.CategoryDao;
import com.malangstore.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service("categoryService")
public class CategoryServiceImple implements CategoryService {

    @Autowired
    CategoryDao categoryDao;


	/**
	 *  서브 카테고리 가져오기
	 */
	@Override
	public HashMap<String, Object> getSubCategories(HashMap<String, Object> map) {

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Subcategory> list = categoryDao.getSubCategories(map);
		resultMap.put("list", list);

		return resultMap;
	}
}
