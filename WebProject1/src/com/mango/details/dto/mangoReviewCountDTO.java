package com.mango.details.dto;

public class mangoReviewCountDTO {
	private int sum;
	private int good;
	private int notBad;
	private int bad;
	public mangoReviewCountDTO() {};
	public mangoReviewCountDTO(int sum, int good, int notBad, int bad) {
		this.sum = sum;
		this.good = good;
		this.notBad = notBad;
		this.bad = bad;
	}
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
	}
	public int getGood() {
		return good;
	}
	public void setGood(int good) {
		this.good = good;
	}
	public int getNotBad() {
		return notBad;
	}
	public void setNotBad(int notBad) {
		this.notBad = notBad;
	}
	public int getBad() {
		return bad;
	}
	public void setBad(int bad) {
		this.bad = bad;
	}
	
}