package com.malangstore.dao;

import com.malangstore.beans.Member;

import java.util.HashMap;
import java.util.List;

public interface MemberDao {
    public HashMap<String, Object> login(HashMap<String, Object> map);
    public int join(Member member);
    public int isDuplicate(String id);
}
