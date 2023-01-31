package com.mango.matzip.dto;

public class MatzipDetailBottomDTO {
	int plate_id;
	String main_img;
	String name;
	double score;
	String area;
	String type;
	
	public MatzipDetailBottomDTO() { }
	public MatzipDetailBottomDTO(int plate_id, String main_img, String name, double score, String area, String type) {
		super();
		this.plate_id = plate_id;
		this.main_img = main_img;
		this.name = name;
		this.score = score;
		this.area = area;
		this.type = type;
	}
	public int getPlate_id() {
		return plate_id;
	}
	public void setPlate_id(int plate_id) {
		this.plate_id = plate_id;
	}
	public String getMain_img() {
		return main_img;
	}
	public void setMain_img(String main_img) {
		this.main_img = main_img;
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
	
	
}
