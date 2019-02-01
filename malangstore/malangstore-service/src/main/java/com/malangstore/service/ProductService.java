package com.malangstore.service;


import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;

public interface ProductService {
    public HashMap<String, Object> productList(HashMap<String, Object> map);
}
