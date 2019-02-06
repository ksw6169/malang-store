package com.malangstore.daoimple;

import com.malangstore.beans.Category;
import com.malangstore.beans.Product;
import com.malangstore.beans.Subcategory;
import com.malangstore.dao.CategoryDao;
import com.malangstore.dao.ProductDao;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("categoryDao")
public class CategoryDaoImple implements CategoryDao {

    private final String NAMESPACE = CategoryDao.class.getName();

    @Autowired
    SqlSessionTemplate sqlSession;

	@Override
	public List<Subcategory> selectCategory(HashMap<String, Object> map) {
		HashMap<String, Integer> paramMap = new HashMap<String, Integer>();
		paramMap.put("category_no", Integer.valueOf(String.valueOf(map.get("category_no"))));

		return sqlSession.selectList(NAMESPACE+".selectCategory", paramMap);
	}
}
