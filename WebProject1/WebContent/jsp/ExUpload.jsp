<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일업로드</title>
</head>
<body>				<!-- page1 ---------- page2		"multipart" -->
	<form action="ExUploadServlet" method="post" enctype="multipart/form-data">
		설명 : <input type="text" name="desc"/> <br/>
		파일 : <input type="file" name="file"/> <br/>
		<input type="submit" value="업로드"/>
	</form>
</body>
</html>