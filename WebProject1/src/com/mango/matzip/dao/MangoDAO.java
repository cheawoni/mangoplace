package com.mango.matzip.dao;

import java.sql.Connection;
import java.util.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mango.matzip.dto.Main8RestaurantDTO;
import com.mango.matzip.dto.MainMangostoryDTO;
import com.mango.matzip.dto.MainMatziplistDTO;
import com.mango.matzip.dto.MatzipDetailBottomDTO;
import com.mango.matzip.dto.MatzipDetailDTO;
import com.mango.matzip.dto.MatzipDetailHashtagDTO;
import com.mango.matzip.dto.MatzipDetailTopDTO;
import com.mango.matzip.dto.MatzipHashtagDTO;
import com.mango.matzip.dto.MatzipListDTO;


public class MangoDAO {
	private Connection getConnection() {
	      Connection conn = null;
	      
	      String driver = "oracle.jdbc.driver.OracleDriver";
	      String url = "jdbc:oracle:thin:@localhost:1521:xe";
	      String dbId = "mango";
	      String dbPw = "1234";
	      
	      try {
	         Class.forName(driver);
	         //System.out.println("<h1>JDBC 드라이버 로딩 성공</h1>");
	         conn = DriverManager.getConnection(url, dbId, dbPw);
	         //System.out.println("<h1>접속성공</h1>");
	      } catch(Exception e) {
	         e.printStackTrace();
	         //System.out.println("오라클 접속 실패");
	      }
	      return conn;
	   }
	
//	public ArrayList<MainBackgroundDTO> getBackground() throws Exception {
//		Connection conn = getConnection();
//		String sql = "SELECT background_img"
//				+ " FROM main_background ORDER BY DBMS_RANDOM.RANDOM";
//		ArrayList<MainBackgroundDTO> background = new ArrayList<MainBackgroundDTO>();
//		PreparedStatement pstmt = conn.prepareStatement(sql);
//		ResultSet rs = pstmt.executeQuery();
//		while(rs.next()) {
//			String back = rs.getString("background_img");
//			MainBackgroundDTO DTO = new MainBackgroundDTO(back);
//			background.add(DTO);
//		}
//		rs.close();
//		pstmt.close();
//		conn.close();
//		return background;
//	}
	
	public String randomMainBackground()  {		// 메인화면 뒷배경
		Connection conn = getConnection();
		String sql = "SELECT background_img"
				+ " FROM main_background ORDER BY DBMS_RANDOM.RANDOM";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String background_img = "";
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				background_img = rs.getString("background_img");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return background_img;
	}
	
	public ArrayList<MainMatziplistDTO> getMainMatzipList() throws Exception {	// 메인 맛집리스트 12개
		Connection conn = getConnection();
		ArrayList<MainMatziplistDTO> mainmatzip = new ArrayList<MainMatziplistDTO>();
		String sql = "SELECT r.restaurant_list, r.ment, r.main_img, r.restaurant_list_idx" + 
				" FROM restaurant_list r" + 
				" ORDER BY r.update_date DESC";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		int cnt = 0;
		while(rs.next()) {
			cnt++;
			String matziplist = rs.getString("restaurant_list");
			String ment = rs.getString("ment");
			String img = rs.getString("main_img");
			int listidx = rs.getInt("restaurant_list_idx");
//			MainMatziplistDTO DTO = new MainMatziplistDTO(matziplist, ment, img);
			mainmatzip.add(new MainMatziplistDTO(matziplist, ment, img, listidx));
			if(cnt==12) {
				break;
			}
		}
		rs.close();
		pstmt.close();
		conn.close();
		return mainmatzip;
	}
	
	public ArrayList<MainMangostoryDTO> getMangolist() throws Exception {	// 메인 망고스토리 9개
		Connection conn = getConnection();
		ArrayList<MainMangostoryDTO> mainmangolist = new ArrayList<MainMangostoryDTO>();
		String sql = "SELECT sm.story_title, sm.member_number, sm.story_subtitle, sm.main_img, m.member_img, m.member_id, sm.story_id" + 
				" FROM story_main sm, story_list sl, member m" + 
				" WHERE sm.member_number = m.member_number" + 
				" AND sm.story_id = sl.story_id" +
				" ORDER BY sm.write_date DESC";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs= pstmt.executeQuery();
		int cnt = 0;
		while(rs.next()) {
			cnt++;
			String story_title = rs.getString("story_title");
			int member_number = rs.getInt("member_number");
			String story_subtitle = rs.getString("story_subtitle");
			String main_img = rs.getString("main_img");
			String member_img = rs.getString("member_img");
			String member_id = rs.getString("member_id");
			int story_id = rs.getInt("story_id");
			MainMangostoryDTO DTO = new MainMangostoryDTO(story_title,member_number,story_subtitle,main_img,member_img,member_id, story_id);
			mainmangolist.add(DTO);
			if(cnt==9) {
				break;
			}
		}
		rs.close();
		pstmt.close();
		conn.close();
		return mainmangolist;
	}
	
	public ArrayList<Main8RestaurantDTO> get8eatdeal() throws Exception {	// 메인 잇딜 8개
		Connection conn = getConnection();
		ArrayList<Main8RestaurantDTO> main8eatdealRes = new ArrayList<Main8RestaurantDTO>();
		String sql = "SELECT distinct(plate_id), main_img, name, score, area, type FROM details d" + 
				" WHERE d.plate_id >= 1500 AND d.plate_id <= 1643" +
				" ORDER BY DBMS_RANDOM.RANDOM";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		int cnt = 0;
		while(rs.next()) {
			cnt++;
			int plate_id = rs.getInt("plate_id");
			String main_img = rs.getString("main_img");
			String name = rs.getString("name");
			double score = rs.getDouble("score");
			String area = rs.getString("area");
			String type = rs.getString("type");
			Main8RestaurantDTO DTO = new Main8RestaurantDTO(plate_id, main_img, name, score, area, type);
			main8eatdealRes.add(DTO);
			if(cnt==8) {
				break;
			}
		}
		rs.close();
		pstmt.close();
		conn.close();
		return main8eatdealRes;
	}
	
	public ArrayList<Main8RestaurantDTO> get8editor() throws Exception {	// 메인 에디터 8개
		Connection conn = getConnection();
		ArrayList<Main8RestaurantDTO> main8editorRes = new ArrayList<Main8RestaurantDTO>();
		String sql = "SELECT d.plate_id, d.main_img, d.name, d.area, d.type, d.score" + 
				" FROM details d, main_story_content m" + 
				" WHERE d.plate_id = m.plate_id" + 
				" ORDER BY DBMS_RANDOM.RANDOM";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		int cnt = 0;
		while(rs.next()) {
			cnt++;
			int plate_id = rs.getInt("plate_id");
			String main_img = rs.getString("main_img");
			String name = rs.getString("name");
			double score = rs.getDouble("score");
			String area = rs.getString("area");
			String type = rs.getString("type");
			Main8RestaurantDTO DTO = new Main8RestaurantDTO(plate_id, main_img, name, score, area, type);
			main8editorRes.add(DTO);
			if(cnt==8) {
				break;
			}
		}
		rs.close();
		pstmt.close();
		conn.close();
		return main8editorRes;
	}
	
	public ArrayList<Main8RestaurantDTO> get8TVres() throws Exception {		// 메인 TV 8개
		Connection conn = getConnection();
		ArrayList<Main8RestaurantDTO> main8ResOnTV = new ArrayList<Main8RestaurantDTO>();
		String sql = "SELECT distinct(plate_id) , main_img , name , score , area , type" + 
				" FROM details d" + 
				" WHERE (d.hashtag like '%수요%' OR d.hashtag like '%백종%' OR d.hashtag like '%vj%' OR d.hashtag like '%6시%'" + 
				" OR d.hashtag like '%식신%' OR d.hashtag like '%생방송%' OR d.hashtag like '%최자%' OR d.hashtag like '%맛있는%')" + 
				" ORDER BY DBMS_RANDOM.RANDOM";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		int cnt = 0;
		while(rs.next()) {
			cnt++;
			int plate_id = rs.getInt("plate_id");
			String main_img = rs.getString("main_img");
			String name = rs.getString("name");
			double score = rs.getDouble("score");
			String area = rs.getString("area");
			String type = rs.getString("type");
			Main8RestaurantDTO DTO = new Main8RestaurantDTO(plate_id, main_img, name, score, area, type);
			main8ResOnTV.add(DTO);
			if(cnt==8) {
				break;
			}
		}
		rs.close();
		pstmt.close();
		conn.close();
		return main8ResOnTV;
	}
	
	public ArrayList<Main8RestaurantDTO> get8TopRated() throws Exception {		// 메인 평점 8개
		Connection conn = getConnection();
		ArrayList<Main8RestaurantDTO> main8TopRated = new ArrayList<Main8RestaurantDTO>();
		String sql = "SELECT distinct(plate_id), main_img, name, score, area, type" +
				" FROM details d" +
				" WHERE d.score >= 4.3" +
				" ORDER BY DBMS_RANDOM.RANDOM";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		int cnt = 0;
		while(rs.next()) {
			cnt++;
			int plate_id = rs.getInt("plate_id");
			String main_img = rs.getString("main_img");
			String name = rs.getString("name");
			double score = rs.getDouble("score");
			String area = rs.getString("area");
			String type = rs.getString("type");
			Main8RestaurantDTO DTO = new Main8RestaurantDTO(plate_id, main_img, name, score, area, type);
			main8TopRated.add(DTO);
			if(cnt==8) {
				break;
			}
		}
		rs.close();
		pstmt.close();
		conn.close();
		return main8TopRated;
	}
	
	public ArrayList<MainMatziplistDTO> getMatziplistByRegion() throws Exception {		// 메인 지역별 인기 맛집
		Connection conn = getConnection();
		ArrayList<MainMatziplistDTO> matziplistByRegion = new ArrayList<MainMatziplistDTO>();
		String sql = "SELECT restaurant_list, ment, main_img, restaurant_list_idx"
				+ " FROM restaurant_list r"
				+ " WHERE r.restaurant_list_idx >=13 AND r.restaurant_list_idx <=18"
				+ " ORDER BY restaurant_list_idx DESC";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		int cnt = 0;
		while(rs.next()) {
			cnt++;
			String matziplist = rs.getString("restaurant_list");
			String ment = rs.getString("ment");
			String img = rs.getString("main_img");
			int listidx = rs.getInt("restaurant_list_idx");
			MainMatziplistDTO DTO = new MainMatziplistDTO(matziplist, ment, img, listidx);
			matziplistByRegion.add(DTO);
			if(cnt==6) {
				break;
			}
		}
		rs.close();
		pstmt.close();
		conn.close();
		return matziplistByRegion;
	}
	public ArrayList<MainMatziplistDTO> getMatziplistByMenu() throws Exception {	// 메인 메뉴별 인기 맛집
		Connection conn = getConnection();
		ArrayList<MainMatziplistDTO> matziplistByMenu = new ArrayList<MainMatziplistDTO>();
		String sql = "SELECT restaurant_list, ment, main_img, restaurant_list_idx"
				+ " FROM restaurant_list r"
				+ " WHERE r.restaurant_list_idx >=1 AND r.restaurant_list_idx <=12"
				+ " ORDER BY r.restaurant_list_idx DESC";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		int cnt = 0;
		while(rs.next()) {
			//cnt++;
			String matziplist = rs.getString("restaurant_list");
			String ment = rs.getString("ment");
			String img = rs.getString("main_img");
			int listidx = rs.getInt("restaurant_list_idx");
			MainMatziplistDTO DTO = new MainMatziplistDTO(matziplist, ment, img, listidx);
			matziplistByMenu.add(DTO);
//			if(cnt==12) {
//				break;
//			}
		}
		rs.close();
		pstmt.close();
		conn.close();
		return matziplistByMenu;
	}
	
	public ArrayList<MatzipHashtagDTO> getHashtag() throws Exception {		// 맛집리스트 해시태그
		Connection conn = getConnection();
		ArrayList<MatzipHashtagDTO> matziphashtag = new ArrayList<MatzipHashtagDTO>();
		String sql = "SELECT idx, hashtag FROM matziphashtag ORDER BY idx ASC";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int idx = rs.getInt("idx");
			String hashtag = rs.getString("hashtag");
			MatzipHashtagDTO DTO = new MatzipHashtagDTO(idx, hashtag);
			matziphashtag.add(DTO);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return matziphashtag;
	}
	
	public ArrayList<MatzipListDTO> getMatziplist() throws Exception {		// 맛집리스트 목록
		Connection conn = getConnection();
		ArrayList<MatzipListDTO> matziplist = new ArrayList<MatzipListDTO>();
		String sql = "SELECT restaurant_list, ment, main_img, restaurant_list_idx" + 
				" FROM restaurant_list r" + 
				" ORDER BY restaurant_list_idx DESC";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String restaurant_list = rs.getString("restaurant_list");
			String ment = rs.getString("ment");
			String main_img = rs.getString("main_img");
			int restaurant_list_idx = rs.getInt("restaurant_list_idx");
			MatzipListDTO DTO = new MatzipListDTO(restaurant_list, ment, main_img, restaurant_list_idx);
			matziplist.add(DTO);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return matziplist;
	}

	public ArrayList<MatzipListDTO> getMatziplistWithPaging(int page) throws Exception {		// 맛집리스트 목록
		int startRnum = page * 20 - 19;
		int endRnum = page * 20;
		
		Connection conn = getConnection();
		ArrayList<MatzipListDTO> matziplist = new ArrayList<MatzipListDTO>();
//		String sql = "SELECT restaurant_list, ment, main_img, restaurant_list_idx" + 
//				" FROM restaurant_list r" + 
//				" ORDER BY restaurant_list_idx DESC";
		String sql = "SELECT *"
				+ "	FROM (SELECT rownum rnum, t1.*" 
				+ "	FROM (SELECT r.restaurant_list, r.ment, r.main_img, r.restaurant_list_idx" 
				+ "	FROM restaurant_list r"
				+ "	ORDER BY r.update_date DESC) t1) t2" 
				+ "	WHERE rnum>=? AND rnum<=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, startRnum);
		pstmt.setInt(2, endRnum);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String restaurant_list = rs.getString("restaurant_list");
			String ment = rs.getString("ment");
			String main_img = rs.getString("main_img");
			int restaurant_list_idx = rs.getInt("restaurant_list_idx");
			MatzipListDTO DTO = new MatzipListDTO(restaurant_list, ment, main_img, restaurant_list_idx);
			matziplist.add(DTO);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return matziplist;
	}
	
	public ArrayList<MatzipDetailTopDTO> getMatzipDetailTop(int idx) throws Exception {
		Connection conn = getConnection();
		int pk = idx;
		ArrayList<MatzipDetailTopDTO> matziplistTop = new ArrayList<MatzipDetailTopDTO>();
		String sql = "SELECT r.click, TO_CHAR(r.update_date, 'YYYY-MM-DD') update_date, r.restaurant_list, r.ment" + 
				" FROM restaurant_list r" + 
				" WHERE r.restaurant_list_idx =?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, pk);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			String click = rs.getString("click");
			String update_date = rs.getString("update_date");
			String restaurant_list = rs.getString("restaurant_list");
			String ment = rs.getString("ment");
			MatzipDetailTopDTO DTO = new MatzipDetailTopDTO(click, update_date, restaurant_list, ment);
			matziplistTop.add(DTO);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return matziplistTop;
	}
	
	public ArrayList<MatzipDetailDTO> getMatzipListDetail(int idx) throws Exception {		// 맛집리스트 상세 목록
		Connection conn = getConnection();
		int pk = idx;
		ArrayList<MatzipDetailDTO> matzipdetail = new ArrayList<MatzipDetailDTO>();
		String sql = "SELECT d.main_img, d.plate_id, d.name, d.score, d.street_address," +
				" l.recommended_review, m.member_img, l.member_number, m.member_id, l.restaurant_order, d.latitude, d.longitude," + 
				" d.area, d.type, d.review, d.wish" +
				" FROM details d, restaurant_detailed_list l, member m, restaurant_list r" + 
				" WHERE r.restaurant_list_idx = ?" +
				" AND r.restaurant_list = l.restaurant_list" +
				" AND d.plate_id = l.plate_id" +
				" AND m.member_number = l.member_number" +
				" ORDER BY d.score DESC, l.restaurant_order ASC";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, pk);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String main_img = rs.getString("main_img");
			int plate_id = rs.getInt("plate_id");
			String name = rs.getString("name");
			double score = rs.getDouble("score");
			String street_address = rs.getString("street_address");
			String recommended_review = rs.getString("recommended_review");
			String member_img = rs.getString("member_img");
			int member_number = rs.getInt("member_number");
			String member_id = rs.getString("member_id");
			int restaurant_order = rs.getInt("restaurant_order");
			double latitude = rs.getDouble("latitude");
			double longitude = rs.getDouble("longitude");
			String area = rs.getString("area");
			String type = rs.getString("type");
			int review = rs.getInt("review");
			int wish = rs.getInt("wish");
			MatzipDetailDTO DTO = new MatzipDetailDTO(main_img, plate_id, name, score, street_address, recommended_review, member_img, member_number, member_id, restaurant_order, latitude, longitude, area, type, review, wish);
			matzipdetail.add(DTO);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return matzipdetail;
	}
	
	public ArrayList<MatzipDetailDTO> getMatzipListDetailWithPaging(int idx, int page) throws Exception {		// 맛집리스트 상세 목록 페이징 처리
		Connection conn = getConnection();
		int startRnum = page * 10 - 9;
		int endRnum = page * 10;
		int pk = idx;
		ArrayList<MatzipDetailDTO> matzipdetail = new ArrayList<MatzipDetailDTO>();
		String sql = "SELECT *" + 
				" FROM (SELECT rownum rnum, t1.*" + 
				" FROM (SELECT d.main_img, d.plate_id, d.name, d.score, d.street_address, l.recommended_review, m.member_img, l.member_number," +
				" m.member_id, l.restaurant_order, d.latitude, d.longitude, d.area, d.type, d.review, d.wish" + 
				" FROM details d, restaurant_detailed_list l, member m, restaurant_list r" + 
				" WHERE r.restaurant_list_idx =?" + 
				" AND r.restaurant_list = l.restaurant_list" + 
				" AND d.plate_id = l.plate_id" + 
				" AND m.member_number = l.member_number" + 
				" ORDER BY l.restaurant_order ASC) t1) t2" + 
				" WHERE rnum >=? AND rnum <=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, pk);
		pstmt.setInt(2, startRnum);
		pstmt.setInt(3, endRnum);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String main_img = rs.getString("main_img");
			int plate_id = rs.getInt("plate_id");
			String name = rs.getString("name");
			double score = rs.getDouble("score");
			String street_address = rs.getString("street_address");
			String recommended_review = rs.getString("recommended_review");
			String member_img = rs.getString("member_img");
			int member_number = rs.getInt("member_number");
			String member_id = rs.getString("member_id");
			int restaurant_order = rs.getInt("restaurant_order");
			double latitude = rs.getDouble("latitude");
			double longitude = rs.getDouble("longitude");
			String area = rs.getString("area");
			String type = rs.getString("type");
			int review = rs.getInt("review");
			int wish = rs.getInt("wish");
			MatzipDetailDTO DTO = new MatzipDetailDTO(main_img, plate_id, name, score, street_address, recommended_review, member_img, member_number, member_id, restaurant_order, latitude, longitude, area, type, review, wish);
			matzipdetail.add(DTO);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return matzipdetail;
	}
	
	public ArrayList<MatzipDetailBottomDTO> getMatzipListDetailBottom(int idx) throws Exception {		// 맛집리스트 바텀 식당
		Connection conn = getConnection();
		int pk = idx;
		ArrayList<MatzipDetailBottomDTO> matzipDetailBottom = new ArrayList<MatzipDetailBottomDTO>();
		String sql = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cnt = 0;
		if(pk==119) {		// 119번 인천 서구 식당 두 개 고정
			sql = "SELECT distinct(d.plate_id), d.main_img, d.name, d.score, d.area, d.type" + 
				" FROM details d, restaurant_list r" + 
				" WHERE d.plate_id = 3001 OR d.plate_id = 3002" + 
				" AND r.restaurant_list_idx = ?" + 
				" ORDER BY DBMS_RANDOM.RANDOM";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pk);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int plate_id = rs.getInt("plate_id");
				String main_img = rs.getString("main_img");
				String name = rs.getString("name");
				double score = rs.getDouble("score");
				String area = rs.getString("area");
				String type =rs.getString("type");
				MatzipDetailBottomDTO DTO = new MatzipDetailBottomDTO(plate_id, main_img, name, score, area, type);
				matzipDetailBottom.add(DTO);
			}
			rs.close();
			pstmt.close();
			conn.close();
		}
		
		if(pk==23) {		// 23번 강남역 해장 맛집 4개
			sql = "SELECT d.plate_id, d.main_img, d.name, d.score, d.area, d.type" + 
				" FROM details d, restaurant_list r" + 
				" WHERE d.area = '강남역'" + 
				" AND r.restaurant_list_idx = ?" + 
				" ORDER BY DBMS_RANDOM.RANDOM";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pk);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				cnt++;
				int plate_id = rs.getInt("plate_id");
				String main_img = rs.getString("main_img");
				String name = rs.getString("name");
				double score = rs.getDouble("score");
				String area = rs.getString("area");
				String type =rs.getString("type");
				MatzipDetailBottomDTO DTO = new MatzipDetailBottomDTO(plate_id, main_img, name, score, area, type);
				matzipDetailBottom.add(DTO);
				if(cnt==4) break;
			}
			rs.close();
			pstmt.close();
			conn.close();
		}
		
		if(pk==22) {		// 22번 해장국 맛집 베스트 식당 4개
			sql = "SELECT d.plate_id, d.main_img, d.name, d.score, d.area, d.type" + 
				" FROM details d, restaurant_list r" + 
				" WHERE d.type IN('탕 / 찌개 / 전골', '한정식 / 백반 / 정통 한식', '고기 요리', '해산물 요리')" + 
				" AND r.restaurant_list_idx = ?" + 
				" ORDER BY DBMS_RANDOM.RANDOM";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pk);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				cnt++;
				int plate_id = rs.getInt("plate_id");
				String main_img = rs.getString("main_img");
				String name = rs.getString("name");
				double score = rs.getDouble("score");
				String area = rs.getString("area");
				String type =rs.getString("type");
				MatzipDetailBottomDTO DTO = new MatzipDetailBottomDTO(plate_id, main_img, name, score, area, type);
				matzipDetailBottom.add(DTO);
				if(cnt==4) break;
			}
			rs.close();
			pstmt.close();
			conn.close();
		}
		return matzipDetailBottom;
	}
	
	public MatzipDetailHashtagDTO getMatzipDetailHashtag(int idx) throws Exception {		// 맛집 상세 바텀 인기 키워드
		Connection conn = getConnection();
		int pk = idx;
		String sql = "SELECT realtime_popular_keywords" + 
				" FROM restaurant_list r, restaurant_detailed_list l" + 
				" WHERE restaurant_order = 1" + 
				" AND r.restaurant_list_idx = ?" + 
				" AND r.restaurant_list_idx = l.restaurant_list_idx";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, pk);
		ResultSet rs = pstmt.executeQuery();
		MatzipDetailHashtagDTO DTO = null;
		while(rs.next()) {
			String keyword = rs.getString("realtime_popular_keywords");
			String[] hashtag = {};
			if(keyword!=null) {
				hashtag = keyword.split("//");
			}
			DTO = new MatzipDetailHashtagDTO(hashtag, keyword);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return DTO;
	}
}

