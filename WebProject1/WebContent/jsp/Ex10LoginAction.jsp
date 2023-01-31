<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.yg.dao.MemberDAO"%>

<%
	String id = request.getParameter("id");
	int pw = Integer.parseInt( request.getParameter("pw") );
	
	MemberDAO mDao = new MemberDAO();
	if( mDao.loginCheck(id, pw) ) {					// 이해1.
		// 로그인 성공시. 쿠키에 저장
		// 1. 쿠키
		//Cookie c = new Cookie("loginId", id);
		//response.addCookie(c);
		// 2. 세션
		session.setAttribute("loginId", id);
%>
		<script>alert("로그인 성공!"); location.href="Ex10L.jsp";</script>
<%		
	} else {										// 이해2.
		// 로그인 실패시.
%>
	<script>alert("잘못된 아이디 또는 비밀번호입니다.!");</script>
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