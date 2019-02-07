package com.malangstore.dao;

import com.malangstore.beans.Category;
import com.malangstore.beans.Member;
import com.malangstore.beans.Photo;
import com.malangstore.beans.Product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface ProductDao {
    public HashMap<String, Object> productList(int subcategory_no, int page);

    public Photo getPhoto(int product_no);

    public int productListCount(int subcategory_no);

    public int insertPhoto(int product_no, HashMap<String, Object> map, int imageLen);

    public int registProduct(HashMap<String, Object> map, int imageLen);
}
