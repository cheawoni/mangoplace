package com.mango.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.mango.dto.MangoPopularSearchHashtagsDto;
import com.mango.dto.MangoPopularPlateRelatedContentListDto;


public class MangoPopularPlateRelatedContentListDao {
	private Connection getConnection() {
		Connection conn = null;
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
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
	
	public ArrayList<MangoPopularPlateRelatedContentListDto> getRelatedContentListFromSearchKeyword(String[] keywords) throws Exception {
		Connection conn = getConnection();
		ArrayList<MangoPopularPlateRelatedContentListDto> listPopularRelatedContentMango = new ArrayList<MangoPopularPlateRelatedContentListDto>();
		
		// (1) sqlWhereSearchKeyword : " WHERE (rl.restaurant_list || rl.ment || rl.hashtag LIKE ?)" +
		String sqlWhereSearchKeyword = "";   
		// ex. [강남]일 경우 							// [강남,곱창] 
		//	" WHERE (rl.restaurant_list || rl.ment || rl.hashtag LIKE '%강남%')" + 
		//	" AND (rl.restaurant_list || rl.ment || rl.hashtag LIKE '%곱창%') " + 

		if(keywords!=null) {
			for(int i=0; i<=keywords.length-1; i++) {
				sqlWhereSearchKeyword += "rl.restaurant_list || rl.ment || rl.hashtag LIKE '%"+keywords[i]+"%' ";
				if(i<keywords.length-1) {
					sqlWhereSearchKeyword += " AND ";
				}
			}
		}
//		if(!sqlWhereSearchKeyword.equals("")) {
//			sqlWhereSearchKeyword = " AND (" + sqlWhereSearchKeyword + ") ";
//		}

//		System.out.println("strWhereSearchKeyword : " + sqlWhereSearchKeyword);
		

		// (2) sqlWhereSearchKeyword2 : " WHERE (sm.story_title || sm.story_subtitle || sm.gif_text1 LIKE ?) "
		String sqlWhereSearchKeyword2 = "";   
		
		if(keywords!=null) {
			for(int i=0; i<=keywords.length-1; i++) {
				sqlWhereSearchKeyword2 += "sm.story_title || sm.story_subtitle || sm.gif_text1 LIKE '%"+keywords[i]+"%' ";
				if(i<keywords.length-1) {
					sqlWhereSearchKeyword2 += " AND ";
				}
			}
		}
//		if(!sqlWhereSearchKeyword2.equals("")) {
//			sqlWhereSearchKeyword2 = " AND (" + sqlWhereSearchKeyword2 + ") ";
//		}
		
//		System.out.println("sqlWhereSearchKeyword2 : " + sqlWhereSearchKeyword2);

		String sql = "SELECT t.update_date, t.* FROM (" + 
					" SELECT *" + 
					" FROM (SELECT rownum rnum, t1.*" + 
					" FROM (SELECT 'best' \"type\", rl.restaurant_list_idx \"idx\", rl.restaurant_list \"title\", rl.ment \"subtitle\", rl.main_img \"image\", rl.update_date" + 
					" FROM restaurant_list rl" + 
					//" WHERE (rl.restaurant_list || rl.ment || rl.hashtag LIKE ?)" + 
					" WHERE " +
					sqlWhereSearchKeyword +
					" ORDER BY rl.update_date DESC) t1) t2" + 
					" WHERE rnum >= 1  AND rnum <= 14" + 
					" UNION" + 
					" SELECT *" + 
					" FROM (SELECT rownum rnum, t3.*" + 
					" FROM (SELECT 'story' \"type\", sm.story_id \"idx\", sm.story_title \"title\", sm.story_subtitle \"subtitle\", sm.main_img \"image\", sm.write_date" + 
					" FROM story_main sm" + 
					//" WHERE (sm.story_title || sm.story_subtitle || sm.gif_text1 LIKE ?) " + 
					" WHERE " +
					sqlWhereSearchKeyword2 +
					" ORDER BY sm.write_date DESC) t3) t4" + 
					" WHERE rnum >= 1  AND rnum <= 14" + 
					" ) t" + 
					" ORDER BY t.update_date DESC";
System.out.println("SQL = " + sql);		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		//pstmt.setString(1, "%"+searchKeyword+"%");	// 검색어가 ? 일 경우			// 검색어를 ArrayList에 담음.
		//pstmt.setString(2, "%"+searchKeyword+"%");
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int rnum = rs.getInt("rnum");
			String type = rs.getString("type");
			int idx = rs.getInt("idx");
			String title = rs.getString("title");
			String subtitle = rs.getString("subtitle");
			String image = rs.getString("image");
			String updateDate = rs.getString("update_date");
			
			listPopularRelatedContentMango.add(new MangoPopularPlateRelatedContentListDto(rnum, type, idx, title, subtitle, image, updateDate));
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return listPopularRelatedContentMango;
	}
	
}
