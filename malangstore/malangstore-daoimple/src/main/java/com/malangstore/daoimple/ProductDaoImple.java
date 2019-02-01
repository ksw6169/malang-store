package com.malangstore.daoimple;

import com.malangstore.beans.Member;
import com.malangstore.beans.Product;
import com.malangstore.dao.MemberDao;
import com.malangstore.dao.ProductDao;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("productDao")
public class ProductDaoImple implements ProductDao {

    private final String NAMESPACE = ProductDao.class.getName();

    @Autowired
    SqlSessionTemplate sqlSession;

    @Override
    public List<Product> productList(int subcategory_no, int page) {
        Map<String, Integer> paramMap = new HashMap<String, Integer>();
        paramMap.put("subcategory_no", subcategory_no);
        paramMap.put("page", page);

        return sqlSession.selectList(NAMESPACE+".productList", paramMap);
    }

    @Override
    public int productListCount(int subcategory_no) {
        Map<String, Integer> paramMap = new HashMap<String, Integer>();
        paramMap.put("subcategory_no", subcategory_no);

        return sqlSession.selectOne(NAMESPACE+".productListCount", paramMap);
    }
}
