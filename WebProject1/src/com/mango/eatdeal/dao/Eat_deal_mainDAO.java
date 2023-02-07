package com.mango.eatdeal.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;

import com.mango.eatdeal.dao.*;
import com.mango.eatdeal.dto.*;

public class Eat_deal_mainDAO {
	int cnt = 0;
	private Connection getConnection() {
		Connection conn = null;
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@203.245.30.223:1521:xe";
		String dbId = "mango";
		String dbPw = "1234";
		
		try {
			Class.forName(driver);
			System.out.println("JDBC 드라이버 로딩 성공");
			conn = DriverManager.getConnection(url, dbId, dbPw);
			System.out.println("접속성공");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("오라클 접속 실패");
		}
		return conn;
	}
	
	public ArrayList<Eat_deal_mainDTO> getAllEatdealList() throws Exception {
		Connection conn = getConnection();
		ArrayList<Eat_deal_mainDTO> listEatdeal = new ArrayList<Eat_deal_mainDTO>();
		String sql = "SELECT * FROM (SELECT rownum rnum, t1.*"
				+ " FROM (SELECT name 이름, area 지점, eat_deal_main.menu 메뉴, info 정보, eat_deal_main.price 원가, discount 할인율,"
				+ " eat_deal_main.price-(eat_deal_main.price*(discount/100)) 할인가, main_theme 썸네일, eat_deal_main.neww 뉴, deal_idx"
				+ " FROM eat_deal_main, details WHERE eat_deal_main.plate_id=details.plate_id"
				+ " ORDER BY details.plate_id ) t1) t2  WHERE rnum>=? AND rnum<=?";

		int bnoStart = 1 * 20 - 19;
		int bnoEnd = 1 * 20;
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bnoStart);
			pstmt.setInt(2, bnoEnd);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		ResultSet rs = null;
		DecimalFormat decFormat = new DecimalFormat("###,###");
		
		
		try {
			rs = pstmt.executeQuery();
			cnt=0;
			while (rs.next()) {
				String name = rs.getString("이름");
				String area = rs.getString("지점");
				String menu = rs.getString("메뉴");
				String info = rs.getString("정보");
				String price = decFormat.format(Integer.parseInt(rs.getString("원가")));
				String discount = rs.getString("할인율");
				String discounted = decFormat.format(Integer.parseInt(rs.getString("할인가")));
				String main_theme = rs.getString("썸네일");
				int neww = rs.getInt("뉴");
				int dealIdx = rs.getInt("deal_idx");
				listEatdeal.add(new Eat_deal_mainDTO(name, area, menu, info, price, discount, discounted, main_theme, neww, dealIdx));
				cnt++;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		conn.close();
		return listEatdeal;
		
		
		
		
		
	}
	public int cnt2() {
		return cnt;
	}
	
	
	
}
