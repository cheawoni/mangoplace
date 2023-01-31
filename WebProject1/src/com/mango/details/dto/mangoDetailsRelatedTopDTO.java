package com.mango.details.dto;

public class mangoDetailsRelatedTopDTO {
	private String title;
	private String ment;
	private String img;
	public mangoDetailsRelatedTopDTO(String title, String ment, String img) {
		this.title = title;
		this.ment = ment;
		this.img = img;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMent() {
		return ment;
	}
	public void setMent(String ment) {
		this.ment = ment;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	
}
