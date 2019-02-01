package com.malangstore.serviceimple;

import com.malangstore.beans.Product;
import com.malangstore.dao.ProductDao;
import com.malangstore.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;

@Service("productService")
public class ProductServiceImple implements ProductService {

    @Autowired
    ProductDao productDao;

    @Override
    public HashMap<String, Object> productList(HashMap<String, Object> map) {

        List<Product> list = productDao.productList(Integer.valueOf(String.valueOf(map.get("subcategory_no"))), Integer.valueOf(String.valueOf(map.get("page"))));
        int count = productDao.productListCount(Integer.valueOf(String.valueOf(map.get("subcategory_no"))));

        HashMap<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("productList", list);
        resultMap.put("productListCount", count);

        return resultMap;
    }
}
