package com.malangstore.dao;

import com.malangstore.beans.Photo;
import com.malangstore.beans.Product;

import java.util.HashMap;
import java.util.List;

public interface ProductDao {
    public List<Product> productList(int subcategory_no, int page);

    public List<Photo> getPhoto(List<Product> productList);

    public List<Photo> getPhotoList(int product_no);

    public int productListCount(int subcategory_no);

    public int insertPhoto(int product_no, HashMap<String, Object> map, int imageLen);

    public HashMap<String, Object> newProduct(HashMap<String, Object> map, int imageLen);

    public Product productDetail(int product_no);
}
