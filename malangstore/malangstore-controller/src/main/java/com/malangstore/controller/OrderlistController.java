package com.malangstore.controller;

import com.malangstore.service.OrderlistService;
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
public class OrderlistController {

    private final Logger logger = LoggerFactory.getLogger(OrderlistController.class);

    @Autowired
    OrderlistService orderlistService;



    @RequestMapping(value="/insertCart")
    public @ResponseBody HashMap<String, Integer> insertCart(@RequestParam HashMap<String, String> map) {
        logger.info("request url : /insertCart");

        logger.info("param id: "+map.get("id"));
        logger.info("param product_no: "+map.get("product_no"));

        return orderlistService.insertCart(map);
    }

    @RequestMapping(value="/cartView")
    public String cartView() {
        logger.info("request url : /cartView");

        return "cartView";
    }

    @RequestMapping(value="/cartList")
    public @ResponseBody HashMap<String, Object> cartList(@RequestParam HashMap<String, String> map) {
        logger.info("request url : /cartList");

        return orderlistService.cartList(map);
    }

    @RequestMapping(value="/deleteOrder")
    public @ResponseBody HashMap<String, Integer> deleteOrder(@RequestParam HashMap<String, Object> map) {
        logger.info("request url : /deleteOrder");

        return orderlistService.deleteOrder(map);
    }
}
