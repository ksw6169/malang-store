package com.malangstore.daoimple;

import com.malangstore.beans.Member;
import com.malangstore.dao.MemberDao;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import sun.security.util.Password;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("memberDao")
public class MemberDaoImple implements MemberDao {


    private final String NAMESPACE = MemberDao.class.getName();

    @Autowired
    SqlSessionTemplate sqlSession;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Override
    public boolean login(Member member) {

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("member", member);

        String member_pw = sqlSession.selectOne(NAMESPACE+".login", paramMap);

        if(member_pw == null) {
        	return false;
        }

        return passwordEncoder.matches(member.getMember_pw(), member_pw);
    }

    @Override
    public int join(Member member) {

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("member", member);
        int result = sqlSession.insert(NAMESPACE+".join", paramMap);

        return result;
    }

    @Override
    public int isDuplicate(String id) {
        Map<String, String> paramMap = new HashMap<String, String>();
        paramMap.put("member_id", id);

        return sqlSession.selectOne(NAMESPACE+".isDuplicate", paramMap);
    }
}
