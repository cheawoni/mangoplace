package com.mango.dto;

public class MangoContentViewMoreListDto {
	private int rnum;	// 최신순 1~6개의 스토리
	private int story_id;	// 스토리 아이디값
	private String story_title;	// 스토리 제목
	private String main_img;	// 스토리 메인이미지
	
	public MangoContentViewMoreListDto(int rnum, int story_id, String story_title, String main_img) {
		this.rnum = rnum;
		this.story_id = story_id;
		this.story_title = story_title;
		this.main_img = main_img;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public int getStory_id() {
		return story_id;
	}

	public void setStory_id(int story_id) {
		this.story_id = story_id;
	}

	public String getStory_title() {
		return story_title;
	}

	public void setStory_title(String story_title) {
		this.story_title = story_title;
	}

	public String getMain_img() {
		return main_img;
	}

	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}
	
	
}
