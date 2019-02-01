package com.malangstore.serviceimple;

import com.malangstore.beans.Member;
import com.malangstore.dao.MemberDao;
import com.malangstore.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;

@Service("memberService")
public class MemberServiceImple implements MemberService {

    private final Logger logger = LoggerFactory.getLogger(MemberServiceImple.class);

    @Autowired
    MemberDao memberDao;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Override
    public ModelAndView login(HashMap<String, Object> map, HttpSession session) {
        Member member = new Member();
        member.setMember_id(String.valueOf(map.get("id")));
        member.setMember_pw(String.valueOf(map.get("pw")));


        ModelAndView mav = new ModelAndView();
        String msg = "아이디와 비밀번호가 일치하지 않습니다.";
        mav.setViewName("loginForm");
        if(memberDao.login(member)) {
            msg = "로그인 성공";
            session.setAttribute("loginId", member.getMember_id());
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
