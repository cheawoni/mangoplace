package com.mango.matzip.dto;

import java.sql.Date;

public class MatzipDetailTopDTO {
	String click;
	String date;
	String title;
	String ment;
	
	public MatzipDetailTopDTO() { }

	public MatzipDetailTopDTO(String click, String date, String title, String ment) {
		this.click = click;
		this.date = date;
		this.title = title;
		this.ment = ment;
	}

	public String getClick() {
		return click;
	}

	public void setClick(String click) {
		this.click = click;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMent() {
		return ment;
	}

	public void setMent(String ment) {
		this.ment = ment;
	}
	
	
}
