<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p><%=request.getAttribute("desc")%></p>
	<img src='upload/<%=request.getAttribute("img")%>'/>
							
	<p>${desc}</p>		<!-- EL(Expression Language) -->
	<img src='upload/${img}'/>
</body>
</html>