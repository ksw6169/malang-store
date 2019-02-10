package com.malangstore.controller;

import com.malangstore.beans.Orderlist;
import com.malangstore.service.OrderlistService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
public class OrderlistController {

    private final Logger logger = LoggerFactory.getLogger(OrderlistController.class);

    @Autowired
    OrderlistService orderlistService;


    @RequestMapping(value="/insertCart")
    public @ResponseBody HashMap<String, Object> insertCart(@RequestParam HashMap<String, String> map) {
        logger.info("request url : /insertCart");

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

	@RequestMapping(value="/order", method=RequestMethod.POST)
	public ModelAndView order(HttpServletRequest request) {
		logger.info("request url : /order");

		return orderlistService.order(request.getParameterValues("row-check"));
	}

	@RequestMapping(value="/moveOrder")
	public String moveOrder() {
		logger.info("request url : /moveOrder");

		return "order";
	}

	@RequestMapping(value="/getOrderlist", method=RequestMethod.GET)
	public @ResponseBody HashMap<String, Object> getOrderlist(@RequestParam HashMap<String, Object> map) {
		logger.info("request url : /getOrderlist");

		return orderlistService.getOrderlist(map);
	}

	@RequestMapping(value="/directOrder", method=RequestMethod.POST)
	public ModelAndView directOrder(HttpServletRequest request) {
		logger.info("request url : /directOrder");

		return orderlistService.directOrder(request.getParameterValues("row-check"));
	}

	@RequestMapping(value="/orderView", method=RequestMethod.GET)
	public @ResponseBody HashMap<String, Object> orderView(@RequestParam HashMap<String, Object> map) {
		logger.info("request url : /orderView");

		return orderlistService.orderView(map);
	}

	@RequestMapping(value="/moveOrderView", method=RequestMethod.GET)
	public String orderView() {
		logger.info("request url : /moveOrderView");

		return "orderView";
	}

	@RequestMapping(value="/orderCancel", method=RequestMethod.POST)
	public ModelAndView orderCancel(HttpServletRequest request) {
		logger.info("request url : /directOrder");

		List<Integer> orderlist = new ArrayList<Integer>();

		for(int i=0; i<request.getParameterValues("row-check").length; i++) {
			orderlist.add(Integer.valueOf(request.getParameterValues("row-check")[i]));
		}

		return orderlistService.orderCancel(orderlist);
	}
}
