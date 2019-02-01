package com.malangstore.daoimple;

import com.malangstore.beans.Orderlist;
import com.malangstore.beans.Product;
import com.malangstore.dao.OrderlistDao;
import com.malangstore.dao.ProductDao;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("orderlistDao")
public class OrderlistDaoImple implements OrderlistDao {

    private final String NAMESPACE = OrderlistDao.class.getName();

    @Autowired
    SqlSessionTemplate sqlSession;

    @Override
    public Product getProduct(int product_no) {
        HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("product_no", product_no);

        return sqlSession.selectOne(NAMESPACE+".getProduct", paramMap);
    }

    @Override
    public int insertCart(Product product, String member_id) {
        HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("member_id", member_id);
        paramMap.put("product", product);

        return sqlSession.insert(NAMESPACE+".insertCart", paramMap);
    }

    @Override
    public List<Orderlist> cartList(String member_id) {
        HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("member_id", member_id);

        return sqlSession.selectList(NAMESPACE+".cartList", paramMap);
    }

    @Override
    public int deleteOrder(int orderlist_no) {
        HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("orderlist_no", orderlist_no);

        return sqlSession.delete(NAMESPACE+".deleteOrder", paramMap);
    }
}
