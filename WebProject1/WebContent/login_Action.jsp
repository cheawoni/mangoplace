<%@page import="com.mango.eatdeal.dao.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String email = request.getParameter("email");
    String passw = request.getParameter("passw");

	JoinDAO mDao = new JoinDAO();
	if( mDao.loginCheck(email, passw)){
		//로그인 성공시
		// 1. 쿠키
		/* Cookie c = new Cookie("loginId", id);
		response.addCookie(c); */
		//2. 세션
		session.setAttribute("loginEmail", email);
		
	String loginEmail = "";
	%>
	<script>alert("로그인 성공!"); location.href="eat_deal_main.jsp";</script>	
	<%
		
		
	}else {
	%>
	
	
	<script>
	alert("잘못된 아이디 또는 비밀번호입니다!");
	location.href="login.jsp";
	</script>
	
	
	<%
		
		
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>