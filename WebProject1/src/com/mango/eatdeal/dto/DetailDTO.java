package com.mango.eatdeal.dto;

public class DetailDTO {
	private String name;
	private String area;
	private String menu;
	private String info;
	private String price;
	private String discount;
	private String discounted;
	private String rsInfo;
	private String menuInfo;
	private String menuImg;
	
	public DetailDTO() {};
	public DetailDTO(String name, String area, String menu, String info, String price, String discount,
			String discounted, String rsInfo, String menuInfo, String menuImg) {
		this.name = name;
		this.area = area;
		this.menu = menu;
		this.info = info;
		this.price = price;
		this.discount = discount;
		this.discounted = discounted;
		this.rsInfo = rsInfo;
		this.menuInfo = menuInfo;
		this.menuImg = menuImg;
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
	public String getMenu() {
		return menu;
	}
	public void setMenu(String menu) {
		this.menu = menu;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getDiscount() {
		return discount;
	}
	public void setDiscount(String discount) {
		this.discount = discount;
	}
	public String getDiscounted() {
		return discounted;
	}
	public void setDiscounted(String discounted) {
		this.discounted = discounted;
	}
	public String getRsInfo() {
		return rsInfo;
	}
	public void setRsInfo(String rsInfo) {
		this.rsInfo = rsInfo;
	}
	public String getMenuInfo() {
		return menuInfo;
	}
	public void setMenuInfo(String menuInfo) {
		this.menuInfo = menuInfo;
	}
	public String getMenuImg() {
		return menuImg;
	}
	public void setMenuImg(String menuImg) {
		this.menuImg = menuImg;
	}
	
	
	
	
}
