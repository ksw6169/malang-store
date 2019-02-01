package com.malangstore.beans;

public class Product {
    private int product_no;
    private String product_name;
    private int product_price;
    private int product_delivery;
    private int product_count;
    private String product_detail;
    private String product_reg_date;
    private int subcategory_no;

    public int getProduct_no() {
        return product_no;
    }

    public void setProduct_no(int product_no) {
        this.product_no = product_no;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public int getProduct_price() {
        return product_price;
    }

    public void setProduct_price(int product_price) {
        this.product_price = product_price;
    }

    public int getProduct_delivery() {
        return product_delivery;
    }

    public void setProduct_delivery(int product_delivery) {
        this.product_delivery = product_delivery;
    }

    public int getProduct_count() {
        return product_count;
    }

    public void setProduct_count(int product_count) {
        this.product_count = product_count;
    }

    public String getProduct_detail() {
        return product_detail;
    }

    public void setProduct_detail(String product_detail) {
        this.product_detail = product_detail;
    }

    public String getProduct_reg_date() {
        return product_reg_date;
    }

    public void setProduct_reg_date(String product_reg_date) {
        this.product_reg_date = product_reg_date;
    }

    public int getSubcategory_no() { return subcategory_no; }

    public void setSubcategory_no(int subcategory_no) { this.subcategory_no = subcategory_no; }
}
