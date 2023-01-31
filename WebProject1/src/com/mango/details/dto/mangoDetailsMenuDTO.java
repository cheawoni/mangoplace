package com.mango.details.dto;

public class mangoDetailsMenuDTO {
	private String menuImg;
	private String coment;
	private String updateDate2;
	
	public mangoDetailsMenuDTO() {}
	public mangoDetailsMenuDTO(String menuImg, String coment, String updateDate2) {
		this.menuImg = menuImg;
		this.coment = coment;
		this.updateDate2 = updateDate2;
	}
	public String getMenuImg() {
		return menuImg;
	}
	public void setMenuImg(String menuImg) {
		this.menuImg = menuImg;
	}
	public String getComent() {
		return coment;
	}
	public void setComent(String coment) {
		this.coment = coment;
	}
	public String getUpdateDate2() {
		return updateDate2;
	}
	public void setUpdateDate2(String updateDate2) {
		this.updateDate2 = updateDate2;
	}
}
