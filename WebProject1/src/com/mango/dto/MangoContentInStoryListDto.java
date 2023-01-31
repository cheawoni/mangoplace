package com.mango.dto;

public class MangoContentInStoryListDto {
	private int plate_id;
	private String area;
	private String pure_plate_name;
	private String content_img1;
	private boolean wish;
	
	public MangoContentInStoryListDto(int plate_id, String area, String pure_plate_name, String content_img1,
			boolean wish) {
		this.plate_id = plate_id;
		this.area = area;
		this.pure_plate_name = pure_plate_name;
		this.content_img1 = content_img1;
		this.wish = wish;
	}

	public int getPlate_id() {
		return plate_id;
	}

	public void setPlate_id(int plate_id) {
		this.plate_id = plate_id;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getPure_plate_name() {
		return pure_plate_name;
	}

	public void setPure_plate_name(String pure_plate_name) {
		this.pure_plate_name = pure_plate_name;
	}

	public String getContent_img1() {
		return content_img1;
	}

	public void setContent_img1(String content_img1) {
		this.content_img1 = content_img1;
	}

	public boolean isWish() {
		return wish;
	}

	public void setWish(boolean wish) {
		this.wish = wish;
	}
	
	
}