package com.malangstore.controller;

import com.malangstore.service.CategoryService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;

@Controller
public class CategoryController {

	private final Logger logger = LoggerFactory.getLogger(CategoryController.class);

	@Autowired
	CategoryService categoryService;


	/**
	 *  서브 카테고리 가져오기
	 */
	@RequestMapping(value="/getSubCategories", method= RequestMethod.POST)
	public @ResponseBody
	HashMap<String, Object> getSubCategories(@RequestParam HashMap<String, Object> map) {
		logger.info("request url : /getSubCategories");

		return categoryService.getSubCategories(map);
	}

}
