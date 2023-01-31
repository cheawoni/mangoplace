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
	<title>Insert title here</title>
</head>
<body>
<%
	String sql ="INSERT INTO simple_board(bno,writer,title,content,writedate)"
			 + " VALUES (simple_board_seq.nextval, ? , ? , ? , ?)";

	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,request.getParameter("writer"));
	pstmt.setString(2,request.getParameter("title"));
	pstmt.setString(3,request.getParameter("content"));
	pstmt.setString(4,request.getParameter("writedate"));
	pstmt.executeUpdate();	// 인서트가 아니라 rs가 필요없음.
	pstmt.close();
%>
<script>
	/* function open() {
		location href = "http://localhost:9090/WebProject1/jsp/Ex10List.jsp";
	}  */
	/* $(location).attr('href', 'https://shanepark.tistory.com'); */
	window.location.href = 'http://localhost:9090/WebProject1/jsp/Ex10List.jsp'; 
</script>
</body>
</html>
<%
	conn.close();
%>