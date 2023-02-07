package com.mango.details.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;

import com.mango.details.dto.MenuDTO;
import com.mango.details.dto.mangoDetailsDTO;
import com.mango.details.dto.mangoDetailsMenuDTO;
import com.mango.details.dto.mangoDetailsNearDTO;
import com.mango.details.dto.mangoDetailsRelatedDTO;
import com.mango.details.dto.mangoDetailsRelatedStoryDTO;
import com.mango.details.dto.mangoDetailsRelatedTopDTO;
import com.mango.details.dto.mangoDetailsTopReviewDTO;
import com.mango.details.dto.mangoReviewDTO;
import com.mango.details.dto.mangoReviewDetailDTO;
import com.mango.details.dto.mangoReviewInsertDTO;

public class mangoDetailsDAO {
	private Connection getConnection() {
		
		Connection conn = null;
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@203.245.30.223:1521:xe";
		String dbID = "mango";
		String dbPW = "1234";
		
		try {
			Class.forName(driver);
		    conn = DriverManager.getConnection(url,dbID,dbPW);
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {	
			return conn;
		}
	}
	
	public mangoDetailsDTO getBoardDetailByBno(int pk) {
		int plate = pk;
		DecimalFormat decFormat = new DecimalFormat("###,###");
		String sql = "SELECT d.plate_id, d.name, d.main_img, d.branch, d.score, d.hitcount, d.review, d.wish, d.area,"
				+ " d.street_address, d.jibun_address, d.phone_number, d.type, d.price, d.parking, d.business_hour, d.break_time, d.last_order,"
				+ " d.day_off, d.webpage, d.menu, (TO_CHAR (d.update_date,'YYYY.MM.DD'))update_date, d.latitude, d.longitude, d.hashtag"
				+ " FROM details d, detail_menu_img dm"
				+ " WHERE d.plate_id = dm.plate_id(+)"
				+ " AND d.plate_id = ?"
				+ " ORDER BY d.plate_id";
		Connection conn = getConnection();
		mangoDetailsDTO dto = null;
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, plate);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int id = rs.getInt("plate_id");
				String name = rs.getString("name");
				String main_img = rs.getString("main_img");
				String branch = rs.getString("branch");
				double score = rs.getDouble("score");
				int hitcount = rs.getInt("hitcount");
				String hitcount2 = decFormat.format(hitcount);
				int review = rs.getInt("review");
				String review2 = decFormat.format(review);
				int wish = rs.getInt("wish");
				String wish2 = decFormat.format(wish);
				String area = rs.getString("area");
				String stAddress = rs.getString("street_address");
				String jibunAddress = rs.getString("jibun_address");
				String phoneNum = rs.getString("phone_number");
				String type = rs.getString("type");
				String price = rs.getString("price");
				String parking = rs.getString("parking");
				String businessHour = rs.getString("business_hour");
				String breakTime = rs.getString("break_time");
				String lastOrder = rs.getString("last_order");
				String dayOff = rs.getString("day_off");
				String webpage = rs.getString("webpage");
				String menu = rs.getString("menu");
				String updateDate = rs.getString("update_date");
				double latitude = rs.getDouble("latitude");
				double longitude = rs.getDouble("longitude");
				String hashtag = rs.getString("hashtag");
				String[] hashtagArr = {};
				if(hashtag != null) {
					hashtagArr = hashtag.split("//");
				}

				dto = new mangoDetailsDTO(id, name, main_img, branch, score, hitcount, hitcount2, review, review2, wish, wish2, area, stAddress, jibunAddress, phoneNum, type, price, parking, businessHour, breakTime, lastOrder, dayOff, webpage, menu, updateDate, latitude, longitude, hashtag, hashtagArr);
			}
	
		} catch(SQLException e) {
			System.out.println("예외: sql문");
		} finally {
			try {
				if(rs !=null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {	
				if(pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {	
				if(conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return dto;
	}
	
	
	public ArrayList<mangoDetailsMenuDTO>getMenuContent(int pk) {
		Connection conn = getConnection();
		ArrayList<mangoDetailsMenuDTO> menuImgList = new ArrayList<mangoDetailsMenuDTO>();
		int plate = pk;
		String sql = "SELECT dm.menu_img, coment,(TO_CHAR (dm.update_date2,'YYYY.MM.DD'))update_date2"
				+ " FROM detail_menu_img dm, details d"
				+ " WHERE dm.plate_id(+) = d.plate_id"
				+ " AND d.plate_id = ?"
				+ " ORDER BY update_date2 DESC";
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, plate);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String menuImg = rs.getString("menu_img");
				String coment = rs.getString("coment");
				String updateDate2 = rs.getString("update_date2");
			
				menuImgList.add( new mangoDetailsMenuDTO(menuImg, coment, updateDate2));
			}
			
		}catch(Exception e) {
			System.out.println(" SQL문 예외처리 ");
		}finally {
			try {
				if(rs!=null)
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if(pstmt!=null)
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if(conn!=null)
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		return menuImgList;
	}
	
	public ArrayList<MenuDTO> getMenuList(int pk) throws Exception { 
		
		Connection conn = getConnection();
		DecimalFormat decFormat = new DecimalFormat("###,###");
		ArrayList<MenuDTO> menuList =  new ArrayList<MenuDTO>();
		int plate = pk;
		String sql = "SELECT menu FROM details WHERE plate_id = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,plate);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()){
			String menu = rs.getString("menu");
			String[] arr = {};
			if(menu!=null) {
				arr = menu.split("//");
			}
			for(int i=0; i<=arr.length-1; i+=2) {
				String menuName = arr[i];
				int mprice = Integer.parseInt(arr[i+1]);
				String menuPrice = decFormat.format(mprice);
				menuList.add( new MenuDTO(menuName, menuPrice) );
			}
		}
		rs.close();
		pstmt.close();
		conn.close();
		return menuList;
	}
	public ArrayList<mangoReviewDTO> getDetailReviewBoard(int pk,int page){
		Connection conn = getConnection();
		int plate = pk; 
		int pageNumber = page;
		int idxStart = pageNumber * 5 - 4;
		int idxEnd = pageNumber * 5;
		ArrayList<mangoReviewDTO> reviewList = new ArrayList<mangoReviewDTO>();
		String sql = "SELECT *"
				+ " FROM (SELECT rownum rnum, t1.*"
				+ " FROM (SELECT m.member_id, m.holic, m.member_img, m.member_writecount, m.member_followcount, r.plate_id, r.review_idx, r.member_number, r.review_img, r.review_coment, r.write_date, r.tasty_like"
				+ " FROM details d, reviews r ,member m"
				+ " WHERE d.plate_id = r.plate_id"
				+ " AND m.member_number = r.member_number"
				+ " AND d.plate_id = ?"
				+ " ORDER BY r.write_date DESC) t1) t2"
				+ " WHERE rnum>=? AND rnum<=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, plate);
			pstmt.setInt(2, idxStart);
			pstmt.setInt(3, idxEnd);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String memberImg = rs.getString("member_img");
				String name = rs.getString("member_id");
				int writeCount = rs.getInt("member_writecount");
				int followCount = rs.getInt("member_followcount"); 
				int holic = rs.getInt("holic");
				Date writedate = rs.getDate("write_date");
				String coment = rs.getString("review_coment");
				String img = rs.getString("review_img");
				String[] imgNum = {};
				if(img != null) {
					imgNum = img.split("//");
				}
				int tasty = rs.getInt("tasty_like");
				int id = rs.getInt("plate_id");
				int idx = rs.getInt("review_idx");
				int member = rs.getInt("member_number");
				
				reviewList.add( new mangoReviewDTO(memberImg, name, writeCount, followCount, holic, writedate, coment, img, imgNum, tasty, id, idx, member));
			}

		}catch(SQLException e) {
			System.out.println(" SQL문 예외처리 ");
		} finally {
			try {
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				System.out.println(" SQL문 예외처리 ");
			}
			try {
				if(pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				System.out.println(" SQL문 예외처리 ");
			}
			try {
				if(conn != null)
					conn.close();
			} catch (SQLException e) {
				System.out.println(" SQL문 예외처리 ");
			}
		}
		return reviewList;
	}//review
	
	public mangoReviewDetailDTO getReviewDetail(int pk, int number) {
		int plate = pk;
		int mNumber = number;
		String sql = "SELECT d.name, d.area, m.member_id, m.member_img, m.member_writecount, m.member_followcount, r.review_idx, r.plate_id, r.member_number, r.review_img, r.review_coment, (TO_CHAR (r.write_date,'YYYY-MM-DD'))write_date, r.tasty_like"
				+ " FROM reviews r, details d, member m WHERE r.plate_id = d.plate_id"
				+ " AND r.member_number = m.member_number"
				+ " AND r.plate_id = ?"
				+ " AND r.member_number = ?";
		mangoReviewDetailDTO dto = null;
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, plate);
			pstmt.setInt(2, mNumber);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String name = rs.getString("name");
				String area = rs.getString("area");
				String memberName = rs.getString("member_id");
				String memberImg = rs.getString("member_img");
				int memberWriteCount = rs.getInt("member_writecount");
				int memberFollowCount = rs.getInt("member_followcount");
				int idx = rs.getInt("review_idx");
				int id = rs.getInt("plate_id");
				int memberNumber = rs.getInt("member_number");
				String imgNum = rs.getString("review_img");
				String[] img = {};
				if(imgNum != null) {
					img = imgNum.split("//");
				}
				String coment = rs.getString("review_coment");
				String writeDate = rs.getString("write_date");
				int tasty = rs.getInt("tasty_like");
				
				dto = new mangoReviewDetailDTO(name, area, memberName, memberImg, memberWriteCount, memberFollowCount, idx, id, memberNumber, img, coment, writeDate, tasty);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null)
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if(pstmt != null)
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if(conn != null)
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return dto;
	}
	public ArrayList<mangoDetailsTopReviewDTO> getDetailsTopReview(int pk){
		Connection conn = getConnection();
		int plate = pk; 
		ArrayList<mangoDetailsTopReviewDTO> topReviewList = new ArrayList<mangoDetailsTopReviewDTO>();
		String sql = "SELECT d.name, m.member_id, m.member_img, m.member_writecount, m.member_followcount, r.review_idx, r.plate_id, r.member_number, r.review_img, r.review_coment, (TO_CHAR (r.write_date,'YYYY-MM-DD'))write_date, r.tasty_like"
				+ " FROM reviews r,details d, member m"
				+ " WHERE r.plate_id = d.plate_id"
				+ " AND r.member_number = m.member_number"
				+ " AND r.plate_id = ?"
				+ " ORDER BY r.write_date DESC";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, plate);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String name = rs.getString("name");
				String memberName = rs.getString("member_id");
				String memberImg = rs.getString("member_img");
				int memberWriteCount = rs.getInt("member_writecount");
				int memberFollowCount = rs.getInt("member_followcount");
				int idx = rs.getInt("review_idx");
				int id = rs.getInt("plate_id");
				int memberNumber = rs.getInt("member_number");
				String img = rs.getString("review_img");
				String[] imgNum = {};
				if(img != null) {
					imgNum = img.split("//");
				}
				String coment = rs.getString("review_coment");
				String writeDate = rs.getString("write_date");
				int tasty = rs.getInt("tasty_like");
				
				topReviewList.add(new mangoDetailsTopReviewDTO(name, memberName, memberImg, memberWriteCount, memberFollowCount, idx, id, memberNumber, img, imgNum, coment, writeDate, tasty));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				System.out.println(" SQL문 예외처리 ");
			}
			try {
				if(pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				System.out.println(" SQL문 예외처리 ");
			}
			try {
				if(conn != null)
					conn.close();
			} catch (SQLException e) {
				System.out.println(" SQL문 예외처리 ");
			}
		}
		return topReviewList;
	}
	public ArrayList<mangoReviewDTO> getDetailReviewTasty(int pk,int page,int tastyLike){
		Connection conn = getConnection();
		int plate = pk; 
		int pageNumber = page;
		int tLike = tastyLike;
		int idxStart = pageNumber * 5 - 4;
		int idxEnd = pageNumber * 5;
		ArrayList<mangoReviewDTO> tastyList = new ArrayList<mangoReviewDTO>();
		String sql = "SELECT *"
				+ " FROM (SELECT rownum rnum, t1.*"
				+ " FROM (SELECT m.member_id, m.holic, m.member_img, m.member_writecount, m.member_followcount, r.plate_id, r.review_idx, r.member_number, r.review_img, r.review_coment, r.write_date, r.tasty_like"
				+ " FROM details d, reviews r ,member m"
				+ " WHERE d.plate_id = r.plate_id"
				+ " AND m.member_number = r.member_number"
				+ " AND d.plate_id = ?"
				+ " AND r.tasty_like = ?"
				+ " ORDER BY r.write_date DESC) t1) t2"
				+ " WHERE rnum>=? AND rnum<=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, plate);
			pstmt.setInt(2, tLike);
			pstmt.setInt(3, idxStart);
			pstmt.setInt(4, idxEnd);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String memberImg = rs.getString("member_img");
				String name = rs.getString("member_id");
				int writeCount = rs.getInt("member_writecount");
				int followCount = rs.getInt("member_followcount"); 
				int holic = rs.getInt("holic");
				Date writedate = rs.getDate("write_date");
				String coment = rs.getString("review_coment");
				String img = rs.getString("review_img");
				String[] imgNum = {};
				if(img != null) {
					imgNum = img.split("//");
				}
				int tasty = rs.getInt("tasty_like");
				int id = rs.getInt("plate_id");
				int idx = rs.getInt("review_idx");
				int member = rs.getInt("member_number");
				
				tastyList.add( new mangoReviewDTO(memberImg, name, writeCount, followCount, holic, writedate, coment, img, imgNum, tasty, id, idx, member));
			}
			
		}catch(SQLException e) {
			System.out.println(" SQL문 예외처리 ");
		} finally {
			try {
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				System.out.println(" SQL문 예외처리 ");
			}
			try {
				if(pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				System.out.println(" SQL문 예외처리 ");
			}
			try {
				if(conn != null)
					conn.close();
			} catch (SQLException e) {
				System.out.println(" SQL문 예외처리 ");
			}
		}
		return tastyList;
	}//review
	
	public ArrayList<Integer> getReviewCount(int pk) {
		int plate = pk;
		String sql = "SELECT tasty_like FROM reviews WHERE plate_id = ?";
		ArrayList<Integer> list = new ArrayList<Integer>();
		Connection conn = getConnection();
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, plate);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int tasty = rs.getInt("tasty_like");
				list.add( new Integer(tasty));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null)
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if(pstmt != null)
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if(conn != null)
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	public ArrayList<mangoDetailsRelatedDTO> getRelatedRestaurant(int pk) {
		int plate = pk;
		int list_idx = 0;
		String sql = " SELECT max(r.restaurant_list_idx)"
				+ " FROM restaurant_list r, restaurant_detailed_list rd, details d"
				+ " WHERE d.plate_id = rd.plate_id"
				+ " AND r.restaurant_list_idx = rd.restaurant_list_idx"
				+ " AND d.plate_id = ?"
				+ " AND rd.restaurant_order BETWEEN 1 AND 4";
		Connection conn = getConnection();
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, plate);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int idx = rs.getInt("max(r.restaurant_list_idx)");
				list_idx = idx;
			}
	
		} catch(SQLException e) {
			System.out.println("예외: sql문");
		} finally {
			try {
				if(rs !=null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if(pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		ArrayList<mangoDetailsRelatedDTO> relatedList = new ArrayList<mangoDetailsRelatedDTO>();
		String sql2 ="SELECT *"
				+ " FROM(SELECT rownum rnum, t1.*"
				+ " FROM(SELECT r.restaurant_list,r.restaurant_list_idx, d.main_img, d.plate_id, d.name, d.score, d.area, d.type"
				+ " FROM restaurant_list r, restaurant_detailed_list rd, details d"
				+ " WHERE d.plate_id = rd.plate_id"
				+ " AND r.restaurant_list_idx = rd.restaurant_list_idx"
				+ " AND rd.restaurant_list_idx = ?"
				+ " ORDER BY rd.restaurant_order ASC)t1)t2"
			 	+ " WHERE rnum>=1 AND rnum<=4";
		PreparedStatement pstmt2 = null; 
		ResultSet rs2 = null; 
		try {
			 pstmt2 =conn.prepareStatement(sql2); 
			 pstmt2.setInt(1, list_idx); 
			 rs2 = pstmt2.executeQuery();
			while(rs2.next()) {
				String r_list = rs2.getString("restaurant_list");
				int r_idx = rs2.getInt("restaurant_list_idx");
				String img = rs2.getString("main_img");
				int id = rs2.getInt("plate_id");
				String name = rs2.getString("name");
				double score = rs2.getDouble("score");
				String area = rs2.getString("area");
				String type = rs2.getString("type");
				relatedList.add( new mangoDetailsRelatedDTO(r_list, r_idx, img, id, name, score, area, type));
			}
	
		} catch(SQLException e) {
			System.out.println("예외: sql문");
		} finally {
			try {
				if(rs2 !=null)
					rs2.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if(pstmt2 != null)
					pstmt2.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {	
				if(conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return relatedList;
	}
	public ArrayList<mangoDetailsRelatedTopDTO> getRelatedRestaurantTop(int pk) {
		int plate = pk;
		String sql = "SELECT *"
				+ " FROM(SELECT rownum rnum, t1.*"
				+ " FROM(SELECT r.restaurant_list, r.ment,r.main_img"
				+ " FROM restaurant_list r, restaurant_detailed_list rd, details d"
				+ " WHERE d.plate_id = rd.plate_id"
				+ " AND r.restaurant_list_idx = rd.restaurant_list_idx"
				+ " AND d.plate_id = ?"
				+ " AND rd.restaurant_order BETWEEN 1 AND 4"
				+ " ORDER BY DBMS_RANDOM.RANDOM)t1)t2"
				+ " WHERE rnum>=1 AND rnum<=4";
		ArrayList<mangoDetailsRelatedTopDTO> topList = new ArrayList<mangoDetailsRelatedTopDTO>();
		Connection conn = getConnection();
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, plate);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String title = rs.getString("restaurant_list");
				String ment = rs.getString("ment");
				String img = rs.getString("main_img");
				topList.add(new mangoDetailsRelatedTopDTO(title, ment, img));
			}
			
		} catch(SQLException e) {
			System.out.println("예외: sql문");
		} finally {
			try {
				if(rs !=null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if(pstmt != null)
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
		return topList;
	}
	
	public ArrayList<mangoDetailsRelatedStoryDTO> getRelatedStory(int pk) {
		int plate = pk;
		String d_Name = "";
		String sql = "SELECT name FROM details WHERE plate_id = ?";
		Connection conn = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, plate);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String name = rs.getString("name");
				d_Name = name;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				rs.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			try {
				pstmt.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		
		ArrayList<mangoDetailsRelatedStoryDTO> storyList = new ArrayList<mangoDetailsRelatedStoryDTO>();
		String sql2 = "SELECT sc.plate_name, sm.story_title, sm.story_subtitle, sm.main_img"
				+ " FROM story_content sc, story_main sm"
				+ " WHERE sc.story_id = sm.story_id"
				+ " AND sc.plate_name LIKE '%"+d_Name+"'"
				+ " ORDER BY sm.write_date DESC";
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		
		try {
			pstmt2 = conn.prepareStatement(sql2);
			rs2 = pstmt2.executeQuery();
			while(rs2.next()) {
				String name = rs2.getString("plate_name");
				String title = rs2.getString("story_title");
				String subTitle = rs2.getString("story_subtitle");
				String img = rs2.getString("main_img");
				storyList.add(new mangoDetailsRelatedStoryDTO(name, title, subTitle, img));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				rs2.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				pstmt2.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return storyList;
	}
	public ArrayList<mangoDetailsNearDTO> getNearbyPopularRestaurants (int pk) {
		int plate = pk;
		Connection conn = getConnection();
		ArrayList<mangoDetailsNearDTO> nearList = new ArrayList<mangoDetailsNearDTO>();
		String sql = "SELECT plate_id,main_img,name,score,type,area,price, SQRT(POWER(latitude-(SELECT latitude 위도 FROM details WHERE plate_id=?),2)"
				+ " +POWER(longitude-(SELECT longitude 경도 FROM details WHERE plate_id=?),2)) dist"
				+ " FROM details"
				+ " WHERE plate_id!=?"
				+ " AND SCORE >= 3.7"
				+ " ORDER BY dist";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, plate);
			pstmt.setInt(2, plate);
			pstmt.setInt(3, plate);
			rs = pstmt.executeQuery();
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				int id = rs.getInt("plate_id");
				String mainImg = rs.getString("main_img");
				String name = rs.getString("name");
				double score = rs.getDouble("score");
				String type = rs.getString("type");
				String area = rs.getString("area");
				String price = rs.getString("price");
				double dist = rs.getDouble("dist");
				nearList.add( new mangoDetailsNearDTO(id,mainImg,name,score,type,area,price,dist));
				if(cnt == 4) {
					break;
				}
			}
		}catch(SQLException e) {
			System.out.println(" SQL문 예외처리 ");
		}finally {
			try {
				if(rs != null)
					rs.close();
			} catch (SQLException e) {
				System.out.println(" SQL문 예외처리 ");
			}
			try {
				if(pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				System.out.println(" SQL문 예외처리 ");
			}
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return nearList;
	}//NearbyPoupularRestaurants
	public void  insertReview(mangoReviewInsertDTO dto) {
		Connection conn = getConnection();
		
		String sql = "INSERT INTO reviews(review_idx, plate_id, member_number, review_img, review_coment, tasty_like) "
				+ " VALUES(REVIEWS_SEQ.nextval, ?,(SELECT member_number FROM member m  WHERE m.email = ?),?,?,?)";
		
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,dto.getId());
			pstmt.setString(2,dto.getEmail());
			pstmt.setString(3,dto.getImg());
			pstmt.setString(4,dto.getReview());
			pstmt.setInt(5,dto.getTasty());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null)
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if(conn != null)
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
