<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.yg.dao.*"%>
<%@ page import="com.yg.dto.*"%>

<%
	request.setCharacterEncoding("UTF-8"); 	// post방식 한글깨짐 해결. request하기전에 먼저 해주고나서 request해야됨.
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String writer = request.getParameter("writer");
	
	// BoardDAO 이용,
	BoardDAO bDao = new BoardDAO();
	// insert 수행.
	BoardDTO bDto = new BoardDTO();
	bDto.setTitle(title);
	bDto.setContent(content);
	bDto.setWriter(writer);
	
	bDao.insertBoard(bDto);
%>
<script>	// 서버에서 인서트가 되고나서 다음페이지인 리스트로 넘어감. 웹브라우저에서 실행
	alert("게시글이 등록되었습니다.");
	location.href = "Ex10L.jsp";
</script>