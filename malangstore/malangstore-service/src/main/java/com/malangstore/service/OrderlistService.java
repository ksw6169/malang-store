package com.malangstore.service;


import com.malangstore.beans.Orderlist;
import org.springframework.web.servlet.ModelAndView;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface OrderlistService {
    /*public HashMap<String, Object> productList(HashMap<String, Object> map);*/

    public HashMap<String, Integer> insertCart(HashMap<String, String> map);

    public HashMap<String, Object> cartList(HashMap<String, String> map);

    public HashMap<String, Integer> deleteOrder(HashMap<String, Object> map);

    public ModelAndView order(String[] rowCheck);

	public ModelAndView directOrder(String[] rowCheck);

	public HashMap<String, Object> orderView(HashMap<String, Object> map);

	public ModelAndView orderCancel(List<Integer> orderlist);
}
