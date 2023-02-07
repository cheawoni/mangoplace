package com.mango.eatdeal.dao;

import java.sql.*;

import com.mango.eatdeal.dto.JoinDTO;

public class JoinDAO {

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

	public void insertmember(JoinDTO dto) throws Exception {
		Connection conn = getConnection();
		String sql = "INSERT INTO member(member_number, member_id, email, password, phone )"
				+ " VALUES (member_seq.nextval, ?, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getMember_id());
		pstmt.setString(2, dto.getEmail());
		pstmt.setString(3, dto.getPassword());
		pstmt.setString(4, dto.getPhone());
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
	}
	
	public boolean loginCheck(String email, String passw) throws Exception {
		Connection conn = getConnection();
		String sql = "SELECT count(*) FROM member WHERE email=? AND password=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, email);
		pstmt.setString(2, passw);
		ResultSet rs = pstmt.executeQuery();
		int cnt = 0;
		if(rs.next()) {
			cnt = rs.getInt(1);
			
		}

		rs.close();
		pstmt.close();
		conn.close();
		if(cnt==1) {
			return true;
		}
		return false;
		
	}
	
	
}
