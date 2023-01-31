<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int n = Integer.parseInt(request.getParameter("num"));	// 쿼리스트링 자체가 문자열
	
	/* String strDan = request.getParameter("dan");
	int dan = 0;
	if(strDan == null) {
		System.out.println("(주의) strDan is null !");
	} else {
		dan = Integer.parseInt(strDan);
		// 만약, strDan이 null이라면,
		// dan = Integer.parseInt(null); -> 예외발생: NumberFormatException
	} */
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		td { border: 1px solid black; }
		table { border-collapse: collapse; }
	</style>
</head>
<body>
	<h2>구구단<%=n%>단출력</h2>
	<table>
		<%
			for(int i=1; i<=9; i++) {
		%>
		<tr>
			<td><%=n%></td>
			<td>*</td>
			<td><%=i%></td>  <!--  out.print(i); -->
			<td>=</td>
			<td><%=n*i%></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>