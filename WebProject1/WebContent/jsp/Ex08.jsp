<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>JDBC 테스트</title>
</head>
<body>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbId = "hr";
	String dbPw = "hr";
	
	try {
		Class.forName(driver);
		out.println("<h1>JDBC 드라이버 로딩 성공</h1>");
		DriverManager.getConnection(url, dbId, dbPw);
		out.println("<h1>Oracle 접속 성공</h1>");
	} catch(Exception e) {
		e.printStackTrace();
		out.println("오라클 접속 실패");
	}
%>
</body>
</html>