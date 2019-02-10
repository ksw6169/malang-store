package com.malangstore.daoimple;

import com.malangstore.beans.Orderlist;
import com.malangstore.beans.Product;
import com.malangstore.dao.OrderlistDao;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

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
    public int insertCart(Product product, String member_id, int orderlist_count) {
    	HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("member_id", member_id);
        paramMap.put("product", product);
	    paramMap.put("orderlist_count", orderlist_count);

        return sqlSession.insert(NAMESPACE+".insertCart", paramMap);
    }

    @Override
    public List<Orderlist> cartList(String member_id) {
        HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("member_id", member_id);

        return sqlSession.selectList(NAMESPACE+".cartList", paramMap);
    }

	@Override
	public int getOrderlistNo(String member_id, int product_no) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("member_id", member_id);
		paramMap.put("product_no", product_no);

    	return sqlSession.selectOne(NAMESPACE+".getOrderlistNo", paramMap);
	}

	@Override
    public int deleteOrder(int orderlist_no) {
        HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("orderlist_no", orderlist_no);

        return sqlSession.delete(NAMESPACE+".deleteOrder", paramMap);
    }

	@Override
	public List<Orderlist> order(List<Integer> orderlist) {
    	HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("orderlist", orderlist);

		List<Orderlist> list = sqlSession.selectList(NAMESPACE+".order", paramMap);

    	return list;
	}

	@Override
	public Orderlist getOrderlist(int orderlistNo) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("orderlistNo", orderlistNo);

    	return sqlSession.selectOne(NAMESPACE+".getOrderlist", paramMap);
	}

	@Override
	public int directOrder(List<Integer> orderlist) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("orderlist", orderlist);

    	return sqlSession.update(NAMESPACE+".directOrder", paramMap);
	}

	@Override
	public List<Orderlist> orderView(String member_id) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("member_id", member_id);

    	return sqlSession.selectList(NAMESPACE+".orderView", paramMap);
	}

	@Override
	public int orderCancel(List<Integer> orderlist) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("orderlist", orderlist);

    	return sqlSession.delete(NAMESPACE+".orderCancel", paramMap);
	}
}
