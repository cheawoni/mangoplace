package com.mango.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.mango.dto.MangoStoryListDto;
import com.mango.dto.MangoStoryListMonthlyDto;

public class MangoStoryListDao {
	private Connection getConnection() {
		Connection conn = null;
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@203.245.30.223:1521:xe";
		String dbId = "mango";
		String dbPw = "1234";
		
		try {
			Class.forName(driver);
//			System.out.println("<h1>JDBC 드라이버 로딩 성공</h1>");
			conn = DriverManager.getConnection(url, dbId, dbPw);
//			System.out.println("<h1>접속성공</h1>");
		} catch(Exception e) {
			e.printStackTrace();
//			System.out.println("<p>오라클 접속 실패</p>");
		}
		return conn;
	}
	
	public ArrayList<MangoStoryListDto> getListMangoFromStoryPage(int storyListPageNumber) throws Exception {
		Connection conn = getConnection();
		
		ArrayList<MangoStoryListDto> StoryListMango = new ArrayList<MangoStoryListDto>();
		
		int startIdx = storyListPageNumber * 20 - 19;
		int endIdx = storyListPageNumber * 20;
		String sql = "SELECT *" + 
					 " FROM (SELECT rownum rnum, t1.*" + 
					 " FROM (SELECT sl.story_id, sm.story_title, sm.story_subtitle, sm.main_img, m.member_id, m.member_img, sl.recommended_review, sm.write_date " + 
					 " FROM story_list sl, story_main sm, member m" + 
					 " WHERE sl.story_id = sm.story_id AND sl.member_number = m.member_number" + 
					 " ORDER BY sm.write_date DESC) t1) t2" + 
					 " WHERE rnum >= ?  AND rnum <= ? ";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, startIdx);
		pstmt.setInt(2, endIdx);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int storyId = rs.getInt("story_id");
			String mainImg = rs.getString("main_img");
			String storyTitle = rs.getString("story_title");
			String storySubtitle = rs.getString("story_subtitle");
			String memberImg = rs.getString("member_img");
			String memberId = rs.getString("member_id");
			String recommendedReview = rs.getString("recommended_review");
			StoryListMango.add(new MangoStoryListDto(storyId, mainImg, storyTitle, storySubtitle, memberImg, memberId, recommendedReview));
		System.out.println(storyTitle);
		}
		pstmt.close();
		rs.close();
		conn.close();
		return StoryListMango;
	}
	
	public String getMonthlyTitleByStoryId(int monthlyStoryId) throws Exception {
		String sql = "SELECT story_title FROM story_main WHERE story_id=?";
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, monthlyStoryId);
		ResultSet rs = pstmt.executeQuery();
		String storyTitle = "";
		if(rs.next()) {
			storyTitle = rs.getString("story_title");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return storyTitle;
	}
	
	public String getMonthlySubtitleByStoryId(int monthlyStoryId) throws Exception {
		String sql = "SELECT story_subtitle FROM story_main WHERE story_id=?";
		Connection conn = getConnection();
		PreparedStatement pstmt2 = conn.prepareStatement(sql);
		pstmt2.setInt(1, monthlyStoryId);
		ResultSet rs2 = pstmt2.executeQuery();
		String storySubtitle ="";
		if(rs2.next()) {
			storySubtitle = rs2.getString("story_subtitle");
		}
		rs2.close();
		pstmt2.close();
		conn.close();
		return storySubtitle;
	}
				  
	public String getMonthlyMainImgByStoryId(int monthlyStoryId) throws Exception {
		String sql = "SELECT main_img FROM story_main WHERE story_id=?";
		Connection conn = getConnection();
		PreparedStatement pstmt3 = conn.prepareStatement(sql);
		pstmt3.setInt(1, monthlyStoryId);
		ResultSet rs3 = pstmt3.executeQuery();
		
		String mainImg = "";
		if(rs3.next()) {
			mainImg = rs3.getString("main_img");
		}
		rs3.close();
		pstmt3.close();
		conn.close();
		return mainImg;
	}
}
