<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- <%
	int num1 = Integer.parseInt(request.getParameter("num1"));
	int num2 = Integer.parseInt(request.getParameter("num2"));
	int num3 = Integer.parseInt(request.getParameter("num3"));
%> --%>

<%
	int num1=0; int num2=0; int num3=0;
	try {
		num1 = Integer.parseInt(request.getParameter("num1"));
		num2 = Integer.parseInt(request.getParameter("num2"));
		num3 = Integer.parseInt(request.getParameter("num3"));
	} catch(NumberFormatException e) { e.printStackTrace(); }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- <%
	if(num1+num2==num3) {
%>
	<h1>정답</h1>
<%
	}
%> --%>
<%
	if(num1+num2==num3) {
		out.println("정답");
	} else {
		out.println("정답이 아니다");
	}
%>
</body>
</html>