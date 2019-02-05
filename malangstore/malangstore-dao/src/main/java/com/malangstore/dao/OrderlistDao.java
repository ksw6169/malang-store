package com.malangstore.dao;

import com.malangstore.beans.Orderlist;
import com.malangstore.beans.Product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface OrderlistDao {
    public Product getProduct(int product_no);
    public int insertCart(Product product, String member_id);
    public List<Orderlist> cartList(String member_id);
    public int deleteOrder(int orderlist_no);
    public List<Orderlist> order(List<Integer> orderlist);
	public int directOrder(List<Integer> orderlist);
	public List<Orderlist> orderView(String member_id);
	public int orderCancel(List<Integer> orderlist);
}
