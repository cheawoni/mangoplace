package com.mango.eatdeal.servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/joinMemberServlet")
public class joinMemberServlet extends HttpServlet {
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

	public boolean joining(String email) {
		
		boolean check = false;
		Connection conn = getConnection();
		String sql = "SELECT * FROM member_table where email=?"; // 이메일로 조회해서 체크

			PreparedStatement pstmt = null;
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, email);
				pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}

			ResultSet rs = null;
			String logInEmail = null;
			try {
				rs = pstmt.executeQuery();

				if (rs.next()) {
					logInEmail = rs.getString("email");
				}
				if (logInEmail != null) {
					System.out.println("중복된 이메일입니다.\n다시 입력해주세요.");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			if (logInEmail == null) {
				System.out.println("<사용하실 수 있는 이메일입니다.>");
				check = true;
			}
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
		
		return check;
	}
	
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("서블릿 들어옴");
	String email = request.getParameter("email");
		
		
	boolean result = joining(email);
	response.setContentType("application/json");
	response.setCharacterEncoding("UTF-8");
	PrintWriter out = response.getWriter();
	out.println(result);
		
	}


}
