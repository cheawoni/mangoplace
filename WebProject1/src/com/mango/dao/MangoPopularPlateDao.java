package com.mango.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.mango.dto.MangoPopularPlateDto;

public class MangoPopularPlateDao {
	private Connection getConnection() {
		Connection conn = null;
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbId = "mango";
		String dbPw = "1234";
		
		try {
			Class.forName(driver);
			System.out.println("<h1>JDBC 드라이버 로딩 성공</h1>");
			conn = DriverManager.getConnection(url, dbId, dbPw);
			System.out.println("<h1>접속성공</h1>");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("<p>오라클 접속 실패</p>");
		}
		return conn;
	}
	
	public ArrayList<MangoPopularPlateDto> getPopularPlateList(int pageNum, String[] keywords, String sorting, String[] arrCost, String[] arrArea, String[] arrFood, String parking) throws Exception {
		Connection conn = getConnection();
		
		ArrayList<MangoPopularPlateDto> listPlate = new ArrayList<MangoPopularPlateDto>();
		
		String sqlWhereSearchKeyword = "";
		// 강남,곱창
		// " AND (p.search_keyword || p.search_subkeyword || d.street_address || d.name || d.type || d.menu || d.hashtag LIKE '%강남%')" +
		//  AND (p.search_keyword || p.search_subkeyword || d.street_address || d.name || d.type || d.menu || d.hashtag LIKE '%곱창%')"
		
		if(keywords!=null) {
			for(int i=0; i<=keywords.length-1; i++) {
				sqlWhereSearchKeyword += "(p.search_keyword || p.search_subkeyword || d.street_address || d.name || d.type || d.menu || d.hashtag LIKE '%"+keywords[i]+"%')";
				if(i<keywords.length-1) {
					sqlWhereSearchKeyword += " AND ";
				}
			}
		}
		if(!sqlWhereSearchKeyword.equals("")) { // sqlWhereSearchKeyword가 있다면 
			sqlWhereSearchKeyword = " AND (" + sqlWhereSearchKeyword + ") ";
		}
System.out.println("strWhereSearchKeyword : " + sqlWhereSearchKeyword);
		
		// TODO: sorting
		String sqlOrderSorting = "";
		if("인기순".equals(sorting)) {
			sqlOrderSorting = "ORDER BY d.hitcount DESC, NVL(d.score,0) DESC) d1) d2";
		} else {
			sqlOrderSorting = "ORDER BY NVL(d.score,0) DESC, d.hitcount DESC) d1) d2";
		}
		
		// TODO: arrCost
		//AND (
		//PRICE = '만원 미만'
		//OR PRICE = '1만원대'
		//OR PRICE = '2만원대'
		//OR PRICE = '3만원대'
		//OR PRICE = '4만원대'
		//)
		
		String sqlWhereCost = "";
		if(arrCost!=null && arrCost.length>0) { // SCE
			sqlWhereCost += " AND (";
			for(int i=0; i<=arrCost.length-1; i++) {
				if(i>=1) sqlWhereCost += " OR ";
				if(arrCost[i]==null) System.out.println("주의! arrCost[i] is null !!");
				else {
					switch(arrCost[i]) {
					case "만원미만": sqlWhereCost += "PRICE = '만원 미만'"; break;
					case "1만원대": sqlWhereCost += "PRICE = '만원-2만원'"; break;
					case "2만원대": sqlWhereCost += "PRICE = '2만원-3만원'"; break;
					case "3만원대": sqlWhereCost += "PRICE = '3만원-4만원'"; break;
					case "4만원대": sqlWhereCost += "PRICE = '4만원 이상'"; break;
					}
				}
			}
			sqlWhereCost += ") ";
		}
		
		// TODO: arrArea
		String sqlWhereArea = "";
		if(arrArea!=null && arrArea.length>0) {
			sqlWhereArea += " AND ( ";
			for(int i=0; i<=arrArea.length-1; i++) {
				if(i>=1) sqlWhereArea += " OR ";
				sqlWhereArea += "d.area = '" + arrArea[i].replace("/", "//")+ "'";
			}
			sqlWhereArea += ") ";
		}
System.out.println("sqlWhereArea : " + sqlWhereArea);

		// TODO: arrFood
		String sqlWhereFood = "";
		if(arrFood!=null && arrFood.length>0) {
			sqlWhereFood += " AND ( ";
			for(int i=0; i<=arrFood.length-1; i++) {
				if(i>=1) sqlWhereFood += " OR ";
				sqlWhereFood += "(d.type LIKE '%" + arrFood[i] + "%' OR p.search_subkeyword LIKE '%" + arrFood[i] + "%')";
			}
			sqlWhereFood += ") ";
		}
System.out.println("sqlWhereFood : " + sqlWhereFood);
		
		// TODO: parking
		String sqlWhereParking = "";
		if("주차가능".equals(parking)) {
			sqlWhereParking += " AND parking Like '%가능%'";
		}
		
		int startRnum = pageNum * 20 - 19;
		int endRnum = pageNum * 20;
		String sql = "SELECT *" + 
				" FROM (SELECT rownum rnum, d1.*" + 
				" FROM (SELECT d.plate_id, d.name, d.main_img, d.branch, d.score, d.hitcount, d.review," + 
				" d.wish, d.area, d.street_address, d.jibun_address, d.phone_number, d.type, d.price, d.parking, d.business_hour, " + 
				" d.break_time, d.last_order, d.day_off, d.webpage, d.menu, d.update_date, d.latitude, d.longitude, d.hashtag, " + 
				" p.search_keyword, p.search_subkeyword" + 
				" FROM details d, popular_search_keywords p " + 
				" WHERE d.plate_id = p.plate_id(+) " + 
				//" AND  ( " + 
				//" (p.search_keyword || d.street_address || d.name || d.type || d.menu || d.hashtag LIKE ?) " + 
				//" AND (p.search_keyword || d.street_address || d.name || d.type || d.menu || d.hashtag LIKE ?) " + 
				//" )" + 
				sqlWhereSearchKeyword +
				sqlWhereCost +
				sqlWhereFood +
				sqlWhereParking +
				//" ORDER BY NVL(d.score,0) DESC, d.hitcount DESC) d1) d2" + 
				sqlOrderSorting +
				" WHERE rnum>=? AND rnum<=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, startRnum);
		pstmt.setInt(2, endRnum);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int plateId = rs.getInt("plate_id");
			String mainImg = rs.getString("main_img");
			String name = rs.getString("name");
			String branch = rs.getString("branch");
			String score = rs.getString("score");
			String area = rs.getString("area");
			String type= rs.getString("type");
			int hitcount = rs.getInt("hitcount");
			int review = rs.getInt("review");
			MangoPopularPlateDto dto = new MangoPopularPlateDto(plateId, mainImg, name, branch, score, area, type, hitcount, review);
			listPlate.add(dto);
		}
		conn.close();
		return listPlate;
	}
}
