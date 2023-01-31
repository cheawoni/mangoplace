package com.mango.matzip.dto;

public class MainMatziplistDTO {
	String matzipList;
	String ment;
	String img;
	int restaurant_list_idx;
	
	public MainMatziplistDTO() { }
	public MainMatziplistDTO(String matziplist, String ment, String img, int restaurant_list_idx) {
		this.matzipList = matziplist;
		this.ment = ment;
		this.img = img;
		this.restaurant_list_idx = restaurant_list_idx;
	}

	public String getMatzipList() {
		return matzipList;
	}

	public void setMatzipList(String matzipList) {
		this.matzipList = matzipList;
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
	public int getRestaurant_list_idx() {
		return restaurant_list_idx;
	}
	public void setRestaurant_list_idx(int restaurant_list_idx) {
		this.restaurant_list_idx = restaurant_list_idx;
	}
	
}
