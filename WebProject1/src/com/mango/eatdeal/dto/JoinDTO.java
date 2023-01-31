package com.mango.eatdeal.dto;

public class JoinDTO {
	private int bno;
	private String member_id;
	private String email;
	private String password;
	private String phone;
	
	public JoinDTO() {};
	public JoinDTO(int bno, String member_id, String email, String password, String phone) {

		this.bno = bno;
		this.member_id = member_id;
		this.email = email;
		this.password = password;
		this.phone = phone;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	

}
