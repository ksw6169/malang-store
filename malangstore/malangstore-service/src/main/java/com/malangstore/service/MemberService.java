package com.malangstore.service;


import com.malangstore.beans.Member;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Collection;
import java.util.HashMap;

public interface MemberService {
    public ModelAndView login(HashMap<String, Object> map, HttpSession session);

    public HashMap<String, Integer> join(HashMap<String, Object> map);

    public HashMap<String, Object> isDuplicate(String id);
}
