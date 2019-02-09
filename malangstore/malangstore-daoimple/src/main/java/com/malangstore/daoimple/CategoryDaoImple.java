package com.malangstore.daoimple;

import com.malangstore.beans.Subcategory;
import com.malangstore.dao.CategoryDao;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

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

	@Override
	public String getCategoryName(int subCategoryNo) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("subcategory_no", subCategoryNo);

		return sqlSession.selectOne(NAMESPACE+".getCategoryName", paramMap);
	}
}
