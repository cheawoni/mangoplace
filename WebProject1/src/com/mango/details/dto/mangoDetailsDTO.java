package com.mango.details.dto;

import java.sql.Date;

public class mangoDetailsDTO {
	private int id;
	private String name;
	private String main_img;
	private String branch;
	private double score;
	private int hitcount;
	private String hitcount2;
	private int review;
	private String review2;
	private int wish;
	private String wish2;
	private String area;
	private String stAddress;
	private String jibunAddress;
	private String phoneNum;
	private String type;
	private String price;
	private String parking;
	private String businessHour;
	private String breakTime;
	private String lastOrder;
	private String dayOff;
	private String webpage;
	private String menu;
	private String update_date;
	private double latitude;
	private double longitude;
	private String hashtag;
	private String[] hashtagArr;

	
	public mangoDetailsDTO() {}
	public mangoDetailsDTO(int id, String name, String main_img, String branch, double score, int hitcount,
			String hitcount2, int review, String review2, int wish, String wish2, String area, String stAddress,
			String jibunAddress, String phoneNum, String type, String price, String parking, String businessHour,
			String breakTime, String lastOrder, String dayOff, String webpage, String menu, String update_date,
			double latitude, double longitude, String hashtag, String[] hashtagArr) {
		this.id = id;
		this.name = name;
		this.main_img = main_img;
		this.branch = branch;
		this.score = score;
		this.hitcount = hitcount;
		this.hitcount2 = hitcount2;
		this.review = review;
		this.review2 = review2;
		this.wish = wish;
		this.wish2 = wish2;
		this.area = area;
		this.stAddress = stAddress;
		this.jibunAddress = jibunAddress;
		this.phoneNum = phoneNum;
		this.type = type;
		this.price = price;
		this.parking = parking;
		this.businessHour = businessHour;
		this.breakTime = breakTime;
		this.lastOrder = lastOrder;
		this.dayOff = dayOff;
		this.webpage = webpage;
		this.menu = menu;
		this.update_date = update_date;
		this.latitude = latitude;
		this.longitude = longitude;
		this.hashtag = hashtag;
		this.hashtagArr = hashtagArr;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMain_img() {
		return main_img;
	}
	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public int getHitcount() {
		return hitcount;
	}
	public void setHitcount(int hitcount) {
		this.hitcount = hitcount;
	}
	public String getHitcount2() {
		return hitcount2;
	}
	public void setHitcount2(String hitcount2) {
		this.hitcount2 = hitcount2;
	}
	public int getReview() {
		return review;
	}
	public void setReview(int review) {
		this.review = review;
	}
	public String getReview2() {
		return review2;
	}
	public void setReview2(String review2) {
		this.review2 = review2;
	}
	public int getWish() {
		return wish;
	}
	public void setWish(int wish) {
		this.wish = wish;
	}
	public String getWish2() {
		return wish2;
	}
	public void setWish2(String wish2) {
		this.wish2 = wish2;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getStAddress() {
		return stAddress;
	}
	public void setStAddress(String stAddress) {
		this.stAddress = stAddress;
	}
	public String getJibunAddress() {
		return jibunAddress;
	}
	public void setJibunAddress(String jibunAddress) {
		this.jibunAddress = jibunAddress;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getParking() {
		return parking;
	}
	public void setParking(String parking) {
		this.parking = parking;
	}
	public String getBusinessHour() {
		return businessHour;
	}
	public void setBusinessHour(String businessHour) {
		this.businessHour = businessHour;
	}
	public String getBreakTime() {
		return breakTime;
	}
	public void setBreakTime(String breakTime) {
		this.breakTime = breakTime;
	}
	public String getLastOrder() {
		return lastOrder;
	}
	public void setLastOrder(String lastOrder) {
		this.lastOrder = lastOrder;
	}
	public String getDayOff() {
		return dayOff;
	}
	public void setDayOff(String dayOff) {
		this.dayOff = dayOff;
	}
	public String getWebpage() {
		return webpage;
	}
	public void setWebpage(String webpage) {
		this.webpage = webpage;
	}
	public String getMenu() {
		return menu;
	}
	public void setMenu(String menu) {
		this.menu = menu;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
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
	public String getHashtag() {
		return hashtag;
	}
	public void setHashtag(String hashtag) {
		this.hashtag = hashtag;
	}
	public String[] getHashtagArr() {
		return hashtagArr;
	}
	public void setHashtagArr(String[] hashtagArr) {
		this.hashtagArr = hashtagArr;
	}
		
}
