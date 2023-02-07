package com.mango.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import com.mango.dto.MangoContentInStoryListDto;
import com.mango.dto.MangoContentViewMoreListDto;
import com.mango.dto.MangoStoryDetailContentDto;
import com.mango.dto.MangoStoryDetailDto;

public class MangoStoryContentDao2 {
	private Connection getConnection()  {
		Connection conn = null;

		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@203.245.30.223:1521:xe";
		String dbID = "mango";
		String dbPW = "1234";
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,dbID,dbPW);
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	public MangoStoryDetailDto getDetailMangoFromStoryId(int storyIdNumber)  {
		MangoStoryDetailDto detailMango = null;
		
		Connection conn = getConnection();
//System.out.println("(MangoContentDao2.java) storyIdNumber : " + storyIdNumber);		
		String sql = "SELECT * FROM story_main sm, member m WHERE sm.member_number=m.member_number AND story_id=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, storyIdNumber);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String main_img = rs.getString("main_img");
				String main_source = rs.getString("main_source");
				String member_id = rs.getString("member_id");
				String story_title = rs.getString("story_title");
				String story_subtitle = rs.getString("story_subtitle");
				String write_date = rs.getString("write_date");
				String hitcount = rs.getString("hitcount");
				String gif_img1 = rs.getString("gif_img1");
				String gif_source1 = rs.getString("gif_source1");
				String gif_text1 = rs.getString("gif_text1");
				
				PreparedStatement pstmt2 = null;
				ResultSet rs2 = null;
				
				ArrayList<MangoStoryDetailContentDto> listContent = new ArrayList<MangoStoryDetailContentDto>();
				String sql2 = "SELECT * FROM story_content WHERE story_id = ? ORDER BY plate_order";
				try {
					pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setInt(1, storyIdNumber);
					rs2 = pstmt2.executeQuery();
					while(rs2.next()) {
						String plate_name = rs2.getString("plate_name");
						String content_img1 = rs2.getString("content_img1");
						String img_source1 = rs2.getString("img_source1");
						String content_text1 = rs2.getString("content_text1");
						String content_img2 = rs2.getString("content_img2");
						String img_source2 = rs2.getString("img_source2");
						String content_text2 = rs2.getString("content_text2");
						listContent.add( new MangoStoryDetailContentDto(plate_name, content_img1, img_source1, content_text1, content_img2, img_source2, content_text2) );
					}
				} catch(SQLException e) {
					e.printStackTrace();
				} finally {
					try {
						if(rs2!=null)
							rs2.close();
					} catch(SQLException e){
						e.printStackTrace();
					} try {
						if(pstmt2!=null)
						pstmt2.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				String gif_img2 = rs.getString("gif_img2");
				String gif_source2 = rs.getString("gif_source2");
				String gif_text2 = rs.getString("gif_text2");
				MangoStoryDetailDto dto2 = new MangoStoryDetailDto(main_img,main_source,member_id,story_title,story_subtitle,write_date,hitcount,
						gif_img1,gif_source1,gif_text1,listContent,gif_img2,gif_source2,gif_text2);
				//detailMango.add(vo2);
				detailMango = dto2;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null)
				rs.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		//System.out.println(detailMango);
		//for(int i=0; i<=detailMango.size()-1; i++) {
		//	System.out.println("["+(i+1)+"]" + detailMango.get(i));
		//}
		return detailMango;
	}

	public int getPlateIdFromPlateName(String name) throws Exception {
		String sql = "SELECT plate_id FROM details WHERE name=?";
		int ret = 0;
		Connection conn = getConnection();
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, name);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			ret = rs.getInt("plate_id");
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
	public boolean getWishFromMemberNumberAndPlateId(int memberNumber, int plateId) throws Exception {
		Connection conn = getConnection();
		
		boolean result = false;   // result는 리턴할 값.(true이면 wish를 누른 상태) false : 그냥 초기값.
		String sql = "SELECT count(*) FROM wish" +
					" WHERE member_number=? AND plate_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, memberNumber);
		pstmt.setInt(2, plateId);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			int cnt = rs.getInt(1);
			if(cnt>1) System.out.println("WARNING! 이상해! getWishFromMemberNumberAndPlateId()에서 cnt:"+cnt);
			if(cnt==1) 
				result = true;
			else 
				result = false;
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	private int getPlateIdWithAreaName(String region, String name) throws Exception {
		Connection conn = getConnection();
		
		int plateId = 0;
		region = region.replace("//", "/").replace("/", " ");
		String[] arr = region.split(" ");
		String sql = "SELECT plate_id FROM details WHERE name=? ";
		for(int i=0; i<=arr.length-1; i++) {
			sql += "AND area LIKE ? ";
		}
//System.out.println("(name:"+name+")sql : " + sql);
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			for(int i=0; i<=arr.length-1; i++) {
				pstmt.setString(2+i, "%"+arr[i]+"%");     // "%인천%"
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				plateId = rs.getInt(1);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		rs.close();
		pstmt.close();
		conn.close();

		return plateId;	
	}
	
	public ArrayList<MangoContentInStoryListDto> getInStoryListFromStoryId(int storyId, int memberNumber) throws Exception {
		Connection conn = getConnection();
		ArrayList<MangoContentInStoryListDto> listInStoryDto = new ArrayList<MangoContentInStoryListDto>();
		
		String sql = "SELECT sc.content_img1, sc.plate_name" + 
				" FROM story_content sc" + 
				" WHERE sc.story_id = ?" + 
				" ORDER BY sc.plate_order";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, storyId);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			String contentImg1 = rs.getString("content_img1");
			String plateName = rs.getString("plate_name");
			
//plateName = plateName.replace("_", " ");

System.out.println("plateName : " + plateName);
			String area = plateName.split("_")[0];
			String purePlateName = plateName.split("_")[1];
System.out.println("area : " + area);
System.out.println("purePlateName : " + purePlateName);
			int plateId = getPlateIdWithAreaName(area, purePlateName);
			boolean wish = getWishFromMemberNumberAndPlateId(memberNumber, plateId);			
			MangoContentInStoryListDto dto = new MangoContentInStoryListDto(plateId, area, purePlateName, contentImg1, wish);
			listInStoryDto.add(dto);
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return listInStoryDto;
	}
	
	public ArrayList<MangoContentViewMoreListDto> getListViewMoreMangoFromStoryId(int storyIdNumber) throws Exception {
		Connection conn = getConnection();
		ArrayList<MangoContentViewMoreListDto> listViewMoreDto = new ArrayList<MangoContentViewMoreListDto>();
		
		String sql = "SELECT *" + 
					" FROM (SELECT rownum rnum, t1.*" + 
					" FROM (SELECT sl.story_id, sm.story_title, sm.main_img" + 
					" FROM story_list sl, story_main sm" + 
					" WHERE sl.story_id = sm.story_id " + 
					" AND sm.story_id != ?" + 
					" ORDER BY sm.write_date DESC) t1) t2" + 
					" WHERE rnum >= 1  AND rnum <= 6";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, storyIdNumber);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int rnum = rs.getInt("rnum");
			int story_id = rs.getInt("story_id");
			String story_title = rs.getString("story_title");
			String main_img = rs.getString("main_img");
			listViewMoreDto.add(new MangoContentViewMoreListDto(rnum, story_id, story_title, main_img));
		}
		rs.close();
		pstmt.close();
		conn.close();
		
		return listViewMoreDto;
	}
}
