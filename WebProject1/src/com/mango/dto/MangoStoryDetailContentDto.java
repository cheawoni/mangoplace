package com.mango.dto;

public class MangoStoryDetailContentDto {
	//join : story_main sm, story_content sc, member m
	//where : sm.story_id = sc.story_id AND sc.member_number = m.member_number
	private String plate_name;	// 식당 이름
	private String content_img1; // 식당 이미지1
	private String img_source1;	//	식당 이미지1 소스
	private String content_text1;	// 식당 내용1
	private String content_img2;	// 식당 이미지2
	private String img_source2;	// 식당 이미지2 소스
	private String content_text2;	// 식당 내용2
	
	public MangoStoryDetailContentDto(String plate_name, String content_img1, String img_source1, String content_text1,
			String content_img2, String img_source2, String content_text2) {
		this.plate_name = plate_name;
		this.content_img1 = content_img1;
		this.img_source1 = img_source1;
		this.content_text1 = content_text1;
		this.content_img2 = content_img2;
		this.img_source2 = img_source2;
		this.content_text2 = content_text2;
	}

	public String getPlate_name() {
		return plate_name;
	}

	public void setPlate_name(String plate_name) {
		this.plate_name = plate_name;
	}

	public String getContent_img1() {
		return content_img1;
	}

	public void setContent_img1(String content_img1) {
		this.content_img1 = content_img1;
	}

	public String getImg_source1() {
		return img_source1;
	}

	public void setImg_source1(String img_source1) {
		this.img_source1 = img_source1;
	}

	public String getContent_text1() {
		return content_text1;
	}

	public void setContent_text1(String content_text1) {
		this.content_text1 = content_text1;
	}

	public String getContent_img2() {
		return content_img2;
	}

	public void setContent_img2(String content_img2) {
		this.content_img2 = content_img2;
	}

	public String getImg_source2() {
		return img_source2;
	}

	public void setImg_source2(String img_source2) {
		this.img_source2 = img_source2;
	}

	public String getContent_text2() {
		return content_text2;
	}

	public void setContent_text2(String content_text2) {
		this.content_text2 = content_text2;
	}
	
	
}
