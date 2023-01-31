package com.mango.dto;

import java.util.ArrayList;

public class MangoStoryDetailDto {
	private String main_img;	// 메인 이미지
	private String main_source;	// 메인 이미지 소스
	private String member_id;	// ex. 망고소녀의 member_id
	private String story_title;	// 매거진 제목
	private String story_subtitle;	// 매거진 소제목
	private String write_date;	// 작성일시
	private String hitcount;	// 조회수
	private String gif_img1;	// 움짤 이미지1
	private String gif_source1;	// 움짤 이미지1 소스
	private String gif_text1;	// 움짤 이미지1 내용
	private ArrayList<MangoStoryDetailContentDto> listContentDto;
	private String gif_img2;	// 움짤 이미지2
	private String gif_source2;	// 움짤 이미지2 소스
	private String gif_text2;	// 움짤 이미지2 내용
	
	public MangoStoryDetailDto(String main_img, String main_source, String member_id,
			String story_title, String story_subtitle, String write_date, String hitcount,
			String gif_img1, String gif_source1, String gif_text1, ArrayList<MangoStoryDetailContentDto> listContentVO,
			String gif_img2, String gif_source2, String gif_text2) {
		this.main_img = main_img;
		this.main_source = main_source;
		this.member_id = member_id;
		this.story_title = story_title;
		this.story_subtitle = story_subtitle;
		this.write_date = write_date;
		this.hitcount = hitcount;
		this.gif_img1 = gif_img1;
		this.gif_source1 = gif_source1;
		this.gif_text1 = gif_text1;
		this.listContentDto = listContentVO;
		this.gif_img2 = gif_img2;
		this.gif_source2 = gif_source2;
		this.gif_text2 = gif_text2;
	}

	public String getMain_img() {
		return main_img;
	}

	public void setMain_img(String main_img) {
		this.main_img = main_img;
	}

	public String getMain_source() {
		return main_source;
	}

	public void setMain_source(String main_source) {
		this.main_source = main_source;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getStory_title() {
		return story_title;
	}

	public void setStory_title(String story_title) {
		this.story_title = story_title;
	}

	public String getStory_subtitle() {
		return story_subtitle;
	}

	public void setStory_subtitle(String story_subtitle) {
		this.story_subtitle = story_subtitle;
	}

	public String getWrite_date() {
		return write_date;
	}

	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}

	public String getHitcount() {
		return hitcount;
	}

	public void setHitcount(String hitcount) {
		this.hitcount = hitcount;
	}

	public String getGif_img1() {
		return gif_img1;
	}

	public void setGif_img1(String gif_img1) {
		this.gif_img1 = gif_img1;
	}

	public String getGif_source1() {
		return gif_source1;
	}

	public void setGif_source1(String gif_source1) {
		this.gif_source1 = gif_source1;
	}

	public String getGif_text1() {
		return gif_text1;
	}

	public void setGif_text1(String gif_text1) {
		this.gif_text1 = gif_text1;
	}

	public ArrayList<MangoStoryDetailContentDto> getListContentDto() {
		return listContentDto;
	}

	public void setListContentDto(ArrayList<MangoStoryDetailContentDto> listContentDto) {
		this.listContentDto = listContentDto;
	}

	public String getGif_img2() {
		return gif_img2;
	}

	public void setGif_img2(String gif_img2) {
		this.gif_img2 = gif_img2;
	}

	public String getGif_source2() {
		return gif_source2;
	}

	public void setGif_source2(String gif_source2) {
		this.gif_source2 = gif_source2;
	}

	public String getGif_text2() {
		return gif_text2;
	}

	public void setGif_text2(String gif_text2) {
		this.gif_text2 = gif_text2;
	}

}

