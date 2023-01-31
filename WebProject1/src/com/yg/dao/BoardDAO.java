package com.yg.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.yg.dto.BoardDTO;
import com.yg.dto.BoardDetailDTO;

public class BoardDAO {
	private Connection getConnection() {
		Connection conn = null;
				
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbId = "test1017";
		String dbPw = "1234";
		
		try {
			Class.forName(driver);
			System.out.println("JDBC 드라이버 로딩 성공");
			conn = DriverManager.getConnection(url, dbId, dbPw);
			System.out.println("접속 성공");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("오라클 접속 실패");
		}
		return conn;
	}
	
	public ArrayList<BoardDTO> getAllBoardList() throws Exception {
		Connection conn = getConnection();
		ArrayList<BoardDTO> listBoard = new ArrayList<BoardDTO>();
		
		String sql = "SELECT * FROM simple_board ORDER BY bno DESC";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			int bno = rs.getInt("bno");
			String writer = rs.getString("writer");
			String title = rs.getString("title");
			String content = rs.getString("content");
			String writedate = rs.getString("writedate");
			listBoard.add(new BoardDTO(bno, writer, title, content, writedate));
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listBoard;
	}
	
	public void insertBoard(BoardDTO dto) throws Exception {
		Connection conn = getConnection();
				
		String sql = "INSERT INTO simple_board(bno,title,content,writer)"
				+ 	" VALUES (simple_board_seq.nextval, ?, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getTitle());
		pstmt.setString(2, dto.getContent());
		pstmt.setString(3, dto.getWriter());
		pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
	}
	
	// getNextBno() : 이번에 insert되는 글의 bno값을 리턴.(currval+1)
	public int getNextBno() throws Exception {
		Connection conn = getConnection();
		//String sql = "SELECT simple_board_seq.currval+1 FROM dual";
		String sql = "SELECT MAX(bno)+1 FROM simple_board";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		int ret = 0;
		if(rs.next()) {
			ret = rs.getInt(1);	// 컬럼의인덱스번호 (1) : 첫번째 컬럼의 번호 , 정수니까 Int로 가져옴. // 1번째 컬럼의 값을 가져옴(정수).
		}
		rs.close();
		pstmt.close();
		conn.close();
		return ret;
	}
	
	public BoardDetailDTO getBoardDetailByBno(int bno) throws Exception {
		String sql = "SELECT * "
				+ 	" FROM simple_board s, simple_member m" 
				+ 	" WHERE s.writer=m.id AND bno = ?";
		Connection conn = getConnection();
		BoardDetailDTO dto = null;
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, bno);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int bno2 = rs.getInt("bno");
			String title = rs.getString("title");
			String content = rs.getString("content");
			String writer = rs.getString("writer");
			String name = rs.getString("name");
			String writedate = rs.getString("writedate");
			dto = new BoardDetailDTO(bno2, writer, title, content, name, writedate);
		}
		conn.close();
		return dto;
	}
}
