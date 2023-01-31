<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><!-- directive -->
<%
String s1 = "안녕하세요, ";
String s2 = "JSP";
%><!-- scriptlet -->
<!-- JSP: (Java ServerPages)
	- HTML의 뼈대 위에
	- 자바 코드를 심는다
	
	servlet&JSP
	.jsp : 서버언어. 서버에서 돌아가는 파일
	요청: Ex01.jsp -> jsp가 실행된 결과 html이 실행되는데 그 html문서를 받겠다.
	<-	HTML문서
	
	EX01.jsp
	-이해: 웹브라우저가 웹서버에게 Ex01.jsp를 요청(o)
	-이해: 웹서버가 Ex01.jsp를 웹브라우저에게 전달 (x)
 	-이해: 웹서버는 내부적으로 Ex01.jsp를 실행하여 HTML문서를 생성 (o)
	클라이언트 웹브라우저가 웹서버에게 .jsp를 요청 -> 웹서버는 .jsp의 html문서를 생성 웹브라우저에게 줌 -> 웹브라우저가 해석해서 디더링을 한다.
 	-[암기] .jsp -> .java로 변환 ->(컴파일) .class->(실행 byJVM) HTML문서
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>안녕하세요, JSP</h1>
	<h1><%=s1+s2%></h1><!-- Expression(익스프레션): out.print(s1); 인쇄가됨 -->
	<%
		out.println("<h1>"+s1+s2+"</h1>");
	%>
</body>
</html>