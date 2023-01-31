package com.mango.eatdeal.dto;

public class Eat_deal_mainDTO {
	private String name;
	private String area;
	private String menu;
	private String info;
	private String price;
	private String discount;
	private String discounted;
	private String main_theme;
	private int neww;
	private int dealIdx;
	
	public Eat_deal_mainDTO() {}
	public Eat_deal_mainDTO(String name, String area, String menu, String info, String price, String discount,
			String discounted, String main_theme, int neww, int dealIdx) {

		this.name = name;
		this.area = area;
		this.menu = menu;
		this.info = info;
		this.price = price;
		this.discount = discount;
		this.discounted = discounted;
		this.main_theme = main_theme;
		this.neww = neww;
		this.dealIdx = dealIdx;
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
	public String getMain_theme() {
		return main_theme;
	}
	public void setMain_theme(String main_theme) {
		this.main_theme = main_theme;
	}
	public int getNeww() {
		return neww;
	}
	public void setNeww(int neww) {
		this.neww = neww;
	}
	public int getDealIdx() {
		return dealIdx;
	}
	public void setDealIdx(int dealIdx) {
		this.dealIdx = dealIdx;
	}
	

}
