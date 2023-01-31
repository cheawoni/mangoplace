package com.mango.matzip.dto;

public class MatzipHashtagDTO {
	int idx;
	String hashtag;
	
	public MatzipHashtagDTO() { }
	public MatzipHashtagDTO(int idx, String hashtag) {
		this.idx = idx;
		this.hashtag = hashtag;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getHashtag() {
		return hashtag;
	}
	public void setHashtag(String hashtag) {
		this.hashtag = hashtag;
	}
	
	
}
