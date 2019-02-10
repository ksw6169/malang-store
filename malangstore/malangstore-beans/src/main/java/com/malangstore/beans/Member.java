package com.malangstore.beans;

public class Member {
    private String member_id;
    private String member_pw;
    private String member_name;
    private String member_email;
    private String member_join_date;
    private String member_authority;

    public String getMember_id() { return member_id; }

    public void setMember_id(String member_id) {
        this.member_id = member_id;
    }

    public String getMember_pw() {
        return member_pw;
    }

    public void setMember_pw(String member_pw) {
        this.member_pw = member_pw;
    }

    public String getMember_name() {
        return member_name;
    }

    public void setMember_name(String member_name) {
        this.member_name = member_name;
    }

    public String getMember_email() {
        return member_email;
    }

    public void setMember_email(String member_email) {
        this.member_email = member_email;
    }

    public String getMember_join_date() {
        return member_join_date;
    }

    public void setMember_join_date(String member_join_date) {
        this.member_join_date = member_join_date;
    }

	public String getMember_authority() {
		return member_authority;
	}

	public void setMember_authority(String member_authority) {
		this.member_authority = member_authority;
	}
}
