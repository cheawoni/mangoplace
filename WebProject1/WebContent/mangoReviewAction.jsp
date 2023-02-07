<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.mango.details.dao.*"%>
<%@page import="com.mango.details.dto.*"%>

<% 
		request.setCharacterEncoding("UTF-8");	//post방식 한글깨짐 해결.

		int detailPk = Integer.parseInt(request.getParameter("detailPk"));
		String email = (String)session.getAttribute("loginEmail");
		String review = request.getParameter("review");
		int tasty = Integer.parseInt(request.getParameter("tastylike"));
		String img = "sujinui1.jpg";
		
		//BoardDAO 이용,
		mangoDetailsDAO mangoDAO = new mangoDetailsDAO();
		//insert 수행
		mangoReviewInsertDTO mangoDTO= new mangoReviewInsertDTO();
		
		mangoDTO.setId(detailPk);
		mangoDTO.setEmail(email);
		mangoDTO.setImg(img);
		mangoDTO.setReview(review);
		mangoDTO.setTasty(tasty);
		
		mangoDAO.insertReview(mangoDTO);
%>
<script>
	alert("게시글이 등록되었습니다.");
	location.href = "mango_details.jsp?detailPk=71";
</script>

