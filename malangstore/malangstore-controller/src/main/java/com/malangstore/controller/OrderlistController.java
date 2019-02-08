package com.malangstore.controller;

import com.malangstore.beans.Orderlist;
import com.malangstore.service.OrderlistService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import sun.misc.Request;

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
    public @ResponseBody HashMap<String, Integer> insertCart(@RequestParam HashMap<String, String> map) {
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

		List<Integer> orderlist = new ArrayList<Integer>();

		for(int i=0; i<request.getParameterValues("rowCheck").length; i++) {
			orderlist.add(Integer.valueOf(request.getParameterValues("rowCheck")[i]));
		}

		List<Orderlist> list = orderlistService.order(orderlist);

		ModelAndView mav = new ModelAndView();
		mav.addObject("id", request.getParameter("id"));
		mav.addObject("orderlist", list);
		mav.setViewName("order");

		return mav;
	}


	@RequestMapping(value="/directOrder", method=RequestMethod.POST)
	public ModelAndView directOrder(HttpServletRequest request) {
		logger.info("request url : /directOrder");

		List<Integer> orderlist = new ArrayList<Integer>();

		for(int i=0; i<request.getParameterValues("rowCheck").length; i++) {
			orderlist.add(Integer.valueOf(request.getParameterValues("rowCheck")[i]));
		}

		ModelAndView mav = new ModelAndView();

		String msg = "상품 주문에 실패했습니다.";
		mav.setViewName("redirect:/");
		if(orderlistService.directOrder(orderlist) != 0) {
			msg = "주문이 완료되었습니다.";
			mav.setViewName("orderView");
		}

		mav.addObject("msg", msg);

		return mav;
	}

	@RequestMapping(value="/orderView", method=RequestMethod.GET)
	public @ResponseBody HashMap<String, Object> orderView(@RequestParam HashMap<String, Object> map) {
		logger.info("request url : /orderView");

		return orderlistService.orderView(map);
	}

	@RequestMapping(value="/moveOrderView", method=RequestMethod.GET)
	public String moveOrderView() {
		logger.info("request url : /moveOrderView");

		return "orderView";
	}

	@RequestMapping(value="/orderCancel", method=RequestMethod.POST)
	public ModelAndView orderCancel(HttpServletRequest request) {
		logger.info("request url : /directOrder");

		List<Integer> orderlist = new ArrayList<Integer>();

		for(int i=0; i<request.getParameterValues("rowCheck").length; i++) {
			orderlist.add(Integer.valueOf(request.getParameterValues("rowCheck")[i]));
		}

		return orderlistService.orderCancel(orderlist);
	}
}
