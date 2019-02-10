package com.malangstore.controller;

import com.malangstore.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;

@Controller
public class MemberController {

    private final Logger logger = LoggerFactory.getLogger(MemberController.class);

    @Autowired
    MemberService memberService;


	/**
	 *  초기 페이지로 이동
	 */
	@RequestMapping(value="/", method=RequestMethod.GET)
    public String index(Model model) {
        logger.info("request url : /");

        return "index";
    }


	/**
	 *  로그인 폼으로 이동
	 */
	@RequestMapping(value="/loginForm")
    public String loginForm(Model model) {
        logger.info("request url : /loginForm");

        return "loginForm";
    }


	/**
	 *  로그인
	 */
    @RequestMapping(value="/login", method=RequestMethod.POST)
    public ModelAndView login(@RequestParam HashMap<String, Object> map, HttpSession session) {
        logger.info("request url : /login");

        if(map.get("id") == "" || map.get("pw") == "") {
        	ModelAndView mav = new ModelAndView();
        	mav.addObject("msg", "아이디나 비밀번호를 입력해주세요.");
	        mav.setViewName("loginForm");
        	return mav;
        }

        return memberService.login(map, session);
    }


	/**
	 *  로그아웃
	 */
    @RequestMapping(value="/logout")
    public ModelAndView logout(HttpSession session) {
	    logger.info("request url : /logout");

	    ModelAndView mav = new ModelAndView();

	    Object loginState = session.getAttribute("loginId");

	    if(loginState != null) {
			session.removeAttribute("loginId");
			session.removeAttribute("authority");

			mav.addObject("msg", "로그아웃 되었습니다.");
			mav.setViewName("/loginForm");
		} else {
			mav.addObject("msg", "현재 로그인 상태가 아닙니다.");
			mav.setViewName("/");
		}

        return mav;
    }


	/**
	 *  회원가입 페이지로 이동
	 */
	@RequestMapping(value="/joinForm")
    public String joinForm() {
        logger.info("request url : /joinForm");

        return "joinForm";
    }


	/**
	 *  회원가입
	 */
	@RequestMapping(value="/join", method = RequestMethod.POST)
    public @ResponseBody HashMap<String, Integer> join(@RequestParam HashMap<String, Object> map) {
        logger.info("request url : /join");

        return memberService.join(map);
    }


	/**
	 *  ID 중복 검사
	 */
	@RequestMapping(value="/isDuplicate", method=RequestMethod.POST)
    public @ResponseBody HashMap<String, Object> isDuplicate(@RequestParam("id") String id) {
        logger.info("request url : /isDuplicate");

        return memberService.isDuplicate(id);
    }
}
