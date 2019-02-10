package com.malangstore.serviceimple;

import com.malangstore.beans.Member;
import com.malangstore.dao.MemberDao;
import com.malangstore.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;

@Service("memberService")
public class MemberServiceImple implements MemberService {

    private final Logger logger = LoggerFactory.getLogger(MemberServiceImple.class);

    @Autowired
    MemberDao memberDao;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Override
    public ModelAndView login(HashMap<String, Object> map, HttpSession session) {
	    HashMap<String, Object> result = memberDao.login(map);

	    ModelAndView mav = new ModelAndView();
	    String msg = "아이디와 비밀번호가 일치하지 않습니다.";

	    if((boolean)result.get("loginSuccess") == false) {
			mav.setViewName("loginForm");
	    } else {
		    msg = "로그인 성공";
		    session.setAttribute("loginId", map.get("id"));
		    session.setAttribute("authority", result.get("authority"));
		    mav.setViewName("redirect:/");
	    }

		mav.addObject("msg", msg);

        return mav;
    }

    @Override
    public HashMap<String, Integer> join(HashMap<String, Object> map) {
        Member member = new Member();

        member.setMember_id(String.valueOf(map.get("id")));
        member.setMember_pw(passwordEncoder.encode(String.valueOf(map.get("pw"))));
        member.setMember_name(String.valueOf(map.get("name")));
        member.setMember_email(String.valueOf(map.get("email")));

        HashMap<String, Integer> resultMap = new HashMap<String, Integer>();
        resultMap.put("success", memberDao.join(member));

        return resultMap;
    }

    @Override
    public HashMap<String, Object> isDuplicate(String id) {

        boolean isDuplicate = false;
        if(memberDao.isDuplicate(id) == 1) {
            isDuplicate = true;
        }

        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("isDuplicate", isDuplicate);

        return map;
    }
}
