package com.mango.matzip.dto;

public class MatzipDetailDTO {
	String main_img;
	int plate_id;
	String name;
	double score;
	String street_address;
	String recommended_review;
	String member_img;
	int member_number;
	String member_id;
	int restaurant_order;
	double latitude;
	double longitude;
	String area;
	String type;
	int review;
	int wish;
	
	public MatzipDetailDTO(String main_img, int plate_id, String name, double score, String street_address,	String recommended_review, 
			String member_img, int member_number, String member_id, int restaurant_order, double latitude, double longitude, String area, 
			String type, int review, int wish) {
		this.main_img = main_img;
		this.plate_id = plate_id;
		this.name = name;
		this.score = score;
		this.street_address = street_address;
		this.recommended_review = recommended_review;
		this.member_img = member_img;
		this.member_number = member_number;
		this.member_id = member_id;
		this.restaurant_order = restaurant_order;
		this.latitude = latitude;
		this.longitude = longitude;
		this.area = area;
		this.type = type;
		this.review = review;
		this.wish = wish;
	}

	public String getMain_img() {
		return main_img;
	}

	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}

	public int getPlate_id() {
		return plate_id;
	}

	public void setPlate_id(int plate_id) {
		this.plate_id = plate_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
	}

	public String getStreet_address() {
		return street_address;
	}

	public void setStreet_address(String street_address) {
		this.street_address = street_address;
	}

	public String getRecommended_review() {
		return recommended_review;
	}

	public void setRecommended_review(String recommended_review) {
		this.recommended_review = recommended_review;
	}

	public String getMember_img() {
		return member_img;
	}

	public void setMember_img(String member_img) {
		this.member_img = member_img;
	}

	public int getMember_number() {
		return member_number;
	}

	public void setMember_number(int member_number) {
		this.member_number = member_number;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public int getRestaurant_order() {
		return restaurant_order;
	}

	public void setRestaurant_order(int restaurant_order) {
		this.restaurant_order = restaurant_order;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getReview() {
		return review;
	}

	public void setReview(int review) {
		this.review = review;
	}

	public int getWish() {
		return wish;
	}

	public void setWish(int wish) {
		this.wish = wish;
	}
	
	
}
