<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	/* if(request.getParameter("num")==null) {
		alert("파라미터가 num이 없음!");		
	} */
	int n = Integer.parseInt(request.getParameter("num")); // 문자열 --> 정수로 변경. Integer.parseInt(s3) // request.getParameter(파라미터이름) -> 주의: 리턴 값이 문자열이에요!
	char result = n%2==0 ? '짝' : '홀';
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<h1> <%=n%>는<%=result%>수임!</h1>
</body>
</html>