<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%! // Declaration 데클러레이션 declare (선언하다 라는 뜻)의 명사 : 메서드를 정의할 수 있는 레벨에 복사됨.
	
	public Connection getConnection() {	// 메서드를 정의
		Connection conn = null;	// 지역변수 사용하기 전에 : 1) 변수선언  2) 사용			// 참조변수의 초기화: 아무것도 가르키지 않다는 뜻의 null을 넣어 참조변수의 초기화를 해줌.
	 	
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbId = "hr";
		String dbPw = "hr";
		
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
	<title>employees 테이블 출력 연습</title>
</head>
<style>
	table { 
		border-collapse: collapse;
		margin: 0 auto;
 	}
	td,th { 
		border: 1px solid black; 
		padding: 8px;
	}
</style>
<body>
	<table>
		<tr>
			<th>사원번호</th>
			<th>이름</th>
			<th>성</th>
			<th>월급</th>
		</tr>
<%
	String sql = "SELECT * FROM employees";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	/* out.println("<table>"); */
	while(rs.next()) {
		int employeeId = rs.getInt("employee_id");
		String firstName = rs.getString("first_name");
		String lastName = rs.getString("last_name");
		int salary = rs.getInt("salary");
		out.println("<tr>");	// while문 안에 출력문이 있는이유는 페이지 소스보기에 보면 출력이 반복되고 있다.
		out.println("<td>" + employeeId + "</td>");
		out.println("<td>" + firstName + "</td>");
		out.println("<td>" + lastName + "</td>");
		out.println("<td>" + salary + "</td>");
		out.println("</tr>");
		//사원번호(employee_id)
		//이름(first_name)
		//성(last_name)
		//월급(salary)
	}
	out.println("</table>");
	
	rs.close();
	pstmt.close();
%>
</body>
</html>
<%
	conn.close();
%>

