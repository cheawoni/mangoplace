package com.mango.matzip.dto;

public class MainMangostoryDTO {
	String story_title;
	int member_number;
	String story_subtitle;
	String main_img;
	String member_img;
	String member_id;
	int story_id;
	
	public MainMangostoryDTO() { }
	public MainMangostoryDTO(String story_title, int member_number, String story_subtitle, String main_img,
			String member_img, String member_id, int story_id) {
		this.story_title = story_title;
		this.member_number = member_number;
		this.story_subtitle = story_subtitle;
		this.main_img = main_img;
		this.member_img = member_img;
		this.member_id = member_id;
		this.story_id = story_id;
	}

	public String getStory_title() {
		return story_title;
	}

	public void setStory_title(String story_title) {
		this.story_title = story_title;
	}

	public int getMember_number() {
		return member_number;
	}

	public void setMember_number(int member_number) {
		this.member_number = member_number;
	}

	public String getStory_subtitle() {
		return story_subtitle;
	}

	public void setStory_subtitle(String story_subtitle) {
		this.story_subtitle = story_subtitle;
	}

	public String getMain_img() {
		return main_img;
	}

	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}

	public String getMember_img() {
		return member_img;
	}

	public void setMember_img(String member_img) {
		this.member_img = member_img;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public int getStory_id() {
		return story_id;
	}
	public void setStory_id(int story_id) {
		this.story_id = story_id;
	}
	
	
}
