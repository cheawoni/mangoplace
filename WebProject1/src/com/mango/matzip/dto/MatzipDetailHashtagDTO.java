package com.mango.matzip.dto;

public class MatzipDetailHashtagDTO {
	String[] hashtag;
	String keyword;
	public MatzipDetailHashtagDTO() { }
	
	public MatzipDetailHashtagDTO(String[] hashtag, String keyword) {
		this.hashtag = hashtag;
		this.keyword = keyword;
	}

	public String[] getHashtag() {
		return hashtag;
	}

	public void setHashtag(String[] hashtag) {
		this.hashtag = hashtag;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	
	
}
