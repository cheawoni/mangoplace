<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
<%
	int a = Integer.parseInt(request.getParameter("a"));
	int b = Integer.parseInt(request.getParameter("b"));
	
	int sum = 0;
%>
<h1>
<%
	for(int i=a; i<=b; i++) {
		sum += i;
		if(i<b) {
			out.println(i+"+");
		} else {
			out.println(i);
		}
	}
	out.println("="+sum);	// 반복문이 끝나고 합계를 내줘야됨 주의!
%>
</h1>
</body>
</html>