<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<%@ page import="java.util.*" %>
<%@ page import="com.mango.matzip.dto.*" %>
<%@ page import="com.mango.matzip.dao.*" %>

<%
	MangoDAO Mango = new MangoDAO();
	String back = Mango.randomMainBackground();
	ArrayList<MainMatziplistDTO> matziplist = Mango.getMainMatzipList();
	ArrayList<MainMatziplistDTO> matziplistByRegion = Mango.getMatziplistByRegion();
	ArrayList<MainMatziplistDTO> matziplistByMenu = Mango.getMatziplistByMenu();
	ArrayList<MainMangostoryDTO> mangostory = Mango.getMangolist();
	ArrayList<Main8RestaurantDTO> eatdeal8 = Mango.get8eatdeal();
	ArrayList<Main8RestaurantDTO> editor8 = Mango.get8editor();
	ArrayList<Main8RestaurantDTO> tvres8 = Mango.get8TVres();
	ArrayList<Main8RestaurantDTO> toprated8 = Mango.get8TopRated();
%>



<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>망고 메인페이지</title>
	<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-kr.css' rel='stylesheet' type='text/css'>
	<script src="https://code.jquery.com/jquery-3.6.2.js" integrity="sha256-pkn2CUZmheSeyssYw3vMp1+xyub4m+e+QK4sQskvuo4=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.js"></script>
	<link rel='stylesheet' type='text/css' href='CSS/MangoMain.css'/>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.css" rel="stylesheet" />
	<script>
		$(function() {
			$("body .main header .header .fl #logo").click(function() {
				//alert("123");
				loaction.href = "http://localhost:9090/WebProject1/MangoMain.jsp";
			});
			$("body .main header .header .fr .eatdeal").click(function() {
				location.href="잇딜.jsp";
			});
			$("body .main header .header .fr .matziplist").click(function() {
				location.href="http://localhost:9090/WebProject1/Matziplist.jsp";
			});
			$("body .main header .header .fr .mangostory").click(function() {
				location.href="Mango_storyList.jsp";
			});
			$(".main .header .header_top .logo").click(function() {
				location.href="http://localhost:9090/WebProject1/MangoMain.jsp";
			});
			$(".main .header .header_top .fr .eatdeal").click(function() {
				location.href="잇딜.jsp";
			});
			$(".main .header .header_top .fr .matziplist").click(function() {
				location.href="http://localhost:9090/WebProject1/Matziplist.jsp";
			});
			$(".main .header .header_top .fr .mangostory").click(function() {
				location.href="Mango_storyList.jsp";
			});
			$(".main .header .header_bottom .eatdeal_btn").click(function() {
				location.href="잇딜.jsp";
			});
			$(".header .header_middle .search .search_word #main_search").click(function() {
				$(".keywordsuggester").css('display', 'block');
				$(".keywordsuggester_black").css('display', 'block');
				document.documentElement.style.overflowY = "hidden";
			});
			$(".keywordsuggester_black").click(function() {
				$(this).css('display', 'none');
				$(".popular_search").css('display','none');
				$(".history_search").css('display','none');
				$(".recommended_search").css('display','block');
				$(".keywordsuggester_button").removeClass("keywordsuggester_button_selected");
				$(".keywordsuggester_recommended").addClass("keywordsuggester_button_selected");
				$(".keywordsuggester").css('display','none');
				document.documentElement.style.overflowY = "auto";
			});
			$("body .main .keywordsuggester .keywordsuggester_container .keywordsuggester_navigation .keywordsuggester_list .list_item .keywordsuggester_button").click(function() {
				$(this).parent().parent().find(".keywordsuggester_button").removeClass("keywordsuggester_button_selected");
				$(this).addClass("keywordsuggester_button_selected");
			});
			$("body .main .keywordsuggester .keywordsuggester_container .keywordsuggester_navigation .keywordsuggester_list .list_item .keywordsuggester_recommended").click(function() {
				$(".popular_search").css('display', 'none');
				$(".history_search").css('display', 'none');
				$(".recommended_search").css('display', 'block');
			});
			$("body .main .keywordsuggester .keywordsuggester_container .keywordsuggester_navigation .keywordsuggester_list .list_item .keywordsuggester_popular").click(function() {
				$(".recommended_search").css('display', 'none');
				$(".history_search").css('display', 'none');
				$(".popular_search").css('display', 'block');
			});
			$("body .main .keywordsuggester .keywordsuggester_container .keywordsuggester_navigation .keywordsuggester_list .list_item .keywordsuggester_history").click(function() {
				$(".recommended_search").css('display', 'none');
				$(".popular_search").css('display', 'none');
				$(".history_search").css('display', 'block');
			});
			$(".suggestkeywordlist").mouseenter(function() {
				$(this).css('overflow','auto');
			});
			$(".suggestkeywordlist").mouseleave(function() {
				$(this).css('overflow','hidden');
			});
			$(".suggestkeywordlist li:not(.empty)").mouseenter(function() {
				$(this).css('background','#f7f7f7');
				$(this).parent().parent().css('overflow','auto');
			});
			$(".suggestkeywordlist li").mouseleave(function() {
				$(this).css('background','#fff');
			});
			
			
			
			// 엔터키이벤트 엔터를 누르면 발생
	        $("#main_search").keypress(function(e) { // 입력시 검색어 들어감
	           if (e.keyCode == 13){   
	             var url_input_search = "Mango_popularSearch2.jsp?keyword="+$("#main_search").val().replace(" ","_");
	             location.href = url_input_search;
	           }    
	        });
			
			$(document).on("click", ".input_search_content_keywordList", function() {   // 클릭시 검색어 들어감
	           var item = $(this).find(".keyword").text();
	           var url_input_search = "Mango_popularSearch2.jsp?keyword="+item;
	           location.href = url_input_search;
	        });
			
			$(document).on("click", "#btn_search", function() {
				var item = $(this).parent().find("#main_search").val();
				//alert(item);
				var url_input_search = "Mango_popularSearch2.jsp?keyword="+item;
				location.href = url_input_search;
			});
			
			
			
			
			
			
			$(".main > .matziplist .slider > .list > .vertical_list > .dark").click(function() {
				//alert('locat~~~~~~~');
				var idx = $(this).attr('idx');
				if(idx==121 || idx==119 || idx==23 || idx==22) {
					location.href = "http://localhost:9090/WebProject1/MatzipDetail.jsp?idx=" + idx;
				} else {
					alert("준비중입니다.");
				}
			});
			$(".main .matziplist .title span.more").click(function() {	// 리스트 더보기
				location.href = "Matziplist.jsp";
			});
			$(".main .mangostory .title span.more").click(function() {
				location.href = "Mango_storyList.jsp";
			});
			$(".main .mangostory .list li .real_list").click(function() {
				var idx = $(this).attr('idx');
				location.href = "Mango_storyContent2.jsp?story_id=" + idx;
			});
			let slider = $("#bxslider1").bxSlider({		// 맛집리스트 슬라이드
				infiniteLoop: false,
				onSlideAfter: function() {
				   if (slider.getCurrentSlide() == 0) {
				     // First slide
				     	$("#bxslider1").parent().parent().find(".bx-prev").css('display', 'none');
				 	    $("#bxslider1").parent().parent().find(".bx-next").css('display', 'block');
				   } else if (slider.getCurrentSlide() == slider.getSlideCount() - 1) {
				     // Last slide
					    $("#bxslider1").parent().parent().find(".bx-prev").css('display', 'block');
				     	$("#bxslider1").parent().parent().find(".bx-next").css('display', 'none');
				   } else {
					    $("#bxslider1").parent().parent().find(".bx-prev").css('display', 'block');
					    $("#bxslider1").parent().parent().find(".bx-next").css('display', 'block');
				   }
				}
			});

			let slider2 = $("#bxslider2").bxSlider({	// 망고스토리 슬라이드
				infiniteLoop: false,
				onSlideAfter: function() {
				   if (slider2.getCurrentSlide() == 0) {
				     // First slide
				     	$("#bxslider2").parent().parent().find(".bx-prev").css('display', 'none');
				 	    $("#bxslider2").parent().parent().find(".bx-next").css('display', 'block');
				   } else if (slider2.getCurrentSlide() == slider2.getSlideCount() - 1) {
				     // Last slide
					    $("#bxslider2").parent().parent().find(".bx-prev").css('display', 'block');
				     	$("#bxslider2").parent().parent().find(".bx-next").css('display', 'none');
				   } else {
					    $("#bxslider2").parent().parent().find(".bx-prev").css('display', 'block');
					    $("#bxslider2").parent().parent().find(".bx-next").css('display', 'block');
				   }
				}
			});

			let slider3 = $("#bxslider3").bxSlider({	// 메뉴별 인기 맛집 슬라이드
				infiniteLoop: false,
				onSlideAfter: function() {
				   if (slider3.getCurrentSlide() == 0) {
				     // First slide
				     	$("#bxslider3").parent().parent().find(".bx-prev").css('display', 'none');
				 	    $("#bxslider3").parent().parent().find(".bx-next").css('display', 'block');
				   } else if (slider3.getCurrentSlide() == slider3.getSlideCount() - 1) {
				     // Last slide
					    $("#bxslider3").parent().parent().find(".bx-prev").css('display', 'block');
				     	$("#bxslider3").parent().parent().find(".bx-next").css('display', 'none');
				   } else {
					    $("#bxslider3").parent().parent().find(".bx-prev").css('display', 'block');
					    $("#bxslider3").parent().parent().find(".bx-next").css('display', 'block');
				   }
				}
			});
			$("body .main .eatdeal .list .real_list .restaurant div").click(function() {
				var idx= $(this).attr('idx');
				location.href = "mango_details.jsp?detailPk=" + idx;
			});
			$("body .main .editor_restaurant .list .real_list .restaurant div").click(function() {
				var idx= $(this).attr('idx');
				location.href = "mango_details.jsp?detailPk=" + idx;
			});
			$("body .main .tv_restaurant .list .real_list .restaurant div").click(function() {
				var idx= $(this).attr('idx');
				location.href = "mango_details.jsp?detailPk=" + idx;
			});
			$("body .main .top_rated .list .real_list .restaurant div").click(function() {
				var idx= $(this).attr('idx');
				location.href = "mango_details.jsp?detailPk=" + idx;
			});
			$(".main .popular_by_location .list .vertical_list .dark").click(function() {
				//alert('locat~~~~~~~');
				var idx = $(this).attr('idx');
				if(idx==121 || idx==119 || idx==23 || idx==22) {
					location.href = "http://localhost:9090/WebProject1/MatzipDetail.jsp?idx=" + idx;
				} else {
					alert("준비중입니다.");
				}
			});
			$(".main > .popular_by_menu .slider3 > .list > .vertical_list > .dark").click(function() {
				//alert('locat~~~~~~~');
				var idx = $(this).attr('idx');
				if(idx==121 || idx==119 || idx==23 || idx==22) {
					location.href = "http://localhost:9090/WebProject1/MatzipDetail.jsp?idx=" + idx;
				} else {
					alert("준비중입니다.");
				}
			});
		});
		
		
		$(window).scroll(function () {		// 스크롤 해서 검색어 버튼 지나면 숨겼던 header 출현
			var height = $(document).scrollTop();
			if(height > 288) {
				$("body .main header").css('display', 'block');
			} else {
				$("body .main header").css('display', 'none');
			}
		});
	</script>
</head>
<body>
	<div class="main">
		<header>		<!-- header 시작 -->
			<div class="header">
				<div class="fr" style="border-left: 1px solid #dbdbdb; height: -webkit-fill-available;">
					<div class="right"> 
						<div style="background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/web/resources/2018022864551sprites_desktop.png);background-position: -82px -919px;
					    width: 34px; height: 34px; margin-top: 15px; cursor: pointer;"></div>
					<span class="history_count" style="position: absolute; width: 24px; height: 24px; top: 10px; z-index: 1; border-radius: 50%; box-sizing: border-box; text-align: center; 
						font-size: 14px; font-style: normal; color: #FFFFFF; background-color: #ff792a;">
    					0</span>
					</div>
				</div>
				<div class="fr">
					<div class="mangostory">
						<span>망고 스토리</span>
					</div>
				</div>
				<div class="fr">
					<div class="matziplist">
						<span>맛집 리스트</span>
					</div>
				</div>
				<div class="fr">
					<div class="eatdeal">
						<span style="position: relative;">EAT딜</span>
					</div>
				</div>
				<div class="fl">
					<img id="logo" src="Images/mango/mangoplace.png" style="witdh: 100px; height: 33px;"/>
					<div style="clear:both;"></div>
				</div>
			</div>
		</header>
		<div class="header" style="background-image: url(Images/mango/<%=back%>)">	<!-- 1번 div 시작 -->
			<div class="header_top">
				<div class="logo fl"><img src="Images/mango/mangoplace_removeback.png" style="width:100px; height: 33px;"/></div>
				<div class="fr">
					<div class="right"> 
						<div style="background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/web/resources/2018022864551sprites_desktop.png);background-position: -82px -919px;
					    width: 34px; height: 34px; margin-top: 15px; cursor: pointer;"></div> 
					</div>
					<span class="history_count" style="position: absolute; width: 24px; height: 24px; top: 10px; z-index: 1; border: 1px solid #ffffff;
    					border-radius: 50%; box-sizing: border-box; text-align: center; font-size: 14px; font-style: normal; color: #FFFFFF; background-color: #ff792a;">
    					0</span>
				</div>
				<div class="fr">
					<div class="mangostory">
						<span>망고 스토리</span>
					</div>
				</div>
				<div class="fr">
					<div class="matziplist">
						<span>맛집 리스트</span>
					</div>
				</div>
				<div class="fr">
					<div class="eatdeal">
						<span style="position: relative;">EAT딜</span>
					</div>
				</div>
				<div style="clear:both;"></div>					
			</div>
			<div class="header_middle">
				<p class="ment">솔직한 리뷰, 믿을 수 있는 평점!</p>
				<p class="title">망고플레이스</p>
				<div class="search">
					<div class="search_word">
						<span class="search_icon"></span>
						<input id="main_search" name="main_search" type="text" maxlength="50" placeholder="지역, 식당 또는 음식" autocomplete="off"/>
						<input id="btn_search" type="submit" value="검색"/>
					</div>
				</div>
			</div>
			<div class="header_bottom">
				<div class="eatdeal_btn fl">
					<img src="https://mp-seoul-image-production-s3.mangoplate.com/web/resources/nf58dxcb-7ikpwam.png"/>
				</div>
				<a href="https://apps.apple.com/kr/app/id628509224" target="_blank">
					<div class="ios_btn fr">
						<img src="https://mp-seoul-image-production-s3.mangoplate.com/web/resources/f7eokfaszt4gpkh6.svg?v=1"/>
					</div>
				</a>
				<a href="https://play.google.com/store/apps/details?id=com.mangoplate" target="_blank">
					<div class="android_btn fr">
						<img src="https://mp-seoul-image-production-s3.mangoplate.com/web/resources/bzdlmp2toaxrdjqg.png"/>
					</div>
				</a>
				<div style="clear: both;"></div>
			</div>
		</div>		<!-- 1번 div 끝 -->
		
		<div class="keywordsuggester">		<!-- 2번 div 시작(검색어 화면) -->
			<div class="keywordsuggester_black"></div>
			<div class="keywordsuggester_container">
				<nav class="keywordsuggester_navigation">
					<ul class="keywordsuggester_list">
						<li class="list_item">
							<div class="keywordsuggester_button keywordsuggester_recommended keywordsuggester_button_selected">추천 검색어</div>
						</li>
						<li class="list_item">
							<div class="keywordsuggester_button keywordsuggester_popular">인기 검색어</div>
						</li>
						<li class="list_item">
							<div class="keywordsuggester_button keywordsuggester_history">최근 검색어</div>
						</li>
					</ul>
					<div class="suggestkeywordlist">
						<ul class="recommended_search">
							<li class="input_search_content_keywordList">
								<span class="little_search_icon"></span>
								<span class="keyword">강남역</span>
							</li>
							<li class="input_search_content_keywordList">
								<span class="little_search_icon"></span>
								<span class="keyword">용리단길</span>
							</li>
							<li class="input_search_content_keywordList">
								<span class="little_search_icon"></span>
								<span class="keyword">유튜버추천</span>
							</li>
							<li class="input_search_content_keywordList">
								<span class="little_search_icon"></span>
								<span class="keyword">신촌</span>
							</li>
							<li class="input_search_content_keywordList">
								<span class="little_search_icon"></span>
								<span class="keyword">참치</span>
							</li>
							<li class="input_search_content_keywordList">
								<span class="little_search_icon"></span>
								<span class="keyword">성수</span>
							</li>
							<li class="input_search_content_keywordList">
								<span class="little_search_icon"></span>
								<span class="keyword">와인</span>
							</li>
						</ul>
						<ul class="popular_search">
							<li class="input_search_content_keywordList">
								<span class="little_search_icon"></span>
								<span class="keyword">홍대</span>
							</li>
							<li class="input_search_content_keywordList">
								<span class="little_search_icon"></span>
								<span class="keyword">이태원</span>
							</li>
							<li class="input_search_content_keywordList">
								<span class="little_search_icon"></span>
								<span class="keyword">신촌</span>
							</li>
							<li class="input_search_content_keywordList">
								<span class="little_search_icon"></span>
								<span class="keyword">강남역</span>
							</li>
							<li class="input_search_content_keywordList">
								<span class="little_search_icon"></span>
								<span class="keyword">가로수길</span>
							</li>
							<li class="input_search_content_keywordList">
								<span class="little_search_icon"></span>
								<span class="keyword">평택시</span>
							</li>
							<li class="input_search_content_keywordList">
								<span class="little_search_icon"></span>
								<span class="keyword">방배</span>
							</li>
						</ul>
						<ul class="history_search">
							<li class="empty">
								<p class="input_search_keywordList_item_none">최근 검색어가 없습니다.</p>
							</li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
		
		
		<div class="matziplist">		<!-- 3번 div 맛집리스트 시작 -->
			<div class="title">
				<h2 class="title fl">믿고 보는 맛집 리스트</h2>
				<span class="more fr">리스트 더보기</span>
			</div>
			<div style="clear:both;"></div>
			<ul class="slider" id="bxslider1">
					<%
					for(int i=0; i<=matziplist.size()-1; i+=2) {
					%>
				<% if(i==0 || i==6) { %>
					<li class="list">
				<% } %>
						<div class="vertical_list fl">
							<div>
								<span class="title"><%=matziplist.get(i).getMatzipList() %></span>
								<p class="ment"><%=matziplist.get(i).getMent() %></p>
							</div>
							<div class="list_img" style="background: center/100% url( Images/mango/<%=matziplist.get(i).getImg()%>);"></div>
							<div class="dark" idx="<%=matziplist.get(i).getRestaurant_list_idx()%>" style="background-color: rgba(0,0,0,0.2);"></div>
							<div>
								<span class="title"><%=matziplist.get(i+1).getMatzipList() %></span> 
								<p class="ment"><%=matziplist.get(i+1).getMent() %></p>
							</div>
							<div class="list_img" style="background: center/100% url( Images/mango/<%=matziplist.get(i+1).getImg()%>);"></div>
							<div class="dark" idx="<%=matziplist.get(i+1).getRestaurant_list_idx()%>" style="background-color: rgba(0,0,0,0.2);"></div>
	 					</div>
	 			<% if(i==4 || i==10) { %>
						<div style="clear:both;"></div>
					</li>
	 			<% } %>
					<%
						}
					%>
					<%-- 
					<div class="vertical_list fl">
						<div>
							<span class="title">삼성동 맛집 베스트 45곳</span>
							<p class="ment">"삼성동에서 혼밥부터 회식까지 완전 가능!"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/full/ewhmnlgbknwmnv.png?fit=around|600:382&crop=600:382;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
						<div>
							<span class="title">해장 맛집 베스트 45곳</span>
							<p class="ment">"술 마신 다음날을 책임질 해장 맛집은?!"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/8br58xbyonuwdyoc.jpg?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
					<div class="vertical_list fl">
						<div>
							<span class="title">충무로 맛집 베스트 15곳</span>
							<p class="ment">"손맛과 인심이 가득한 충무로 맛집"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/9vuf6ygycxxiutkt.jpg?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
						<div>
							<span class="title">방어회 맛집 베스트 10곳</span>
							<p class="ment">"제철 맞아 기름기 가득한 방어 안 먹으면 손해!"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/avugwafuzgma5zjb.jpg?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
					--%>
				<!-- <li class="list">
					<div class="vertical_list fl">
						<div>
							<span class="title">공덕 맛집 베스트 40곳</span>
							<p class="ment">"동네 주민, 근처 직장인 모두 가는 맛집"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/m-uzuupmnlbauep8.jpg?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
						<div>
							<span class="title">미들급 스시 맛집 35곳</span>
							<p class="ment">"가성비 가심비 모두 챙기는 미들급 스시"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/full/y26_h4xesgckf7.png?fit=around|600:382&crop=600:382;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
					<div class="vertical_list fl">
						<div>
							<span class="title">삼성동 맛집 베스트 45곳</span>
							<p class="ment">"삼성동에서 혼밥부터 회식까지 완전 가능!"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/full/ewhmnlgbknwmnv.png?fit=around|600:382&crop=600:382;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
						<div>
							<span class="title">해장 맛집 베스트 45곳</span>
							<p class="ment">"술 마신 다음날을 책임질 해장 맛집은?!"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/8br58xbyonuwdyoc.jpg?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
					<div class="vertical_list fl">
						<div>
							<span class="title">충무로 맛집 베스트 15곳</span>
							<p class="ment">"손맛과 인심이 가득한 충무로 맛집"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/9vuf6ygycxxiutkt.jpg?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
						<div>
							<span class="title">방어회 맛집 베스트 10곳</span>
							<p class="ment">"제철 맞아 기름기 가득한 방어 안 먹으면 손해!"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/avugwafuzgma5zjb.jpg?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
					<div style="clear:both;"></div>
				</li> -->
			</ul>
			<!-- <p><img class="orangedot" src="Images/orangedot.jpg" style="margin-right: 6px;"/><img class="graydot" src="Images/graydot.jpg"/></p> -->
		</div>		<!-- 3번 div 맛집리스트 끝 -->
		
		
		<div class="mangostory">	<!-- 4번 div 망고스토리 시작-->
			<div class="title">
				<h2 class="title fl">맛집 스토리</h2>
				<span class="more fr">스토리 더보기</span>
			</div>
			<!-- <div class="rightarrow fr"><img src="Images/rightarrow.png"/></div> -->
			<ul class="list" id="bxslider2">
				
					<%
						for(int i=0; i<=mangostory.size()-1; i++) {
					%>
				<%if(i==0 || i==3 || i==6) {%>
				<li>
				<% }%>
					<div class="real_list fl" idx="<%=mangostory.get(i).getStory_id() %>">
						<div>
							<strong class="title"><%=mangostory.get(i).getStory_title() %></strong>
							<p class="ment"><%=mangostory.get(i).getStory_subtitle() %></p>
							<div class="editor">
								<span class="badge"><img class="mangobadge" src="Images/mangobadge.png"/></span>
								<div class="editor_profile">
									<div class="img"><img src="Images/mango/<%=mangostory.get(i).getMember_img()%>"/></div>
									<p class="name"><%=mangostory.get(i).getMember_id() %></p>
								</div>
							</div>
						</div>
						<div class="list_img" style="background: center/100% url( Images/mango/<%=mangostory.get(i).getMain_img() %>); background-size: cover;"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
					<%
					}
					%>
				</li>
					<!-- <div class="real_list fl">
						<div>
							<strong class="title">뜨끈한 국물 요리 맛집 추천 8곳</strong>
							<p class="ment">국물이~ 국물이~ 끝내줘요!</p>
							<div class="editor">
								<span class="badge"><img class="mangobadge" src="Images/mangobadge.png"/></span>
								<div class="editor_profile">
									<div class="img"><img src="https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/fmsvfia71h84uy.jpg?fit=around|56:56&crop=56:56;*,*&output-format=jpg&output-quality=80"/></div>
									<p class="name">망고소녀</p>
								</div>
							</div>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/full/y26_h4xesgckf7.png?fit=around|600:382&crop=600:382;*,*&output-format=jpg&output-quality=80); background-size: cover;"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
					<div class="real_list fl">
						<div>
							<strong class="title">에디터의 인생 마라 요리 6곳</strong>
							<p class="ment">6년차 망고 에디터의 인생 맛집 공개!</p>
							<div class="editor">
								<span class="badge"><img class="mangobadge" src="Images/mangobadge.png"/></span>
								<div class="editor_profile">
									<div class="img"><img src="https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/fmsvfia71h84uy.jpg?fit=around|56:56&crop=56:56;*,*&output-format=jpg&output-quality=80"/></div>
									<p class="name">망고소녀</p>
								</div>
							</div>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/full/ewhmnlgbknwmnv.png?fit=around|600:382&crop=600:382;*,*&output-format=jpg&output-quality=80); background-size: cover;"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div> -->
				
				<!-- <li>
					<div class="real_list fl">
						<div>
							<strong class="title">크리스마스 데이트 맛집 6곳</strong>
							<p class="ment">분위기도 맛도 다 좋아야하니까!</p>
							<div class="editor">
								<span class="badge"><img class="mangobadge" src="Images/mangobadge.png"/></span>
								<div class="editor_profile">
									<div class="img"><img src="https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/fmsvfia71h84uy.jpg?fit=around|56:56&crop=56:56;*,*&output-format=jpg&output-quality=80"/></div>
									<p class="name">망고소녀</p>
								</div>
							</div>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/full/o_q5otjup1ixpv.png?fit=around|600:382&crop=600:382;*,*&output-format=jpg&output-quality=80); background-size: cover;"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
					<div class="real_list fl">
						<div>
							<strong class="title">뜨끈한 국물 요리 맛집 추천 8곳</strong>
							<p class="ment">국물이~ 국물이~ 끝내줘요!</p>
							<div class="editor">
								<span class="badge"><img class="mangobadge" src="Images/mangobadge.png"/></span>
								<div class="editor_profile">
									<div class="img"><img src="https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/fmsvfia71h84uy.jpg?fit=around|56:56&crop=56:56;*,*&output-format=jpg&output-quality=80"/></div>
									<p class="name">망고소녀</p>
								</div>
							</div>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/full/y26_h4xesgckf7.png?fit=around|600:382&crop=600:382;*,*&output-format=jpg&output-quality=80); background-size: cover;"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
					<div class="real_list fl">
						<div>
							<strong class="title">에디터의 인생 마라 요리 6곳</strong>
							<p class="ment">6년차 망고 에디터의 인생 맛집 공개!</p>
							<div class="editor">
								<span class="badge"><img class="mangobadge" src="Images/mangobadge.png"/></span>
								<div class="editor_profile">
									<div class="img"><img src="https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/fmsvfia71h84uy.jpg?fit=around|56:56&crop=56:56;*,*&output-format=jpg&output-quality=80"/></div>
									<p class="name">망고소녀</p>
								</div>
							</div>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/full/ewhmnlgbknwmnv.png?fit=around|600:382&crop=600:382;*,*&output-format=jpg&output-quality=80); background-size: cover;"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
				</li>
				<li>
					<div class="real_list fl">
						<div>
							<strong class="title">크리스마스 데이트 맛집 6곳</strong>
							<p class="ment">분위기도 맛도 다 좋아야하니까!</p>
							<div class="editor">
								<span class="badge"><img class="mangobadge" src="Images/mangobadge.png"/></span>
								<div class="editor_profile">
									<div class="img"><img src="https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/fmsvfia71h84uy.jpg?fit=around|56:56&crop=56:56;*,*&output-format=jpg&output-quality=80"/></div>
									<p class="name">망고소녀</p>
								</div>
							</div>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/full/o_q5otjup1ixpv.png?fit=around|600:382&crop=600:382;*,*&output-format=jpg&output-quality=80); background-size: cover;"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
					<div class="real_list fl">
						<div>
							<strong class="title">뜨끈한 국물 요리 맛집 추천 8곳</strong>
							<p class="ment">국물이~ 국물이~ 끝내줘요!</p>
							<div class="editor">
								<span class="badge"><img class="mangobadge" src="Images/mangobadge.png"/></span>
								<div class="editor_profile">
									<div class="img"><img src="https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/fmsvfia71h84uy.jpg?fit=around|56:56&crop=56:56;*,*&output-format=jpg&output-quality=80"/></div>
									<p class="name">망고소녀</p>
								</div>
							</div>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/full/y26_h4xesgckf7.png?fit=around|600:382&crop=600:382;*,*&output-format=jpg&output-quality=80); background-size: cover;"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
					<div class="real_list fl">
						<div>
							<strong class="title">에디터의 인생 마라 요리 6곳</strong>
							<p class="ment">6년차 망고 에디터의 인생 맛집 공개!</p>
							<div class="editor">
								<span class="badge"><img class="mangobadge" src="Images/mangobadge.png"/></span>
								<div class="editor_profile">
									<div class="img"><img src="https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/fmsvfia71h84uy.jpg?fit=around|56:56&crop=56:56;*,*&output-format=jpg&output-quality=80"/></div>
									<p class="name">망고소녀</p>
								</div>
							</div>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/full/ewhmnlgbknwmnv.png?fit=around|600:382&crop=600:382;*,*&output-format=jpg&output-quality=80); background-size: cover;"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
				</li> -->
			</ul>
			<!-- <p><img class="orangedot" src="Images/orangedot.jpg" style="margin-right: 6px;"/><img class="graydot1" src="Images/graydot.jpg" style="margin-right: 6px;"/><img class="graydot2" src="Images/graydot.jpg"/></p> -->
		</div>		<!-- 4번 div 망고스토리 끝-->	
		
		
		
		<div class="eatdeal">		<!-- 5번 div EAT딜을 판매중인 식당 시작 -->	
			<div>
				<h2 class="title fl">EAT딜을 판매중인 식당</h2>
			</div>
			<div class="list">
				<div class="real_list">
					<% for( Main8RestaurantDTO dto : eatdeal8) { 
					%>
					<div class="restaurant fl">
						<div idx="<%=dto.getPlate_id()%>">
							<span class="badge"></span>
							<img class="img" src="Images/mango/<%=dto.getMain_img() %>"/>
							<div class="info">
								<span class="title"><%=dto.getName() %></span>
								<%	if(dto.getScore()>0.0){	%>
								<strong class="score"><%=dto.getScore() %></strong>
								<% } %>
								<% String str = dto.getArea();
								   str = str.replace("//","/");
								%>
								<p class="location"><%=str %> - <%=dto.getType() %></p>
							</div>
						</div>
					</div>
					<%
						}
					%>
					<!-- <div class="restaurant fl">
						<div>
							<span class="badge"></span>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/137889/1573043_1628983138860_36833?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">초원순두부</span><strong class="score">4.0</strong>
								<p class="location">강원 속초시 - 탕 / 찌개 / 전골</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<span class="badge"></span>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/213410_1509155521778382.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">지노스 뉴욕피자</span><strong class="score">4.2</strong>
								<p class="location">신사/압구정 - 기타 양식</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<span class="badge"></span>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/446741/569389_1614584566533_5429?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">라온하우스</span><strong class="score"></strong>
								<p class="location">서대문구 - 이탈리안</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<span class="badge"></span>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/501936_1615191468116831.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">타이패밀리</span><strong class="score">4.0</strong>
								<p class="location">관악구 - 태국 음식</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<span class="badge"></span>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/460278_1590361211540592.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">모터시티</span><strong class="score">4.3</strong>
								<p class="location">역삼/선릉 - 기타 양식</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<span class="badge"></span>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/723830_1515669621055898.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">JVL 부대찌개</span><strong class="score"></strong>
								<p class="location">송파/가락 - 탕 / 찌개 / 전골</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<span class="badge"></span>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/292438_1601976043463769.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">컨시어지 커피</span><strong class="score">3.9</strong>
								<p class="location">서대문구 - 카페 / 디저트</p>
							</div>
						</div>
					</div> -->
				</div>
			</div>
		</div>		<!-- 5번 잇딜 식당 끝 -->
		
		
		<div class="editor_restaurant">		<!-- 6번 div 에디터가 선정한 식당 시작 -->	
			<div>
				<h2 class="title fl">에디터가 선정한 식당</h2>
			</div>
			<div class="list">
				<div class="real_list">
					<%
						for(Main8RestaurantDTO dto : editor8) {
					%>
					<div class="restaurant fl">
						<div idx="<%=dto.getPlate_id() %>">
							<img class="img" src="Images/mango/<%=dto.getMain_img() %>"/>
							<div class="info">
								<span class="title"><%=dto.getName() %></span>
								<% if(dto.getScore()>0.0) { %>
									<strong class="score"><%=dto.getScore() %></strong>
								<% } %>
								<% String str = dto.getArea();
								   str = str.replace("//","/");
								%>
								<p class="location"><%=str %> - <%=dto.getType() %></p>

							</div>
						</div>
					</div>
					<%
					}
					%>
					<!-- <div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/10049/14650_1527635618986_3784?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">소브스한남</span><strong class="score">3.6</strong>
								<p class="location">이태원/한남동 - 시푸드 요리</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/2935/743008_1572606162745_9092?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">아리아</span><strong class="score">4.3</strong>
								<p class="location">명동/남산 - 뷔페</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/233459/jr-gim6wot7nu8.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">옛빙그레김밥</span><strong class="score"></strong>
								<p class="location">강원 강릉시 - 기타 한식</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/61021/njphvmjovetdk8.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">정도너츠</span><strong class="score"></strong>
								<p class="location">경북 영주시 - 카페 / 디저트</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/13878_1424505120096?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">퀸스파크</span><strong class="score">3.6</strong>
								<p class="location">방배/반포/잠원 - 브런치 / 버거 / 샌드위치</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/443989/uqbfauwnsrvpcm.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">당구대장작통철판삼겹살</span><strong class="score"></strong>
								<p class="location">고양시 - 고기 요리</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/1704015_1622423072500875.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">황생가칼국수</span><strong class="score">4.3</strong>
								<p class="location">삼청/인사 - 국수 / 면 요리</p>
							</div>
						</div>
					</div> -->
				</div>
			</div>
		</div>		<!-- 6번 div 에디터 선정 식당 끝 -->
		
		
		<div class="tv_restaurant">		<!-- 7번 div tv에 나온 식당 시작 -->	
			<div>
				<h2 class="title fl">TV에 나온 식당</h2>
			</div>
			<div class="list">
				<div class="real_list">
					<%
						for(Main8RestaurantDTO dto : tvres8) {
					%>
					<div class="restaurant fl">
						<div idx="<%=dto.getPlate_id() %>">
							<img class="img" src="Images/mango/<%=dto.getMain_img() %>"/>
							<div class="info">
								<span class="title"><%=dto.getName() %></span>
								<%	if(dto.getScore()>0.0){	%>
								<strong class="score"><%=dto.getScore() %></strong>
								<% } %>
								<% String str = dto.getArea();
								   str = str.replace("//","/");
								%>
								<p class="location"><%=str %> - <%=dto.getType() %></p>

							</div>
						</div>
					</div>
					<%
					}
					%>
					<!-- <div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/added_restaurants/532601_1481430647519049.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">짱이네산곰장어</span><strong class="score" style="color:#e9e9e9;">3.9</strong>
								<p class="location">논현동 - 해산물 요리</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/197468/180342_1617464067957_7797?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">백부장집닭한마리</span><strong class="score">4.4</strong>
								<p class="location">삼청/인사 - 닭 / 오리 요리</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/added_restaurants/64873_1444964846460.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">용진집</span><strong class="score"></strong>
								<p class="location">전북 전주시 - 전통 주점 / 포차</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/584169_1583757652485089.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">영양센터</span><strong class="score">4.1</strong>
								<p class="location">명동/남산 - 탕 / 찌개 / 전골</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/10385/1245155_1600517621046_218501?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">에베레스트</span><strong class="score">4.2</strong>
								<p class="location">종로 - 인도 음식</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/121884/838901_1507527783165_5799?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">동해원</span><strong class="score" style="color:#e9e9e9;">3.7</strong>
								<p class="location">충남 공주시 - 정통 중식 / 일반 중식</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/1968189_1626680877218187.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">평양면옥</span><strong class="score">3.8</strong>
								<p class="location">의정부시 - 국수 / 면 요리</p>
							</div>
						</div>
					</div> -->
				</div>
			</div>
		</div>		<!-- 7번 tv에 나온 식당 끝 -->
		
		
		<div class="top_rated">		<!-- 8번 div 평점이 높은 식당 시작 -->	
			<div>
				<h2 class="title fl">평점이 높은 식당</h2>
			</div>
			<div class="list">
				<div class="real_list">
					<%
						for(Main8RestaurantDTO dto : toprated8) {
					%>
					<div class="restaurant fl">
						<div idx="<%=dto.getPlate_id() %>">
							<img class="img" src="Images/mango/<%=dto.getMain_img() %>"/>
							<div class="info">
								<span class="title"><%=dto.getName() %></span>
								<%	if(dto.getScore()>0.0){	%>
								<strong class="score"><%=dto.getScore() %></strong>
								<% } %>
								<% String str = dto.getArea();
								   str = str.replace("//","/");
								%>
								<p class="location"><%=str %> - <%=dto.getType() %></p>

							</div>
						</div>
					</div>
					<%
						}
					%>
					<!-- <div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/664762_1618718545966223.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">화양연가</span><strong class="score">4.8</strong>
								<p class="location">용산/숙대 - 기타 중식</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/13936/704481_1492338122499_12072?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">파씨오네</span><strong class="score">4.6</strong>
								<p class="location">신사/압구정 - 프랑스 음식</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/400799/638412_1603607491653_7333?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">스쿠퍼</span><strong class="score">4.4</strong>
								<p class="location">종로 - 카페 / 디저트</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/685796_1597057780586923.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">김진목삼</span><strong class="score">4.4</strong>
								<p class="location">광화문 - 고기 요리</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/686850_1502543635872847.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">아초원</span><strong class="score">4.3</strong>
								<p class="location">하남시 - 베트남 음식</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/419384/897636_1622004710082_46867?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">서평면옥</span><strong class="score">4.4</strong>
								<p class="location">동작/사당 - 국수 / 면 요리</p>
							</div>
						</div>
					</div>
					<div class="restaurant fl">
						<div>
							<img class="img" src="https://mp-seoul-image-production-s3.mangoplate.com/351116/453255_1531992171659_58921?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
							<div class="info">
								<span class="title">양키통닭</span><strong class="score">4.4</strong>
								<p class="location">영등포구 - 닭 / 오리 요리</p>
							</div>
						</div>
					</div> -->
				</div>
			</div>
		</div>		<!-- 8번 div 평점이 높은 식당 끝 -->
		
		
		<div class="popular_by_location">		<!-- 9번 div 지역별 인기 맛집 시작 -->
			<div class="title">
				<h2 class="title fl">지역별 인기 맛집</h2>
			</div>
			<div class="list">
			<%
				for(int i=0; i<=matziplistByRegion.size()-1; i+=2) {
			%>
				<div class="vertical_list fl">
					<div>
						<span class="title"><%=matziplistByRegion.get(i).getMatzipList() %></span>
						<p class="ment"><%=matziplistByRegion.get(i).getMent() %></p>
					</div>
					<div class="list_img" style="background: center/100% url( Images/mango/<%=matziplistByRegion.get(i).getImg() %>);"></div>
					<div class="dark" idx="<%=matziplistByRegion.get(i).getRestaurant_list_idx()%>" style="background-color: rgba(0,0,0,0.2);"></div>
					<div>
						<span class="title"><%=matziplistByRegion.get(i+1).getMatzipList() %></span>
						<p class="ment"><%=matziplistByRegion.get(i+1).getMent() %></p>
					</div>
					<div class="list_img" style="background: center/100% url( Images/mango/<%=matziplistByRegion.get(i+1).getImg() %>);"></div>
					<div class="dark" idx="<%=matziplistByRegion.get(i+1).getRestaurant_list_idx()%>"style="background-color: rgba(0,0,0,0.2);"></div>
				</div>
			<% if(i==5) {%>
				<div style="clear: both"></div>
			<%} %>	
			<%
					}
			%>
			</div>
				<!-- <div class="vertical_list fl">
					<div>
						<span class="title">2022 강남 인기 맛집 TOP 100</span>
						<p class="ment">"맛집하면 강남, 강남하면 맛집!"</p>
					</div>
					<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/egkhvudo5otau7as.png?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
					<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					<div>
						<span class="title">2022 강북 인기 맛집 TOP 100</span>
						<p class="ment">"다양한 먹거리를 찾는다면 강북으로!"</p>
					</div>
					<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/dvaufslcozevpwkv.png?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
					<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
				</div>
				<div class="vertical_list fl">
					<div>
						<span class="title">2022 강원도 인기 맛집 TOP 100</span>
						<p class="ment">"역시 강원도 음식이 제일 맛있어"</p>
					</div>
					<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/3hi_xaieyp3lid5j.jpg?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
					<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					<div>
						<span class="title">2022 부산 인기 맛집 TOP 100</span>
						<p class="ment">"마 맛집은 부산이라 안카나"</p>
					</div>
					<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/f5jk1vyxzriepaco.png?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
					<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
				</div> -->
		</div>		<!-- 9번 div 지역별 인기 맛집 끝 -->
		
		
		<div class="popular_by_menu">		<!-- 10번 div 메뉴별 인기 맛집 시작 -->
			<div class="title">
				<h2 class="title fl">메뉴별 인기 맛집</h2>
			</div>
			<!-- <div class="rightarrow fr"><img src="Images/rightarrow.png"/></div> -->
			<ul class="slider3" id="bxslider3">
				<%
					for(int i=0; i<=matziplistByMenu.size()-1; i+=2) {
				%>
				<% if(i==0 || i==6) {%>
				<li class="list">
				<%} %>
					<div class="vertical_list fl">
						<div>
							<span class="title"><%=Mango.getMatziplistByMenu().get(i).getMatzipList() %></span>
							<p class="ment"><%=Mango.getMatziplistByMenu().get(i).getMent() %></p>
						</div>
						<div class="list_img" style="background: center/100% url( Images/mango/<%=Mango.getMatziplistByMenu().get(i).getImg() %>);"></div>
						<div class="dark" idx="<%=Mango.getMatziplistByMenu().get(i).getRestaurant_list_idx()%>" style="background-color: rgba(0,0,0,0.2);"></div>
						<div>
							<span class="title"><%=Mango.getMatziplistByMenu().get(i+1).getMatzipList() %></span>
							<p class="ment"><%=Mango.getMatziplistByMenu().get(i+1).getMent() %></p>
						</div>
						<div class="list_img" style="background: center/100% url( Images/mango/<%=Mango.getMatziplistByMenu().get(i+1).getImg() %>);"></div>
						<div class="dark" idx="<%=Mango.getMatziplistByMenu().get(i+1).getRestaurant_list_idx() %>" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
				<% if(i==4 || i==10) { %>
					<div style="clear: both;"></div>
				</li>
				<% } %>
				<% } %>
					<!-- <div class="vertical_list fl">
						<div>
							<span class="title">2022 떡볶이 인기 맛집 TOP 20</span>
							<p class="ment">"달콤 매콤한 떡볶이가 세상을 구한다!!"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/u_wnwxhouitspdzq.png?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
						<div>
							<span class="title">2022 돼지고기 인기 맛집 TOP 50</span>
							<p class="ment">"한국인의 소울푸드는 바로 돼지고기가 아닐까?"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/dsmx8j0wayojijk9.png?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
					<div class="vertical_list fl">
						<div>
							<span class="title">2022 피자 인기 맛집 TOP 50</span>
							<p class="ment">"2022년엔 맛있는 피자 먹고 어깨 피자!"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/y0i-_ucmbz5bj2lr.png?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
						<div>
							<span class="title">2022 곱창 인기 맛집 TOP 30</span>
							<p class="ment">"선 곱창 후 볶음밥 RGRG?"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/zclmkfuclkli41io.png?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div> -->
				<!-- <li class="list">
					<div class="vertical_list fl">
						<div>
							<span class="title">2022 파스타 인기 맛집 TOP 50</span>
							<p class="ment">"2022 핫한 파스타 맛집이 궁금하다면 주목!"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/yzper-jags7yl3do.png?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
						<div>
							<span class="title">2022 돈까스 인기 맛집 TOP 30</span>
							<p class="ment">"돈까스에 소스 듬뿍 뿌려주세요!"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/fwo03mch9tfat2nw.png?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
					<div class="vertical_list fl">
						<div>
							<span class="title">2022 떡볶이 인기 맛집 TOP 20</span>
							<p class="ment">"달콤 매콤한 떡볶이가 세상을 구한다!!"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/u_wnwxhouitspdzq.png?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
						<div>
							<span class="title">2022 돼지고기 인기 맛집 TOP 50</span>
							<p class="ment">"한국인의 소울푸드는 바로 돼지고기가 아닐까?"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/dsmx8j0wayojijk9.png?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
					<div class="vertical_list fl">
						<div>
							<span class="title">2022 피자 인기 맛집 TOP 50</span>
							<p class="ment">"2022년엔 맛있는 피자 먹고 어깨 피자!"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/y0i-_ucmbz5bj2lr.png?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
						<div>
							<span class="title">2022 곱창 인기 맛집 TOP 30</span>
							<p class="ment">"선 곱창 후 볶음밥 RGRG?"</p>
						</div>
						<div class="list_img" style="background: center/100% url( https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/zclmkfuclkli41io.png?fit=around|600:400&crop=600:400;*,*&output-format=jpg&output-quality=80);"></div>
						<div class="dark" style="background-color: rgba(0,0,0,0.2);"></div>
					</div>
				</li> -->
			</ul>
			<!-- <p><img class="orangedot" src="Images/orangedot.jpg" style="margin-right: 6px;"/><img class="graydot" src="Images/graydot.jpg"/></p> -->
		</div>		<!-- 10번 div 메뉴별 인기 맛집 끝 -->
		
		
		
		<div class="footer">		<!-- 11번 div 시작 -->
			<div class="inner">
				<div class="fl mango">
					<div class="fl"><a href="http://localhost:9090/WebProject1/MangoMain.jsp"><img id="mangologo" src="Images/mango/mangoplace_removeback.png"/></a></div>
					<div class="fl line"></div>
					<p class="fl ment">Eat, Share, Be Happy.</p>
				</div>
				<div class="fl list" style="position: relative; left: 3px;">
					<p>회사소개</p>
					<p>망고플레이트 채용</p>
					<p>투자 정보</p>
					<p>브랜드 가이드라인</p>
					<p>망고플레이트 비즈니스</p>
					<p>광고 문의</p>
				</div>
				<div class="fl list" style="position: relative; left: 3px;">
					<p>공지사항</p>
					<p>이용약관</p>
					<p>비회원 이용자 이용정책</p>
					<p><b style="color:#d2d2d2;">개인정보처리방침</b></p>
					<p>위치기반서비스 이용약관</p>
					<p>커뮤니티 가이드라인</p>
					<p>청소년보호정책</p>
					<p>홀릭 소개</p>
					<p>문의하기</p>
				</div>
				<div class="rightsns">
					<div class="fr"><a href="https://www.facebook.com/MangoPlate/" target="_blank"><img id="sns" src="Images/facebook.png"/></a>
								<a href="https://www.instagram.com/mangoplate/" target="_blank"><img id="sns" src="Images/instargram.png"/></a>
					</div>
					<div style="clear:both;"></div>
				</div>
				<div class="area">
					<div class="keyword">
						<p style="margin: 0 0;">인기지역 : <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/이태원">이태원</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/홍대">홍대</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/강남역">강남역</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/가로수길">가로수길</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/신촌">신촌</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/명동">명동</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/대학로">대학로</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/연남동">연남동</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/부산">부산</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/합정">합정</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/대구">대구</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/여의도">여의도</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/건대">건대</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/광화문">광화문</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/일산">일산</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/제주">제주</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/경리단길">경리단길</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/한남동">한남동</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/삼청동">삼청동</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/대전">대전</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/종로">종로</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/서촌">서촌</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/잠실">잠실</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/사당역">사당역</a>
														| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/인천">인천</a>
						</p>
						<p style="margin: 0 0;">| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/코엑스">코엑스</a>
												| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/상수">상수</a>
												| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/서래마을">서래마을</a>
												| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/송도">송도</a>
												| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/왕십리">왕십리</a>
												| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/분당">분당</a>
												| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/인천">혜화</a>
												| <a class="keyword" target="_blank" href="https://www.mangoplate.com/search/고속터미널">고속터미널</a>
						</p>
					</div>
				</div>
				<div class="bottom">
					<div class="language fr">
						<p style="color:#9b9b9b; font-size: 16px;">
							<span style="color:#fff;">한국어</span>
							<span class="english">English</span>
							<span class="chinese">简体中文</span>
						</p>
					</div>
					<p style="font-size:14px; color:#9b9b9b; margin: 0 0;">
					 ㈜ 여기어때컴퍼니</br>서울특별시 강남구 봉은사로 479, 479타워 11층</br>대표이사: 정명훈</br>사업자 등록번호: 742-86-00224 <a href="https://www.ftc.go.kr/bizCommPop.do?wrkr_no=7428600224">[사업자정보확인]</a></br>
					 통신판매업 신고번호: 2017-서울강남-01779</br>고객센터: 02-565-5988</br></br>© 2022 MangoPlate Co., Ltd. All rights reserved.
					</p>
				</div>
			</div>
		</div>
	</div>
</body>
</html>