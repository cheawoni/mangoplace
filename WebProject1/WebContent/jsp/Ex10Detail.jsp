<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.yg.dao.*"%>
<%@page import="com.yg.dto.*"%>
<%
	int bno = 0;
	try {
		bno = Integer.parseInt(request.getParameter("bno"));
	} catch(NumberFormatException e) {
		System.out.println("잘못된 접근 bno : " + bno);
	}
	
	BoardDAO bDao = new BoardDAO();
	BoardDetailDTO dto = bDao.getBoardDetailByBno(bno);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 상세 보기</title>
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
</head>
<body>
	<table>
		<tr>
			<th>글번호</th>
			<td><%=dto.getBno()%></td>
		</tr>
		<tr>
			<th>타이틀</th>
			<td><%=dto.getTitle()%></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><%=dto.getContent()%></td>
		</tr>
		<tr>
			<th>글쓴이</th>
			<td><%=dto.getName()%>(<%=dto.getWriter()%>)</td>	<!-- 이름(아이디) 형식으로. -->
		</tr>
		<tr>
			<th>날짜</th>
			<td><%=dto.getWritedate()%></td>
		</tr>
	</table>
	<br/><a href="Ex10L.jsp">목록으로</a>
</body>
</html>