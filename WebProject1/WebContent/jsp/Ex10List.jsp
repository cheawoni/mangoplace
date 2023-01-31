<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%! // Declaration 데클러레이션 declare (선언하다 라는 뜻)의 명사 : 메서드를 정의할 수 있는 레벨에 복사됨.
	
	public Connection getConnection() {	// 메서드를 정의
		Connection conn = null;	// 지역변수 사용하기 전에 : 1) 변수선언  2) 사용			// 참조변수의 초기화: 아무것도 가르키지 않다는 뜻의 null을 넣어 참조변수의 초기화를 해줌.
	 	
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbId = "test1017";
		String dbPw = "1234";
		
		try {
			Class.forName(driver);
			System.out.println("<h1>JDBC 드라이버 로딩 성공</h1>");
			conn = DriverManager.getConnection(url, dbId, dbPw);
			System.out.println("<h1>Oracle 접속 성공</h1>");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("오라클 접속 실패");
		}
		return conn; // conn의 값을 Connection에 리턴
	}
	// 바로 이 자리에서, conn은 null일 수도 있음...(자바)
%>
<%
	Connection conn = getConnection();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>simple_board 전체 게시글 출력</title>
</head>
<style>
	table {
		border-collapse: collapse;
		margin: 0 auto;
	}
	td,th {
		border: 1px solid black;
	}
	button {
		float: right;
	}
</style>
<body>
	<table>
		<tr>
			<th>bno</th>
			<th>writer</th>
			<th>title</th>
			<th>content</th>
			<th>writedate</th>
		</tr>
<%
	String sql = "SELECT * FROM simple_board";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	while(rs.next()) {
		int bno = rs.getInt("bno");
		String writer = rs.getString("writer");
		String title = rs.getString("title");
		String content = rs.getString("content");
		int writedate = rs.getInt("writedate");
		out.println("<tr>");
		out.println("<td>" + bno + "</td>");
		out.println("<td>" + writer + "</td>");
		out.println("<td>" + title + "</td>");
		out.println("<td>" + content + "</td>");
		out.println("<td>" + writedate + "</td>");
		out.println("</tr>");
		//bno
		//writer
		//title
		//content
		//writedate
	}
	rs.close();
	pstmt.close();
%>
	</table>
	<form action="Ex10Write.jsp">
		<button>글쓰기</button>
	</form>
</body>
</html>
<%
	conn.close();
%>