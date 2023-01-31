<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.yg.dao.*"%>

<%
	BoardDAO bDao = new BoardDAO();
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글쓰기</title>
	<style>
		form {
			border: 1px solid grey;
		}
	</style>
<%--
	SELECT 시퀀스.nextval() FROM dual; 시퀀스에서 뽑아먹을 때
--%>
</head>
<body>
	<form action = "Ex10A.jsp" method="post">	<!-- method=post 파라미터값 숨기기 --><!-- 한글깨짐: method="get" -->
		게시글번호 : <%=bDao.getNextBno()%> <br/>
		제목 : <input type="text" name="title"/> <br/>
		내용 : <input type="text" name="content"/> <br/>
		작성자 : <input type="text" name="writer"/> <br/>
		<input type="submit" value="작성완료"/>
	</form>
</body>
</html>