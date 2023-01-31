package com.mango.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.mango.dto.MangoPopularPlateDto2;
import com.mango.dto.MangoPopularSearchHashtagsDto;

public class MangoPopularPlateDao2 {
	private Connection getConnection() {
		Connection conn = null;
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";   // localhost --> 203.245.30.223
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
	
	public ArrayList<MangoPopularPlateDto2> getPopularPlateList(int pageNum, String[] keywords, String sorting, String[] arrCost, String[] arrArea, String[] arrFood, String parking, String topkeyword) throws Exception {
		Connection conn = getConnection();
		
		ArrayList<MangoPopularPlateDto2> listResult = new ArrayList<MangoPopularPlateDto2>();
		
		String sqlWhereSearchKeyword = "";   
		// ex. [강남,곱창] 
		// 	-->" (p.search_keyword || p.search_subkeyword || d.street_address || d.name || d.type || d.menu || d.hashtag LIKE '%강남%') " +		// p.search_subkeyword 추가했음
		//	" AND (p.search_keyword || p.search_subkeyword || d.street_address || d.name || d.type || d.menu || d.hashtag LIKE '%곱창%') " + 		// p.search_subkeyword 추가했음

		if(keywords!=null) {
			for(int i=0; i<=keywords.length-1; i++) {
				sqlWhereSearchKeyword += "(p.search_keyword || p.search_subkeyword || d.street_address || d.name || d.type || d.menu || d.hashtag LIKE '%"+keywords[i]+"%') ";
				if(i<keywords.length-1) {
					sqlWhereSearchKeyword += " AND ";
				}
			}
		}
		if(!sqlWhereSearchKeyword.equals("")) {
			sqlWhereSearchKeyword = " AND (" + sqlWhereSearchKeyword + ") ";
		}

//System.out.println("strWhereSearchKeyword : " + sqlWhereSearchKeyword);

		String sqlWhereCost = "";
		if(arrCost!=null && arrCost.length>0) {    // Short-Circuit Evaluation	
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
		
		// arrArea
		String sqlWhereArea = "";
		if(arrArea!=null && arrArea.length>0) {  // SCE.
			sqlWhereArea += " AND ( ";
			for(int i=0; i<=arrArea.length-1; i++) {
				if(i>=1) sqlWhereArea += " OR ";
				sqlWhereArea += "d.area = '" + arrArea[i].replace("/", "//") + "'";
			}
			sqlWhereArea += ") ";
		}
//		System.out.println("sqlWhereArea : " + sqlWhereArea);
		
		// arrFood
		String sqlWhereFood = "";
		if(arrFood!=null && arrFood.length>0) {  // SCE.
			sqlWhereFood += " AND ( ";
			for(int i=0; i<=arrFood.length-1; i++) {
				if(i>=1) sqlWhereFood += " OR ";
				sqlWhereFood += "(d.type LIKE '%" + arrFood[i] + "%' OR p.search_subkeyword LIKE '%" + arrFood[i] + "%')";
			}
			sqlWhereFood += ") ";
		}
//		System.out.println("sqlWhereFood : " + sqlWhereFood);
		
		// parking
		String sqlWhereParking = "";
		if("주차가능".equals(parking)) {
			sqlWhereParking += " AND parking LIKE '%가능%'";
		}
		
		// topkeyword    (ex. "이탈리안")
		String sqlWhereTopkeyword = "";
		if(topkeyword != null && !"".equals(topkeyword)) {
			sqlWhereTopkeyword += " AND p.search_subkeyword LIKE '%" + topkeyword + "%'";
			if(topkeyword==null || "null".equals(topkeyword)) {
				sqlWhereTopkeyword="";
			}
		}
		
		// sorting
		String sqlOrderSorting = "";
		if("인기순".equals(sorting)) {
			sqlOrderSorting = " ORDER BY d.hitcount DESC, NVL(d.score,0) DESC) d1) d2";
		} else {
			sqlOrderSorting = " ORDER BY NVL(d.score,0) DESC, d.hitcount DESC) d1) d2";
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
				sqlWhereSearchKeyword +
				//" )" +
				sqlWhereCost +	 
				sqlWhereArea +
				sqlWhereFood +
				sqlWhereParking + 
				sqlWhereTopkeyword + 
				sqlOrderSorting + 
				" WHERE rnum>=? AND rnum<=?";

//System.out.println("getPopularPlateList sql : " + sql);
//System.out.println("-startRnum : " + startRnum);
//System.out.println("-endRnum : " + endRnum);
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
			String type = rs.getString("type");
			int hitcount = rs.getInt("hitcount");
			int review = rs.getInt("review");
			double latitude = rs.getDouble("latitude");   // 위도
			double longitude = rs.getDouble("longitude");  // 경도
			//MangoPopularPlateDto2 dto = new MangoPopularPlateDto2(plateId, mainImg, name, branch, score, area, type, hitcount, review);
			MangoPopularPlateDto2 dto = new MangoPopularPlateDto2(plateId, mainImg, name, branch, score, area, type, hitcount, review, latitude, longitude);
			listResult.add(dto);
		}
		conn.close();
		return listResult;
	}
	
	private double getDistance(double latitude1, double longitude1, double latitude2, double longitude2) {
		double latDiff = latitude1 - latitude2;
		double longDiff = longitude1 - longitude2;
		return Math.sqrt(latDiff*latDiff + longDiff*longDiff);
	}
	
	public ArrayList<MangoPopularPlateDto2> getPopularPlateListNearby(String[] keywords, String nearby) throws Exception {
		Connection conn = getConnection();
		
		ArrayList<MangoPopularPlateDto2> listResult = new ArrayList<MangoPopularPlateDto2>();
		
		String sqlWhereSearchKeyword = "";   

		if(keywords!=null) {
			for(int i=0; i<=keywords.length-1; i++) {
				sqlWhereSearchKeyword += "(p.search_keyword || p.search_subkeyword || d.street_address || d.name || d.type || d.menu || d.hashtag LIKE '%"+keywords[i]+"%') ";
				if(i<keywords.length-1) {
					sqlWhereSearchKeyword += " AND ";
				}
			}
		}
		if(!sqlWhereSearchKeyword.equals("")) {
			sqlWhereSearchKeyword = " AND (" + sqlWhereSearchKeyword + ") ";
		}
		
//System.out.println("strWhereSearchKeyword : " + sqlWhereSearchKeyword);


		// ------------------- nearby 위도 경도 파악 --------------------------
		double centerLatitude = 0.0;  // 위도
		double centerLongitude = 0.0; // 경도
		
		String sql = "SELECT * FROM location_hashtag WHERE hashtag=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, nearby);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			centerLatitude = rs.getDouble("latitude");
			centerLongitude = rs.getDouble("longitude");
		}
		rs.close();
		pstmt.close();

		// ------------------- 전체 details 불러오기 --------------------------
		sql = "SELECT *" + 
				" FROM (SELECT rownum rnum, d1.*" + 
				" FROM (SELECT d.plate_id, d.name, d.main_img, d.branch, d.score, d.hitcount, d.review," + 
				" d.wish, d.area, d.street_address, d.jibun_address, d.phone_number, d.type, d.price, d.parking, d.business_hour, " + 
				" d.break_time, d.last_order, d.day_off, d.webpage, d.menu, d.update_date, d.latitude, d.longitude, d.hashtag, " + 
				" p.search_keyword, p.search_subkeyword" + 
				" FROM details d, popular_search_keywords p " + 
				" WHERE d.plate_id = p.plate_id(+) " + 
				sqlWhereSearchKeyword +
				" ORDER BY NVL(d.score,0) DESC, d.hitcount DESC) d1) ";
		
//System.out.println("getPopularPlateListNearby sql : " + sql);

		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			int plateId = rs.getInt("plate_id");
			String mainImg = rs.getString("main_img");
			String name = rs.getString("name");
			String branch = rs.getString("branch");
			String score = rs.getString("score");
			String area = rs.getString("area");
			String type = rs.getString("type");
			int hitcount = rs.getInt("hitcount");
			int review = rs.getInt("review");
			double latitude = rs.getDouble("latitude");   // 위도
			double longitude = rs.getDouble("longitude");  // 경도
			MangoPopularPlateDto2 dto = new MangoPopularPlateDto2(plateId, mainImg, name, branch, score, area, type, hitcount, review, latitude, longitude);
			listResult.add(dto);
		}
		conn.close();
		
		// ----------------------- sort by distance (거리순. 오름차순) : ArrayList객체. ------------------
		// getDistance(위도,경도 , 위도,경도)
		// MangoPopularPlateDto2 dto = listResult.get(i);
		// getDistance(centerLatitude, centerLongitude , dto.getLatitude(),dto.getLongitude())
		for(int i=listResult.size()-1; i>=1; i--) {
			for(int j=0; j<=i-1; j++) {
				// [j] vs [j+1]
				MangoPopularPlateDto2 dtoJ = listResult.get(j);
				MangoPopularPlateDto2 dtoJplus1 = listResult.get(j+1);
				double dist1 = getDistance(centerLatitude, centerLongitude, dtoJ.getLatitude(), dtoJ.getLongitude());
				double dist2 = getDistance(centerLatitude, centerLongitude, dtoJplus1.getLatitude(), dtoJplus1.getLongitude());
				if(dist1 > dist2) {
					MangoPopularPlateDto2 temp = listResult.get(j);
					listResult.set(j, listResult.get(j+1));
					listResult.set(j+1, temp);
				}
			}
		}
		
		// 20개만 추려서 보내기로...(2023/1/18)
		while(listResult.size()>20) {
			listResult.remove(20);
		}
		return listResult;
	}
	
	public int getPopularPlateCount(String[] keywords, String sorting, String[] arrCost, String[] arrArea, String[] arrFood, String parking, String topkeyword) throws Exception {
		Connection conn = getConnection();
		
		ArrayList<MangoPopularPlateDto2> listResult = new ArrayList<MangoPopularPlateDto2>();
		
		String sqlWhereSearchKeyword = "";   

		if(keywords!=null) {
			for(int i=0; i<=keywords.length-1; i++) {
				sqlWhereSearchKeyword += "(p.search_keyword || d.street_address || d.name || d.type || d.menu || d.hashtag LIKE '%"+keywords[i]+"%') ";
				if(i<keywords.length-1) {
					sqlWhereSearchKeyword += " AND ";
				}
			}
		}
		if(!sqlWhereSearchKeyword.equals("")) {
			sqlWhereSearchKeyword = " AND (" + sqlWhereSearchKeyword + ") ";
		}
//System.out.println("sqlWhereSearchKeyword : " + sqlWhereSearchKeyword);
		
		// TODO: arrCost
		/*
		AND (
		PRICE = '만원 미만'  --만원미만 
		OR PRICE = '만원-2만원'  --1만원대
		OR PRICE = '2만원-3만원'  --2만원대
		OR PRICE = '3만원-4만원'  --3만원대
		OR PRICE = '4만원 이상'  --4만원대
		)
		 */
		String sqlWhereCost = "";
		if(arrCost!=null && arrCost.length>0) {    // Short-Circuit Evaluation	
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
		if(arrArea!=null && arrArea.length>0) {  // SCE.
			sqlWhereArea += " AND ( ";
			for(int i=0; i<=arrArea.length-1; i++) {
				if(i>=1) sqlWhereArea += " OR ";
				sqlWhereArea += "d.area = '" + arrArea[i].replace("/", "//") + "'";
			}
			sqlWhereArea += ") ";
		}
//		System.out.println("sqlWhereArea : " + sqlWhereArea);
		
		// TODO: arrFood
		String sqlWhereFood = "";
		if(arrFood!=null && arrFood.length>0) {  // SCE.
			sqlWhereFood += " AND ( ";
			for(int i=0; i<=arrFood.length-1; i++) {
				if(i>=1) sqlWhereFood += " OR ";
				sqlWhereFood += "(d.type LIKE '%" + arrFood[i] + "%' OR p.search_subkeyword LIKE '%" + arrFood[i] + "%')";
			}
			sqlWhereFood += ") ";
		}
//		System.out.println("sqlWhereFood : " + sqlWhereFood);
		
		// TODO: parking
		String sqlWhereParking = "";
		if("주차가능".equals(parking)) {
			sqlWhereParking += " AND parking LIKE '%가능%'";
		}
		
		// TODO : topkeyword    (ex. "이탈리안")
		String sqlWhereTopkeyword = "";
		if(topkeyword != null && !"".equals(topkeyword)) {
			sqlWhereTopkeyword += " AND (d.type LIKE '%" + topkeyword + "%' AND p.search_subkeyword LIKE '%" + topkeyword + "%')";
		}
//		System.out.println("sqlWheretopkeyword : " + topkeyword);
		
		// TODO: sorting
		String sqlOrderSorting = "";
		if("인기순".equals(sorting)) {
			sqlOrderSorting = " ORDER BY d.hitcount DESC, NVL(d.score,0) DESC)";
		} else {
			sqlOrderSorting = " ORDER BY NVL(d.score,0) DESC, d.hitcount DESC)";
		}
		

		String sql = "SELECT count(*)" + 
				" FROM (SELECT d.plate_id, d.name, d.main_img, d.branch, d.score, d.hitcount, d.review," + 
				" d.wish, d.area, d.street_address, d.jibun_address, d.phone_number, d.type, d.price, d.parking, d.business_hour, " + 
				" d.break_time, d.last_order, d.day_off, d.webpage, d.menu, d.update_date, d.latitude, d.longitude, d.hashtag, " + 
				" p.search_keyword, p.search_subkeyword" + 
				" FROM details d, popular_search_keywords p " + 
				" WHERE d.plate_id = p.plate_id(+) " + 
				//" AND  ( " +
				sqlWhereSearchKeyword +
				//" )" +
				sqlWhereCost +	 
				sqlWhereArea +
				sqlWhereFood +
				sqlWhereParking + 
				sqlWhereTopkeyword + 
				sqlOrderSorting;// + 
				//" WHERE rnum>=? AND rnum<=?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		int cnt = -1;   // -1은 초기 값일 뿐.
		if(rs.next()) {
			cnt = rs.getInt(1);
		}
		conn.close();
		return cnt;
	}
	
	public ArrayList<MangoPopularSearchHashtagsDto> getHashtagListFromSearchKeyword(String[] arrKeyword) throws Exception {
		Connection conn = getConnection();
		ArrayList<MangoPopularSearchHashtagsDto> listHashtagsMango = new ArrayList<MangoPopularSearchHashtagsDto>();

		// ex. [강남]일 경우 							// [강남,곱창,BB] 
		//	" WHERE search_keyword LIKE '%강남%'" + 
		//	" AND search_keyword LIKE '%곱창%'" + 
		//	" AND search_keyword LIKE '%BB%'"

		String sql = "SELECT search_keyword, hashtag" + 
					" FROM local_hashtags ";
		for(int i=0; i<=arrKeyword.length-1; i++) {
			if(i==0) sql += " WHERE ";
			else sql += " AND ";
			sql += "search_keyword LIKE '%" + arrKeyword[i] + "%'";
		}
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			String search_keyword = rs.getString("search_keyword"); 	
			String hashtag = rs.getString("hashtag");    /// 띄어쓰기 구분되어 있음.
			listHashtagsMango.add(new MangoPopularSearchHashtagsDto(search_keyword, hashtag));
		}
		rs.close();
		pstmt.close();
		
		return listHashtagsMango;
	}
	
	
}
