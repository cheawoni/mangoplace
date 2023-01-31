package com.mango.dto;

public class MangoPopularPlateDto {
	private int plateId;
	private String mainImg;
	private String name;
	private String branch;	// 지점
	private String score;	// 평점
	private String area;	// 강남역
	private String type;	// 탕/찌게/전골
	private int hitcount;	// 조회수
	private int review;		// 리뷰수
	
	public MangoPopularPlateDto(int plateId, String mainImg, String name, String branch, String score, String area,
			String type, int hitcount, int review) {
		this.plateId = plateId;
		this.mainImg = mainImg;
		this.name = name;
		this.branch = branch;
		this.score = score;
		this.area = area;
		this.type = type;
		this.hitcount = hitcount;
		this.review = review;
	}

	public int getPlateId() {
		return plateId;
	}

	public void setPlateId(int plateId) {
		this.plateId = plateId;
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

	public String getBranch() {
		return branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}

	public String getScore() {
		return score;
	}

	public void setScore(String score) {
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

	public int getHitcount() {
		return hitcount;
	}

	public void setHitcount(int hitcount) {
		this.hitcount = hitcount;
	}

	public int getReview() {
		return review;
	}

	public void setReview(int review) {
		this.review = review;
	}
	
	
}
