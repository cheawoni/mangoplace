<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String result = (String)(request.getAttribute("login_result"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 결과</title>
</head>
<body>
	<h1>로그인 <%=result%></h1>
	<%
		if("실패".equals(result)) {
	%>
		<a href="jsp/Ex12Login.jsp">다시 로그인</a>
	<%
		}
	%>
</body>
</html>