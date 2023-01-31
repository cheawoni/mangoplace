<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.Scanner" %> <!-- 페이지 속성 -->
<!-- 
[암기] 꺽새% ~ %꺽새 : 스크립틀릿(scriptlet) 작은 스크립트 - java 코드 그대로.
	꺽새%@ ~ %꺽새 : 디렉티브(directive) - 주로, 설정 정보.
	꺽새%= ~ %꺽새 : 익스프레션(expression) - java 변수의 값을 출력.
		(ex) 꺽새%=s1 %꺽새 -> "out.println(s1);"로 변환되어 실행!
		(ex) 꺽새%=s2 %꺽새 -> "out.println(s2);"로 변환되어 실행!	// HTML 문서상에 출력
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		Scanner sc = new Scanner(System.in);
		System.out.print("이름을 입력하세요 : "); // 콘솔창 출력
		String name = sc.nextLine();
		out.println(name + "님, 안녕하세요!"); // HTML문서를 출력하는 와중에 출력
	%>
</body>
</html>