<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- forword방식 -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Sum Quiz</title>
	<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
	<script>
		$(function() {
			$("#input1").val(<%=(int)(Math.random()*9)+1 %>);
			$("#input2").val(<%=(int)(Math.random()*9)+1 %>);
		});
	</script>
</head>
<body>
	<form action="../Ex11Servlet"><!--jsp의 경로를 적어줘야됨--><!-- Ex11Action.jsp -->
		num1 : <input type="text" id="input1" name="num1"/> <br/>
		num2 : <input type="text" id="input2" name="num2"/> <br/>
		num3 : <input type="text" name="num3"/> <br/>
		<input type="submit" value="제출"/>
	</form>
</body>
</html>