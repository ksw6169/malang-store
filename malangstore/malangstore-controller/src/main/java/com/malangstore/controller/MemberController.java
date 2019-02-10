package com.malangstore.controller;

import com.malangstore.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;

@Controller
public class MemberController {

    private final Logger logger = LoggerFactory.getLogger(MemberController.class);

    @Autowired
    MemberService memberService;

    // 완
    @RequestMapping(value="/", method=RequestMethod.GET)
    public String index(Model model) {
        logger.info("request url : /");

        return "index";
    }

    // 완
    @RequestMapping(value="/loginForm")
    public String loginForm(Model model) {
        logger.info("request url : /loginForm");

        return "loginForm";
    }

    // 완
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

    // 완
    @RequestMapping(value="/logout")
    public ModelAndView logout(HttpSession session) {
        logger.info("request url : /logout");

        session.removeAttribute("loginId");
	    session.removeAttribute("authority");

        ModelAndView mav = new ModelAndView();
        mav.addObject("msg", "로그아웃 되었습니다.");
        mav.setViewName("/loginForm");

        return mav;
    }

    // 완
    @RequestMapping(value="/joinForm")
    public String joinForm(Model model) {
        logger.info("request url : /joinForm");

        return "joinForm";
    }

    // 완
    @RequestMapping(value="/join")
    public @ResponseBody HashMap<String, Integer> join(@RequestParam HashMap<String, Object> map) {
        logger.info("request url : /join");

        return memberService.join(map);
    }

    // 완
    @RequestMapping(value="/isDuplicate", method=RequestMethod.POST)
    public @ResponseBody HashMap<String, Object> isDuplicate(@RequestParam("id") String id) {
        logger.info("request url : /isDuplicate");

        return memberService.isDuplicate(id);
    }
}
