package com.malangstore.beans;

public class Orderlist {
    private int orderlist_no;
    private String member_id;
    private int product_no;
    private String orderlist_check;
    private String orderlist_date;
    private int orderlist_count;

    public int getOrderlist_no() {
        return orderlist_no;
    }

    public void setOrderlist_no(int orderlist_no) {
        this.orderlist_no = orderlist_no;
    }

    public String getMember_id() {
        return member_id;
    }

    public void setMember_id(String member_id) {
        this.member_id = member_id;
    }

    public int getProduct_no() {
        return product_no;
    }

    public void setProduct_no(int product_no) {
        this.product_no = product_no;
    }

    public String getOrderlist_check() {
        return orderlist_check;
    }

    public void setOrderlist_check(String orderlist_check) {
        this.orderlist_check = orderlist_check;
    }

    public String getOrderlist_date() {
        return orderlist_date;
    }

    public void setOrderlist_date(String orderlist_date) {
        this.orderlist_date = orderlist_date;
    }

    public int getOrderlist_count() {
        return orderlist_count;
    }

    public void setOrderlist_count(int orderlist_count) {
        this.orderlist_count = orderlist_count;
    }
}
