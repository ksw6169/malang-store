package com.malangstore.serviceimple;

import com.malangstore.beans.Orderlist;
import com.malangstore.beans.Product;
import com.malangstore.dao.OrderlistDao;
import com.malangstore.dao.ProductDao;
import com.malangstore.service.OrderlistService;
import com.malangstore.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service("orderlistService")
public class OrderlistServiceImple implements OrderlistService {

    @Autowired
    OrderlistDao orderlistDao;

    // Transactional 설정할 것
    @Override
    public HashMap<String, Integer> insertCart(HashMap<String, String> map) {

        Product product = orderlistDao.getProduct(Integer.valueOf(map.get("product_no")));

        HashMap<String, Integer> resultMap = new HashMap<String, Integer>();

        resultMap.put("success", orderlistDao.insertCart(product, String.valueOf(map.get("id"))));

        return resultMap;
    }

    @Override
    public HashMap<String, Object> cartList(HashMap<String, String> map) {

        HashMap<String, Object> resultMap = new HashMap<String, Object>();

        List<Orderlist> list = orderlistDao.cartList(map.get("id"));

        resultMap.put("list", list);

        return resultMap;
    }

    @Override
    public HashMap<String, Integer> deleteOrder(HashMap<String, Object> map) {

        HashMap<String, Integer> resultMap = new HashMap<String, Integer>();

        int success = orderlistDao.deleteOrder(Integer.valueOf(String.valueOf(map.get("orderlist_no"))));

        resultMap.put("success", success);

        return resultMap;
    }
}
