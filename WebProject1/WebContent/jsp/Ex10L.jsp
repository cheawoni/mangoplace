<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><!-- session="false" 세션값 새로고침해서 바뀌는거 닫아줌. session="true" 기본값 -->
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@page import="com.yg.dao.*"%>
<%@ page import="com.yg.dto.*" %>

<%
	String loginId = (String)session.getAttribute("loginId");
%>
<%
	BoardDAO bDAO = new BoardDAO();
	ArrayList<BoardDTO> listB = bDAO.getAllBoardList();	//모든 게시글 하나당 dto객체 하나에 해당됨 모든 게시글이 ArrayList에 담기고 listB가 관리하겠다.
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>전체 게시글 출력</title>
	<script src="../js/jquery-3.6.3.min.js"></script>
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
<script>
	/* function btn_write_clicked() {
		alert("!");
		location.href = "https://www.naver.com";
	} */
	
	$(function() {
		$("#btn_write").click(function() {
			location.href = "Ex10W.jsp";
		});
		
		$("table tr").click(function() {
			var bno = $(this).find("td.bno").text();
			//alert("bno : " + bno);
			location.href = "Ex10Detail.jsp?bno="+bno;
		});
	});
	
</script>
<body>
	<h1><%=loginId%>로 로그인되었습니다.</h1>
	<table>
		<tr>
			<th>글번호</th>
			<th>타이틀</th>
			<th>내용</th>
			<th>글쓴이</th>
			<th>날짜</th>
		</tr>
		<% for(BoardDTO board : listB) { %> <!-- 스크립팅요소 -->
			<tr>
				<td class="bno"><%=board.getBno()%></td>
				<td><%=board.getTitle()%></td>
				<td><%=board.getContent()%></td>
				<td><%=board.getWriter()%></td>
				<td><%=board.getWritedate()%></td>
			</tr>
		<% } %>
	</table>
	<button id="btn_write">글쓰기</button>
</body>
</html>
