<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<%@ page import="java.util.*" %>    
<%@ page import="com.mango.details.dto.*" %>    
<%@ page import="com.mango.details.dao.*" %>

<%
	int detailPk = Integer.parseInt(request.getParameter("detailPk"));
	int mNumber = Integer.parseInt(request.getParameter("mNumber"));
	mangoDetailsDAO mangoDAO = new mangoDetailsDAO();
	mangoReviewDetailDTO reviewList = mangoDAO.getReviewDetail(detailPk,mNumber);
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>망고 리뷰 상세 페이지</title>
	<link rel="icon" href="Images/profile/mango_favicon.png">
	<link rel="stylesheet" href="CSS/mango_review_detail.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
	<script>
		$(function(){
			var current_slide=0;
			var pager_slide=0;
			var slider;
			$(".review_User_Content_Img").click(function(){
				idx = $(".review_User_Content_Img").index($(this));
				//alert(idx);
				$(".black_screen").css({ display:"block"});
				$(".review_Big_Img_Wrap").css({ display:"block"});
			    slider=$(".review_Big_Img_Wrap .review_Big_Img_Items").bxSlider({
			        speed: 100,        // 이동 속도를 설정
			        slideWidth: 524,
			        pager: true,
			        infiniteLoop: false,	// "Next" 를 클릭하면 처음으로 전환
			        touchEnabled: true,	// 슬라이더에 터치 전환을 허용합니다.
			        pagerCustom: '#bx-pager',
			        startSlide:idx,
		        	onSlideNext: function($slideElement, oldIndex, newIndex) {
						//$(".bx-controls-direction .bx-prev").removeClass('first');
						current_slide = newIndex;
						var max_slide = 0;
		 				$(".review_Big_Img_Content").each(function(p_idx,obj) {
							max_slide = Math.max(p_idx);
							if(current_slide==p_idx) {
								$(this).addClass('on');
							}else{
								$(this).removeClass('on');
							}
						});
		 				if(current_slide==max_slide) {
		 					$(".bx-controls-direction .bx-next").addClass('last');
		 					$(".bx-controls-direction .bx-prev").click(function(){
			 					$(".bx-controls-direction .bx-next").removeClass('last');
		 					});
		 				}
		 				
					},
					onSlidePrev: function($slideElement, oldIndex, newIndex) {
						current_slide = newIndex;
						if(newIndex==0) {
							$(".bx-controls-direction .bx-prev").addClass('first');
							$(".bx-controls-direction .bx-next").click(function(){
			 					$(".bx-controls-direction .bx-prev").removeClass('first');
		 					});
						}
		 				$(".review_Big_Img_Content").each(function(p_idx,obj) {
							if(current_slide==p_idx) {
								$(this).addClass('on');
							}else{
								$(this).removeClass('on');
							}
						});
					},
			     });
			});
			//pager 이미지 이동했을때 필터적용
			$(".review_Big_Img_Content").on('click', function (event) {
	            $(".review_Big_Img_Content").removeClass('on');
	            $(this).addClass('on');
			 });
			$(".close_button").click(function(){
				$(".review_Big_Img_Wrap").css({ display:"none"});
				$(".black_screen").css({ display:"none"});
				slider.destroySlider();
			});
			$(".black_screen").click(function(){
				$(".review_Big_Img_Wrap").css({ display:"none"});
				$(".black_screen").css({ display:"none"});
				slider.destroySlider();
			});
		});
	</script>
</head>
<body id="review_Body">
	<div id = "review_Detail_page">
		<div id="header">
			<div class="logo_box">
				<a href="MangoMain.jsp"><div id="logo"></div></a>
			</div>
		</div>
		<div id = "review_Content_Wrap">
			<div class="review_Content_Header">
				<div class="review_User_Items_Wrap">
					<div class="review_Userimg" style="background-image: url(Images/Member_Img/<%=reviewList.getMemberImg() %>);"></div>
					<div class="review_User_Items">
						<div class="review_User_Name"><span><%=reviewList.getMemberName() %></span></div>
						<div class="review_User_count">
							<div class="review_User_Reviewcount">
								<div class="user_Review_Icon"></div>
								<div><%=reviewList.getMemberWriteCount() %></div>
							</div>
							<div class="review_User_Followcount">
								<div class="user_Follow_Icon"></div>
								<div><%=reviewList.getMemberFollowCount() %></div>
							</div>
						</div>
					</div>
				</div>
				<% if( reviewList.getTasty() == 5 ) { %>
				<div class="tasty_like">
					<div class="tasty_like_img_good"></div>
					<div class="tasty_like_content">맛있다</div>
				</div>
				<% } else if( reviewList.getTasty() == 3 ) { %>
				<div class="tasty_like">
					<div class="tasty_like_img_notbad"></div>
					<div class="tasty_like_content">괜찮다</div>
				</div>
				<% } else if( reviewList.getTasty() == 1 ) { %>
				<div class="tasty_like">
					<div class="tasty_like_img_bad"></div>
					<div class="tasty_like_content">별로다</div>
				</div>
				<% } %>
			</div>
			<a href="mango_details.jsp?detailPk=<%=reviewList.getId() %>" class="review_Restaurant">
				@&nbsp<span class="review_RestaurantName"><%=reviewList.getName() %></span>&nbsp&nbsp-&nbsp
				<span class="review_RestaurantMetro"><%=reviewList.getArea() %></span>
			</a>
			<div class="review_User_Content">
      			<%=reviewList.getComent() %><!-- 점심시간 1시간 위이팅은 기본 순댓국을 받고 나면 기다림의 노고가 한순간에 날아가 버린다 무척 바쁨에도 싱글벙글 친절한집 -->
    		</div>
    		<div class="review_User_Content_Img_Wrap">
    		<% for( int i = 0; i<=reviewList.getImg().length-1; i++ ){ %>
    			<div class="review_User_Content_Img" style="background-image: url(Images/Detail_Review_Img/<%=reviewList.getImg()[i]%>)"></div>
    		<% } %>
    		</div>
    		<div class="review_Writedate"><%=reviewList.getWriteDate() %></div>
		</div>
	</div>
	<div class="review_Big_Img_Wrap">
		<div class="review_Big_Img_Items_Wrap" >
			<div class="review_Big_Img_Items">
			<% for( int i = 0; i<=reviewList.getImg().length-1; i++ ){ %>
				<div class="review_Big_Img" style="background-image: url(Images/Detail_Review_Img/<%=reviewList.getImg()[i]%>)"></div>
    		<% } %>
			</div>
		</div>
		<div class="review_Big_Img_Content_Wrap">
			<div class="review_Big_Img_Content_Items" id="bx-pager">
			<% for( int i = 0; i<=reviewList.getImg().length-1; i++ ){ %>
				<a data-slide-index="<%=i%>" href=""><div class="on review_Big_Img_Content" style="background-image:url(Images/Detail_Review_Img/<%=reviewList.getImg()[i]%>)"></div></a>
    		<% } %>
			</div>
		</div>
		<div class="close_button"></div>
	</div>
	<div class="black_screen"></div>
</body>
</html>