package com.mango.details.dto;

public class mangoDetailsNearDTO {
	private int id;
	private String mainImg;
	private String name;
	private double score;
	private String type;
	private String area;
	private String price;
	private double dist;
	public mangoDetailsNearDTO() {}
	public mangoDetailsNearDTO(int id, String mainImg, String name, double score, String type, String area,
			String price, double dist) {
		this.id = id;
		this.mainImg = mainImg;
		this.name = name;
		this.score = score;
		this.type = type;
		this.area = area;
		this.price = price;
		this.dist = dist;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getMainImg() {
		return mainImg;
	}
	public void setMainImg(String mainImg) {
		this.mainImg = mainImg;
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public double getDist() {
		return dist;
	}
	public void setDist(double dist) {
		this.dist = dist;
	}
}
