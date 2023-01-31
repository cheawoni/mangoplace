package com.mango.details.dto;

public class mangoDetailsRelatedDTO {
	private String r_list;
	private int r_idx;
	private String img;
	private int id;
	private String name;
	private double score;
	private String area;
	private String type;
	public mangoDetailsRelatedDTO() {}
	public mangoDetailsRelatedDTO(String r_list, int r_idx, String img, int id, String name, double score,
			String area, String type) {
		this.r_list = r_list;
		this.r_idx = r_idx;
		this.img = img;
		this.id = id;
		this.name = name;
		this.score = score;
		this.area = area;
		this.type = type;
	}
	public String getR_list() {
		return r_list;
	}
	public void setR_list(String r_list) {
		this.r_list = r_list;
	}
	public int getR_idx() {
		return r_idx;
	}
	public void setR_idx(int r_idx) {
		this.r_idx = r_idx;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
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
