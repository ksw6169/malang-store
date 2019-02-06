package com.malangstore.serviceimple;

import com.malangstore.beans.Category;
import com.malangstore.beans.Product;
import com.malangstore.beans.Subcategory;
import com.malangstore.dao.CategoryDao;
import com.malangstore.dao.ProductDao;
import com.malangstore.service.CategoryService;
import com.malangstore.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service("categoryService")
public class CategoryServiceImple implements CategoryService {

    @Autowired
    CategoryDao categoryDao;

	@Override
	public HashMap<String, Object> selectCategory(HashMap<String, Object> map) {

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Subcategory> list = categoryDao.selectCategory(map);
		resultMap.put("list", list);

		return resultMap;
	}
}
