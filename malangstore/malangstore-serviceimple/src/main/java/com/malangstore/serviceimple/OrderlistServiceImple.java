package com.malangstore.serviceimple;

import com.malangstore.beans.Orderlist;
import com.malangstore.beans.Product;
import com.malangstore.dao.OrderlistDao;
import com.malangstore.service.OrderlistService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service("orderlistService")
public class OrderlistServiceImple implements OrderlistService {

    @Autowired
    OrderlistDao orderlistDao;


	/**
	 *  장바구니 담기
	 */
	@Override
    public HashMap<String, Object> insertCart(HashMap<String, String> map) {

        Product product = orderlistDao.getProduct(Integer.valueOf(map.get("product_no")));

        String id = String.valueOf(map.get("id"));
        int orderlistCount = Integer.valueOf(String.valueOf(map.get("orderlist_count")));

        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("success", orderlistDao.insertCart(product, id, orderlistCount));
		resultMap.put("orderlistNo", orderlistDao.getOrderlistNo(String.valueOf(map.get("id")), Integer.valueOf(map.get("product_no"))));

        return resultMap;
    }


	/**
	 *  장바구니 내역 가져오기
	 */
	@Override
    public HashMap<String, Object> cartList(HashMap<String, String> map) {

        List<Orderlist> list = orderlistDao.cartList(map.get("id"));

        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("list", list);

        return resultMap;
    }


	/**
	 *  주문 내역 삭제(1개)
	 */
	@Override
    public HashMap<String, Integer> deleteOrder(HashMap<String, Object> map) {

        int success = orderlistDao.deleteOrder(Integer.valueOf(String.valueOf(map.get("orderlist_no"))));

	    HashMap<String, Integer> resultMap = new HashMap<String, Integer>();
        resultMap.put("success", success);

        return resultMap;
    }


	/**
	 *  주문하기(cartView.jsp)
	 */
	@Override
	public ModelAndView order(String[] rowCheck) {

    	List<Integer> list = new ArrayList<Integer>();

    	for(int i=0; i<rowCheck.length; i++) {
			list.add(Integer.valueOf(rowCheck[i]));
	    }

    	List<Orderlist> orderlist = orderlistDao.order(list);

		ModelAndView mav = new ModelAndView();
		mav.addObject("orderlist", orderlist);
		mav.setViewName("order");

		return mav;
	}


	/**
	 *  주문할 내역 가져오기(order.jsp)
	 */
	@Override
	public HashMap<String, Object> getOrderlist(HashMap<String, Object> map) {

		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		int orderlistNo = Integer.valueOf(String.valueOf(map.get("orderlist_no")));

		Orderlist orderlist = orderlistDao.getOrderlist(orderlistNo);
		resultMap.put("orderlist", orderlist);

    	return resultMap;
	}


	/**
	 *  주문하기
	 */
	@Override
	public ModelAndView directOrder(String[] rowCheck) {

		List<Integer> list = new ArrayList<Integer>();

		for(int i=0; i<rowCheck.length; i++) {
			list.add(Integer.valueOf(rowCheck[i]));
		}

		ModelAndView mav = new ModelAndView();

		String msg = "상품 주문에 실패했습니다.";
		mav.setViewName("redirect:/");
		if(orderlistDao.directOrder(list) != 0) {
			msg = "주문이 완료되었습니다.";
			mav.setViewName("orderView");
		}

		mav.addObject("msg", msg);

    	return mav;
	}


	/**
	 *  주문 조회
	 */
	@Override
	public HashMap<String, Object> orderView(HashMap<String, Object> map) {

		List<Orderlist> orderlist = orderlistDao.orderView(String.valueOf(map.get("id")));

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("orderlist", orderlist);

    	return resultMap;
	}


	/**
	 *  주문 취소
	 */
	@Override
	public ModelAndView orderCancel(List<Integer> orderlist) {

    	ModelAndView mav = new ModelAndView();

    	String msg = "주문 취소에 실패했습니다.";
		if(orderlistDao.orderCancel(orderlist) != 0) {
			msg = "주문 취소가 완료되었습니다.";
		}
		mav.setViewName("orderView");
		mav.addObject("msg", msg);

    	return mav;
	}
}
