package com.yg.dto;

public class BoardDTO {
	private int bno;
	private String writer;
	private String title;
	private String content;
	private String writedate;
	
	public BoardDTO() { }
	public BoardDTO(int bno, String writer, String title, String content, String writedate) {
		this.bno = bno;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.writedate = writedate;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWritedate() {
		return writedate;
	}

	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	
	
	
}
