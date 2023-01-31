<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// [정리]
	// request.getParameter() 는 String타입으로 리턴해.
	// request.getAttribute() 는 Object타입으로 리턴해. (따라서, 형 변환이 필요할 것.)
	String r = (String)(request.getAttribute("result")); // 2. redirect방식. (String)(request.getParameter("result"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>결과는 <%=r%></h1>
	<a href="jsp/Ex11.jsp">다시 처음부터</a>
</body>
</html>