package com.mango.details.dto;

public class mangoDetailsRelatedStoryDTO {
	private String name;
	private String title;
	private String subTitle;
	private String img;
	public mangoDetailsRelatedStoryDTO() {}
	public mangoDetailsRelatedStoryDTO(String name, String title, String subTitle, String img) {
		this.name = name;
		this.title = title;
		this.subTitle = subTitle;
		this.img = img;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSubTitle() {
		return subTitle;
	}
	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
}
