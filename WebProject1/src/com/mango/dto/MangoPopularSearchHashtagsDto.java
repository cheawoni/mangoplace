package com.mango.dto;

public class MangoPopularSearchHashtagsDto {
	String search_keyword; 
	String hashtag;
	
	public MangoPopularSearchHashtagsDto(String search_keyword, String hashtag) {
		this.search_keyword = search_keyword;
		this.hashtag = hashtag;
	}

	public String getSearch_keyword() {
		return search_keyword;
	}

	public void setSearch_keyword(String search_keyword) {
		this.search_keyword = search_keyword;
	}

	public String getHashtag() {
		return hashtag;
	}

	public void setHashtag(String hashtag) {
		this.hashtag = hashtag;
	}
	
	
}
