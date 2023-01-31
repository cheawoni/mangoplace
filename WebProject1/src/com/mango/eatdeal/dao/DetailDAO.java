package com.mango.eatdeal.dao;

import java.sql.*;
import java.text.DecimalFormat;
import java.util.*;

import com.mango.eatdeal.dao.*;
import com.mango.eatdeal.dto.*;

public class DetailDAO {
	
	private Connection getConnection() {
		Connection conn = null;
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
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

	public ArrayList<DetailDTO> getDetail(String searchMenu) {
		Connection conn = getConnection();
		ArrayList<DetailDTO> detailList = new ArrayList<DetailDTO>();
		String sql = "SELECT name 이름, area 지점, eat_deal_main.menu 메뉴, info 정보, eat_deal_main.price 원가, discount 할인율,"
				+ " eat_deal_main.price-(eat_deal_main.price*(discount/100)) 할인가,"
				+ " eat_detail_table.ment 식당소개, eat_detail_table.menu2 메뉴소개, eat_deal_main.main_theme 메뉴이미지"
				+ " FROM eat_deal_main, details, eat_detail_table"
				+ " WHERE eat_deal_main.plate_id=details.plate_id"
				+ " AND eat_deal_main.plate_id = eat_detail_table.plate_id"
				+ " AND eat_deal_main.deal_idx=eat_detail_table.deal_idx AND eat_deal_main.deal_idx = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DecimalFormat decFormat = new DecimalFormat("###,###");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchMenu);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String name = rs.getString("이름");
				String area = rs.getString("지점");
				String menu = rs.getString("메뉴");
				String info = rs.getString("정보");
				String price = decFormat.format(Integer.parseInt(rs.getString("원가")));
				String discount = rs.getString("할인율");
				String discounted = decFormat.format(Integer.parseInt(rs.getString("할인가")));
				String rsInfo = rs.getString("식당소개");
				String menuInfo = rs.getString("메뉴소개");
				String menuImg = rs.getString("메뉴이미지");
				System.out.println(name + "/" + area + "/" + menu + "/" + info + "/" + price + "/" + discount + "/"
						+ discounted + "/" + rsInfo + "/" + menuInfo + "/" + menuImg);
				detailList.add(new DetailDTO(name, area, menu, info, price, discount, discounted, rsInfo, menuInfo, menuImg));
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
			}try {
				if(conn!=null)
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return detailList;
	}

}
