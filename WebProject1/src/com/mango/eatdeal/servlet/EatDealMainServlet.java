package com.mango.eatdeal.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet; 
import java.sql.SQLException;
import java.text.DecimalFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@WebServlet("/EatDealMainServlet")
public class EatDealMainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
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
   

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		System.out.println("servlet들어옴");
		int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		JSONArray jsonArrayList = new JSONArray();
//		ArrayList<Eat_deal_mainDTO> listEatdeal = new ArrayList<Eat_deal_mainDTO>();
		Connection conn = getConnection();
		String sql = "SELECT * FROM (SELECT rownum rnum, t1.*"
				+ " FROM (SELECT name 이름, area 지점, eat_deal_main.menu 메뉴, info 정보, eat_deal_main.price 원가, discount 할인율,"
				+ " eat_deal_main.price-(eat_deal_main.price*(discount/100)) 할인가, main_theme 썸네일, eat_deal_main.neww 뉴, deal_idx"
				+ " FROM eat_deal_main, details WHERE eat_deal_main.plate_id=details.plate_id"
				+ " ORDER BY details.plate_id ) t1) t2  WHERE rnum>=? AND rnum<=?";

		int bnoStart = pageNumber * 20 - 19;
		int bnoEnd = pageNumber * 20;
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
			while (rs.next()) {
				System.out.println("sql담는중");
				JSONObject obj = new JSONObject();
				String name = rs.getString("이름");
				obj.put("name", name);
				String area = rs.getString("지점");
				obj.put("area", area);
				String menu = rs.getString("메뉴");
				obj.put("menu", menu);
				String info = rs.getString("정보");
				obj.put("info", info);
				String price = decFormat.format(Integer.parseInt(rs.getString("원가")));
				obj.put("price", price);
				String discount = rs.getString("할인율");
				obj.put("discount", discount);
				String discounted = decFormat.format(Integer.parseInt(rs.getString("할인가")));
				obj.put("discounted", discounted);
				String main_theme = rs.getString("썸네일");
				obj.put("main_theme", main_theme);
				int neww = rs.getInt("뉴");
				obj.put("neww", neww);
				int dealIdx = rs.getInt("deal_idx");
				obj.put("dealIdx", dealIdx);
				jsonArrayList.add(obj);
				/*
				 * listEatdeal.add(new Eat_deal_mainDTO(name, area, menu, info, price, discount,
				 * discounted, main_theme, neww));
				 */
				
				System.out.println("들어옴"+obj);
			}
			System.out.println(jsonArrayList.size());
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
			try {
				if(conn != null)
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		PrintWriter out = response.getWriter();
		out.println(jsonArrayList);
		
		
		
		
	
		

	}
		
		
		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
		
		
	
	}

}
