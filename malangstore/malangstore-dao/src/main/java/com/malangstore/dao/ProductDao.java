package com.malangstore.dao;

import com.malangstore.beans.Category;
import com.malangstore.beans.Member;
import com.malangstore.beans.Product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface ProductDao {
    public List<Product> productList(int subcategory_no, int page);
    public int productListCount(int subcategory_no);

    // TODO: 2019-02-07
    public int insertPhoto(int product_no, HashMap<String, Object> map, int imageLen);

    public int registProduct(HashMap<String, Object> map, int imageLen);
}
