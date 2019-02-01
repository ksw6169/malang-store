package com.malangstore.service;


import java.util.HashMap;

public interface OrderlistService {
    /*public HashMap<String, Object> productList(HashMap<String, Object> map);*/

    public HashMap<String, Integer> insertCart(HashMap<String, String> map);

    public HashMap<String, Object> cartList(HashMap<String, String> map);

    public HashMap<String, Integer> deleteOrder(HashMap<String, Object> map);
}
