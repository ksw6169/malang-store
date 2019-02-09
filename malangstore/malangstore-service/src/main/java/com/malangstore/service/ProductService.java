package com.malangstore.service;


import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

public interface ProductService {
    public HashMap<String, Object> productList(HashMap<String, Object> map);

    public HashMap<String, Object> newProduct(List<MultipartFile> images, HashMap<String, Object> map);

    public HashMap<String, Object> productDetail(HashMap<String, Object> map);
}
