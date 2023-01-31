package com.mango.matzip.dto;

public class MatzipListDTO {
	String restaurant_list;
	String ment;
	String main_img;
	int restaurant_list_idx;
	
	public MatzipListDTO() { }
	public MatzipListDTO(String restaurant_list, String ment, String main_img, int restaurant_list_idx) {
		this.restaurant_list = restaurant_list;
		this.ment = ment;
		this.main_img = main_img;
		this.restaurant_list_idx = restaurant_list_idx;
	}

	public String getRestaurant_list() {
		return restaurant_list;
	}

	public void setRestaurant_list(String restaurant_list) {
		this.restaurant_list = restaurant_list;
	}

	public String getMent() {
		return ment;
	}

	public void setMent(String ment) {
		this.ment = ment;
	}

	public String getMain_img() {
		return main_img;
	}

	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}
	
	public int getRestaurant_list_idx() {
		return restaurant_list_idx;
	}
	
	public void setRestaurant_list_idx(int restaurant_list_idx) {
		this.restaurant_list_idx = restaurant_list_idx;
	}
	
	
}
