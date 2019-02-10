package com.malangstore.daoimple;

import com.malangstore.beans.Member;
import com.malangstore.dao.MemberDao;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository("memberDao")
public class MemberDaoImple implements MemberDao {


    private final String NAMESPACE = MemberDao.class.getName();

    @Autowired
    SqlSessionTemplate sqlSession;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Override
    public HashMap<String, Object> login(HashMap<String, Object> map) {

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("member_id", map.get("id"));

	    Member member = sqlSession.selectOne(NAMESPACE+".login", paramMap);     // id에 해당하는 비밀번호, 권한 가져옴

	    boolean loginSuccess;
		String authority = null;

        if(member == null) {
			loginSuccess = false;
        } else {
			loginSuccess = passwordEncoder.matches(String.valueOf(map.get("pw")), member.getMember_pw());
			authority = member.getMember_authority();
        }

	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("loginSuccess", loginSuccess);
		resultMap.put("authority", authority);

		return resultMap;
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
