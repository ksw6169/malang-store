package com.malangstore.dao;

import com.malangstore.beans.Member;

import java.util.HashMap;
import java.util.List;

public interface MemberDao {
    public boolean login(Member member);
    public int join(Member member);
    public int isDuplicate(String id);
}
