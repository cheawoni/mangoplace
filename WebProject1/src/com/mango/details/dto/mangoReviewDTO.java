package com.mango.details.dto;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.SQLException;

public class mangoReviewDTO {
	private String memberImg;
	private String name;
	private int writeCount;
	private int followCount;
	private int holic;
	private Date writedate;
	private String coment;
	private String img;
	private String[] imgNum;
	private int tasty;
	private int id;
	private int idx ;
	private int member;
	
	public mangoReviewDTO() {}

	public mangoReviewDTO(String memberImg, String name, int writeCount, int followCount, int holic, Date writedate,
			String coment, String img, String[] imgNum, int tasty, int id, int idx, int member) {
		this.memberImg = memberImg;
		this.name = name;
		this.writeCount = writeCount;
		this.followCount = followCount;
		this.holic = holic;
		this.writedate = writedate;
		this.coment = coment;
		this.img = img;
		this.imgNum = imgNum;
		this.tasty = tasty;
		this.id = id;
		this.idx = idx;
		this.member = member;
	}

	public String getMemberImg() {
		return memberImg;
	}

	public void setMemberImg(String memberImg) {
		this.memberImg = memberImg;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getWriteCount() {
		return writeCount;
	}

	public void setWriteCount(int writeCount) {
		this.writeCount = writeCount;
	}

	public int getFollowCount() {
		return followCount;
	}

	public void setFollowCount(int followCount) {
		this.followCount = followCount;
	}

	public int getHolic() {
		return holic;
	}

	public void setHolic(int holic) {
		this.holic = holic;
	}

	public Date getWritedate() {
		return writedate;
	}

	public void setWritedate(Date writedate) {
		this.writedate = writedate;
	}

	public String getComent() {
		return coment;
	}

	public void setComent(String coment) {
		this.coment = coment;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String[] getImgNum() {
		return imgNum;
	}

	public void setImg_Num(String[] imgNum) {
		this.imgNum = imgNum;
	}

	public int getTasty() {
		return tasty;
	}

	public void setTasty(int tasty) {
		this.tasty = tasty;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}

	
}
