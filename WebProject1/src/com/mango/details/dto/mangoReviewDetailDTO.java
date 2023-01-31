package com.mango.details.dto;

public class mangoReviewDetailDTO {
	
	private String name;
	private String area;
	private String memberName;
	private String memberImg;
	private int memberWriteCount;
	private int memberFollowCount;
	private int idx;
	private int id;
	private int memberNumber;
	private String[] img;
	private String coment;
	private String writeDate;
	private int tasty;
	
	public mangoReviewDetailDTO() {}
	public mangoReviewDetailDTO(String name, String area, String memberName, String memberImg, int memberWriteCount, int memberFollowCount, int idx, int id, int memberNumber, String[] img, String coment, String writeDate, int tasty) {
		this.name = name;
		this.area = area;
		this.memberName = memberName;
		this.memberImg = memberImg;
		this.memberWriteCount = memberWriteCount;
		this.memberFollowCount = memberFollowCount;
		this.idx = idx;
		this.id = id;
		this.memberNumber = memberNumber;
		this.img = img;
		this.coment = coment;
		this.writeDate = writeDate;
		this.tasty = tasty;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberImg() {
		return memberImg;
	}

	public void setMemberImg(String memberImg) {
		this.memberImg = memberImg;
	}

	public int getMemberWriteCount() {
		return memberWriteCount;
	}

	public void setMemberWriteCount(int memberWriteCount) {
		this.memberWriteCount = memberWriteCount;
	}

	public int getMemberFollowCount() {
		return memberFollowCount;
	}

	public void setMemberFollowCount(int memberFollowCount) {
		this.memberFollowCount = memberFollowCount;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getMemberNumber() {
		return memberNumber;
	}

	public void setMemberNumber(int memberNumber) {
		this.memberNumber = memberNumber;
	}

	public String[] getImg() {
		return img;
	}

	public void setImg(String[] img) {
		this.img = img;
	}

	public String getComent() {
		return coment;
	}

	public void setComent(String coment) {
		this.coment = coment;
	}

	public String getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}

	public int getTasty() {
		return tasty;
	}

	public void setTasty(int tasty) {
		this.tasty = tasty;
	}
	
}
