package com.malangstore.controller;

import com.malangstore.service.ProductService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;

@Controller
public class ProductController {

    private final Logger logger = LoggerFactory.getLogger(ProductController.class);

    @Autowired
    ProductService productService;

    @RequestMapping(value="/categories")
    public String categories() {
        logger.info("request url: /categories");

        return "categories";
    }

    @RequestMapping(value="/productList")
    public @ResponseBody HashMap<String, Object> productList(@RequestParam HashMap<String, Object> map) {
        logger.info("request url: /productList");

        return productService.productList(map);
    }
}
