package com.mango.dto;

public class MangoPopularPlateRelatedContentListDto {
	private int rnum;
	private String type;
	private int idx;
	private String title;
	private String subtitle;
	private String image;
	private String updateDate;
	
	public MangoPopularPlateRelatedContentListDto(int rnum, String type, int idx, String title, String subtitle,
			String image, String updateDate) {
		this.rnum = rnum;
		this.type = type;
		this.idx = idx;
		this.title = title;
		this.subtitle = subtitle;
		this.image = image;
		this.updateDate = updateDate;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubtitle() {
		return subtitle;
	}

	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	
	
	
}
