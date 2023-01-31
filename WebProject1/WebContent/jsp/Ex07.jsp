<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int num1 = (int)(Math.random()*10)+1;	// 난수발생 1~10
	int num2 = (int)(Math.random()*10)+1;
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<form action=Ex07p2.jsp>
		숫자1 : <input type="text" name="num1" value="<%=num1%>"/> <!--input[type="text"] readonly:숫자를 바꿀수 없게 만듬 --> -->
		숫자2 : <input type="text" name="num2" value="<%=num2%>"/>
		합 : <input type="text" name="num3" <%-- value="<%=num1+num2%>" --%>/>
		정답 확인 : <input type="submit" value="제출하기"/>
	</form>
</body>
</html>