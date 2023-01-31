package com.mango.details.dto;

public class MenuDTO {
	private String menuName;
	private String menuPrice;
	public MenuDTO(String menuName, String menuPrice) {
		this.menuName = menuName;
		this.menuPrice = menuPrice;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getMenuPrice() {
		return menuPrice;
	}
	public void setMenuPrice(String menuPrice) {
		this.menuPrice = menuPrice;
	}
}
