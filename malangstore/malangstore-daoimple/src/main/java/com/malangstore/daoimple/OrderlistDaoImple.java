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


	/**
	 *  상품 가져오기
	 */
    @Override
    public Product getProduct(int product_no) {

        HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("product_no", product_no);

        return sqlSession.selectOne(NAMESPACE+".getProduct", paramMap);
    }


	/**
	 *  장바구니 담기
	 */
	@Override
    public int insertCart(Product product, String member_id, int orderlist_count) {

    	HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("member_id", member_id);
        paramMap.put("product", product);
	    paramMap.put("orderlist_count", orderlist_count);

        return sqlSession.insert(NAMESPACE+".insertCart", paramMap);
    }


	/**
	 *  장바구니 내역 가져오기
	 */
	@Override
    public List<Orderlist> cartList(String member_id) {

        HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("member_id", member_id);

        return sqlSession.selectList(NAMESPACE+".cartList", paramMap);
    }


	/**
	 *  주문 번호 가져오기
	 */
	@Override
	public int getOrderlistNo(String member_id, int product_no) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("member_id", member_id);
		paramMap.put("product_no", product_no);

    	return sqlSession.selectOne(NAMESPACE+".getOrderlistNo", paramMap);
	}


	/**
	 *  주문 내역 삭제(1개)
	 */
	@Override
    public int deleteOrder(int orderlist_no) {

        HashMap<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("orderlist_no", orderlist_no);

        return sqlSession.delete(NAMESPACE+".deleteOrder", paramMap);
    }


	/**
	 *  주문하기(cartView.jsp)
	 */
	@Override
	public List<Orderlist> order(List<Integer> orderlist) {

    	HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("orderlist", orderlist);

		List<Orderlist> list = sqlSession.selectList(NAMESPACE+".order", paramMap);

    	return list;
	}


	/**
	 *  주문할 내역 가져오기(order.jsp)
	 */
	@Override
	public Orderlist getOrderlist(int orderlistNo) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("orderlistNo", orderlistNo);

    	return sqlSession.selectOne(NAMESPACE+".getOrderlist", paramMap);
	}


	/**
	 *  주문하기
	 */
	@Override
	public int directOrder(List<Integer> orderlist) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("orderlist", orderlist);

    	return sqlSession.update(NAMESPACE+".directOrder", paramMap);
	}


	/**
	 *  주문 조회
	 */
	@Override
	public List<Orderlist> orderView(String member_id) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("member_id", member_id);

    	return sqlSession.selectList(NAMESPACE+".orderView", paramMap);
	}


	/**
	 *  주문 취소
	 */
	@Override
	public int orderCancel(List<Integer> orderlist) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("orderlist", orderlist);

    	return sqlSession.delete(NAMESPACE+".orderCancel", paramMap);
	}
}
