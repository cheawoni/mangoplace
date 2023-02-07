package com.mango.details.dto;

public class mangoReviewInsertDTO {
	private int idx;
	private int id;
	private String email;
	private String img;
	private String review;
	private int tasty;
	public mangoReviewInsertDTO() { }
	public mangoReviewInsertDTO(int idx, int id, String email, String img, String review, int tasty) {
		this.idx = idx;
		this.id = id;
		this.email = email;
		this.img = img;
		this.review = review;
		this.tasty = tasty;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getReview() {
		return review;
	}
	public void setReview(String review) {
		this.review = review;
	}
	public int getTasty() {
		return tasty;
	}
	public void setTasty(int tasty) {
		this.tasty = tasty;
	}

	
}
