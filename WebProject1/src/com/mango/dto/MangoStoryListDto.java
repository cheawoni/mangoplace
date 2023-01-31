package com.mango.dto;

public class MangoStoryListDto {
	private int storyId;
	private String mainImg;
	private String storyTitle;
	private String storySubtitle;
	private String memberImg;
	private String memberId;
	private String recommendedReview;
	
	public MangoStoryListDto(int storyId, String mainImg, String storyTitle, String storySubtitle, String memberImg,
			String memberId, String recommendedReview) {
		this.storyId = storyId;
		this.mainImg = mainImg;
		this.storyTitle = storyTitle;
		this.storySubtitle = storySubtitle;
		this.memberImg = memberImg;
		this.memberId = memberId;
		this.recommendedReview = recommendedReview;
	}

	public int getStoryId() {
		return storyId;
	}

	public void setStoryId(int storyId) {
		this.storyId = storyId;
	}

	public String getMainImg() {
		return mainImg;
	}

	public void setMainImg(String mainImg) {
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

	public String getMemberImg() {
		return memberImg;
	}

	public void setMemberImg(String memberImg) {
		this.memberImg = memberImg;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getRecommendedReview() {
		return recommendedReview;
	}

	public void setRecommendedReview(String recommendedReview) {
		this.recommendedReview = recommendedReview;
	}
	
	
}
