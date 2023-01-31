package com.mango.dto;

//select story_title, story_subtitle, main_img from story_main where story_id=15;
public class MangoStoryListMonthlyDto {
	private String storyTitle;
	private String storySubtitle;
	private String mainImg;
	
	public MangoStoryListMonthlyDto(String storyTitle, String storySubtitle, String mainImg) {
		this.storyTitle = storyTitle;
		this.storySubtitle = storySubtitle;
		this.mainImg = mainImg;
	}

	public String getStoryTitle() {
		return storyTitle;
	}

	public void setStoryTitle(String storyTitle) {
		this.storyTitle = storyTitle;
	}

	public String getStorySubtitle() {
		return storySubtitle;
	}

	public void setStorySubtitle(String storySubtitle) {
		this.storySubtitle = storySubtitle;
	}

	public String getMainImg() {
		return mainImg;
	}

	public void setMainImg(String mainImg) {
		this.mainImg = mainImg;
	}
	
}
