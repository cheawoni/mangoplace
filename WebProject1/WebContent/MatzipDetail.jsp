<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>   
<%@ page import="java.util.*" %>
<%@ page import="com.mango.matzip.dto.*" %>
<%@ page import="com.mango.matzip.dao.*" %>

<%
	int idx = Integer.parseInt(request.getParameter("idx"));
	//int pageNum = Integer.parseInt(request.getParameter("page"));
	MangoDAO Mango = new MangoDAO();
	ArrayList<MatzipDetailTopDTO> matziplistTop = Mango.getMatzipDetailTop(idx);
	ArrayList<MatzipDetailDTO> matziplistDetail = Mango.getMatzipListDetail(idx);
	ArrayList<MatzipDetailDTO> matziplistDetailWithPaging = Mango.getMatzipListDetailWithPaging(idx, 1);
 	double centerLatitude = 0.0; // 위도
	double centerLongitude = 0.0; // 경도
	for(MatzipDetailDTO dto : matziplistDetailWithPaging) {
		centerLatitude += dto.getLatitude();
		centerLongitude += dto.getLongitude();
	}
	centerLatitude /= matziplistDetailWithPaging.size();
	centerLongitude /= matziplistDetailWithPaging.size();
	//System.out.print(centerLatitude);
	//System.out.print(centerLongitude);
	ArrayList<MatzipDetailBottomDTO> matziplistDetailBottom = Mango.getMatzipListDetailBottom(idx);
	MatzipDetailHashtagDTO matzipDetailHashtag = Mango.getMatzipDetailHashtag(idx);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>맛집리스트 상세페이지</title>
	<link rel="icon" href="Images/profile/mango_favicon.png">
	<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-kr.css' rel='stylesheet' type='text/css'>
	<link rel='stylesheet' type='text/css' href='CSS/MatzipDetail.css'/>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ed05170950c386674ae9f4fdd636dcf0"></script>
	<script src="https://code.jquery.com/jquery-3.6.2.js" integrity="sha256-pkn2CUZmheSeyssYw3vMp1+xyub4m+e+QK4sQskvuo4=" crossorigin="anonymous"></script>
	<script>
		let cnt = 20;
	   	let idx = getParameterByName('idx');
		function getParameterByName(name) {
	        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
	        results = regex.exec(location.search);
	        return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
	    }
		var pageNum = 1;
		
		let url = window.location.href;
		function copyUrl() {
	    	  navigator.clipboard.writeText(url).then(res=>{
	    		  alert("복사되었습니다. 원하는 곳에 붙여넣어주세요.");
	      	})
	    }
		$(function() {
			$("#logo").click(function( ) {
				location.href = "MangoMain.jsp";
			});
			$(".eatdeal").click(function() {
				location.href = "eat_deal_main.jsp";
			});
			$(".matziplist").click(function() {
				location.href = "Matziplist.jsp";
			})
			$(".mangostory").click(function() {
				location.href = "Mango_storyList.jsp";
			});
			
			$("#img_logo").click(function() {
	               //alert("망고플레이트 이동!");
	               location.href = "MangoMain.jsp"
            });
			$("#div_header > .header_right").eq(3).find("span").click(function() {
	               //alert("EAT딜 이동!");
	               location.href = "eat_deal_main.jsp";
	            });
	            
	            $("#div_header > .header_right").eq(2).find("span").click(function() {
	               //alert("맛집 리스트 이동!");
	               location.href = "Matziplist.jsp";
	            });
	            
	            $("#div_header > .header_right").eq(1).find("span").click(function() {
	               //alert("망고 스토리 이동!");
	               location.href = "Mango_storyList.jsp";
	            });
	            
			$(".header .fl .searchinput").click(function() {
				$(".keywordsuggester").css('display', 'block');
				$(".keywordsuggester_black").css('display', 'block');
				document.documentElement.style.overflowY = "hidden";
			});
			$(".keywordsuggester_black").click(function() {
				$(this).css('display', 'none');
				$(".keywordsuggester").css('display','none');
				document.documentElement.style.overflowY = "auto";
			});
			$("body .keywordsuggester .keywordsuggester_container .keywordsuggester_navigation .keywordsuggester_list .list_item .keywordsuggester_button").click(function() {
				$(this).parent().parent().find(".keywordsuggester_button").removeClass("keywordsuggester_button_selected");
				$(this).addClass("keywordsuggester_button_selected");
			});
			$("body .keywordsuggester .keywordsuggester_container .keywordsuggester_navigation .keywordsuggester_list .list_item .keywordsuggester_recommended").click(function() {
				$(".popular_search").css('display', 'none');
				$(".recommended_search").css('display', 'block');
			});
			$("body .keywordsuggester .keywordsuggester_container .keywordsuggester_navigation .keywordsuggester_list .list_item .keywordsuggester_popular").click(function() {
				$(".recommended_search").css('display', 'none');
				$(".popular_search").css('display', 'block');
			});
			$(".suggestkeywordlist li").hover(function() {
				$(this).css('background', '#f7f7f7');
				}, function() {
					$(this).css('background', '#fff');
			});
			
			$(document).on("click", ".list_item .fl", function() {		// 리스트 내 사진 클릭
				var plate_id = $(this).parent().attr('plate_id');
				location.href = "mango_details.jsp?detailPk="	+ plate_id;
			});
			$(document).on("click", ".list_item .fr div .fl .name", function() {		// 리스트 내 식당명 클릭(순번 포함)
				var plate_id = $(this).parent().parent().parent().parent().attr('plate_id');
				alert(plate_id);
				location.href = "mango_details.jsp?detailPk=" + plate_id;
			});
			$(document).on("click", ".list_item > .fr > div > .little_name", function() {
				var plate_id = $(this).parent().parent().parent().attr('plate_id');
				location.href = "mango_details.jsp?detailPk=" + plate_id;
			});
			$(document).on("click", ".list_item > .fr > div > .view_more", function() {
				var plate_id = $(this).parent().parent().parent().attr('plate_id');
				location.href = "mango_details.jsp?detailPk=" + plate_id;
			});
			
			
			
			let starnum = 0;		// 가고싶다 별 깜빡깜빡
			$(document).on("click", "body div .inner .list_item .fr div .fr .star", function() {
				if(starnum==0) {
					$(this).attr("src", "Images/icon_orangestar.jpg");
					starnum = 1;
				} else{
					$(this).attr("src", "Images/icon_star.png");
					starnum = 0;
				}
			});
			$(document).on("click", "body div .inner .list_item .fr div .fr .btn_more_review", function() {
				$(this).css("display", "none");
				$(this).parent().find(".short_review").css("display", "none");
				$(this).parent().find(".long_review").css("display", "inline");
				$(this).parent().parent().parent().parent().css("height", "288px");
				$(this).parent().parent().parent().find(".view_res").css("margin-top", "30px");
				$(this).parent().parent().parent().parent().css('height', '300px');
			});
			$("#copy_url").text(window.location.href);	// 공유하기 주소 복사하여 span 태그 텍스트로 넣기
			
			$(document).on("click", "#btn_more", function() {
				pageNum += 1;
				//alert("페이지 눌러서 요청 : " + pageNum);
				
				$.ajax({
					type: "get",
					url: "MatzipDetailServlet",
					data: {"idx":idx, "page":pageNum},
					datatype: "json",
					success: function(data) {	// data <------- objFinal
						console.log(data.result);
						//console.log(data.result.length);
						<%-- console.log(<%=matziplistDetail.size()%>); --%>
						//console.log(cnt);
						if(cnt>=<%=matziplistDetail.size()%>) {
							$("#btn_more").hide();
						}
						for(var i=0; i<=data.result.length-1; i++) {
							var main_img = data.result[i].main_img;
							var plate_id = data.result[i].plate_id;
							var restaurant_order = data.result[i].restaurant_order;
							var name = data.result[i].name;
							var score = data.result[i].score;
							var street_address = data.result[i].street_address;
							var recommended_review = data.result[i].recommended_review;
							var shortReview = data.result[i].recommended_review.substring(0,75);
								shortReview += "...";
							var member_img = data.result[i].member_img;
							var member_number = data.result[i].member_number;
							var member_id = data.result[i].member_id;
							var restaurant_order = data.result[i].restaurant_order;
							var latitude = data.result[i].latitude;
							var longitude = data.result[i].longitude;
							var str = '';
							str = '<div class="list_item"  plate_id="'+ plate_id + '">'
									+ '<div class="fl"><img src="Images/mango/'+ main_img + '"/></div>'	
									+ '<div class="fr">'
									+ '<div>'
									+ '<div class="fl">'
									+ '<span class="name">' + restaurant_order + '. ' + name + '</span>'
									+ '<span class="score">'+ ' ' + score +'</span></br>'
									+ '<span class="address">' + street_address + '</span>'
									+ '</div>'
									+ '<div class="fr">'
									+ '<img class="star" src="Images/icon_star.png"/>'
									+ '<img class="orangestar" src="Images/icon_orangestar.jpg"/>'
									+ '<p>가고싶다</p>'
									+ '</div>'
									+ '<div style="clear:both;"></div>'
									+ '</div>'
									+ '<div>'
									+ '<div class="fl"><img src="Images/mango/' + member_img + '"/></div>'
									+ '<div class="fr">'
									+ '<span>' + member_id + ' ' + '</span>'
									+ '<span class="short_review">' + shortReview + '</span>'
									+ '<span class="long_review hide">' + recommended_review + '</span>'
									+ '<span class="btn_more_review">더보기</span>'
									+ '</div>'
									+ '<div style="clear:both;"></div>'
									+ '</div>'
									+ '<div class="view_res">'
									+ '<div class="fr view_more">더보기 &gt;</div>'
									+ '<div class="fr little_name">' + name + '</div>'
									+ '<div style="clear:both;"></div>'
									+ '</div>'	
									+ '</div>'
									+ '</div>'
							//$('body > div:nth-child(4) > div.inner').append(str);
							$('.inner').first().append(str);
							cnt++;
						}
					},
					error: function(r,s,e) {
						alert("에러");
					}
				});
			});
			$(document).on("click", ".map_info_window", function() {	// 지도에서 클릭 시, 상세페이지 이동
				//alert("!!!");
				location.href = "mango_details.jsp?detailPk=" + Number($(this).attr('plate_id'));
			});
			$("body div .inner div.list_item_small #first_img").click(function() {
				var plate_id = $(this).parent().attr('plate_id');
				location.href = "mango_details.jsp?detailPk=" + plate_id;
			});
			$("body div .inner div.list_item_small #first_name").click(function() {
				var plate_id = $(this).parent().attr('plate_id');
				location.href = "mango_details.jsp?detailPk=" + plate_id;
			});
			$("body div .inner a.hashtag").click(function(e) {		// event라서 보통 소문자 e로 해요.
				e.preventDefault();		// (기본적인 동작을 막는다) --> 주로, a태그에 사용 --> 이동을 안 해요.
			});
			$(".footer .inner .bottom .language p span#korean").click(function() {
				alert("이미 적용되어 있습니다.");
			});
			$(".footer .inner .bottom .language p span#english").click(function() {
				alert("준비중입니다.");
			});
			$(".footer .inner .bottom .language p span#chinese").click(function() {
				alert("준비중입니다.");
			});
		});
	</script>
	<style>
		
	</style>
</head>
<body>
	<div id="div_header">
         <div class="fl"><!-- (1)헤더 왼쪽 망고플레이트 로고 -->
            <img id="img_logo" src="Images/mangoplace_logo.png"/>
         </div>
         <div class="fl"><!-- (2)헤더 왼쪽 서치아이콘 -->
            <img id="img_search" src="Images/img_searchicon.png"/>
            <label for="Input_search">
               <input type="text" id="Input_search" placeholder="지역, 식당 또는 음식"/>
            </label>
         </div>
         <div class="fr header_right"><!-- (3)헤더 오른쪽 유저아이콘 -->
            <div style="background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/web/resources/2018022864551sprites_desktop.png);background-position: -82px -919px;
             width: 34px; height: 34px; margin-top: 15px; cursor: pointer; margin-left: 24px;"></div>
          <span class="history_count" style="position: absolute; width: 24px; height: 24px; top: 10px; z-index: 1; border-radius: 50%; box-sizing: border-box; text-align: center; 
            font-size: 14px; font-style: normal; color: #FFFFFF; background-color: #ff792a; line-height: 23px;">0
          </span>
         </div>
         <div class="fr header_right"><!-- (4)헤더 오른쪽 망고스토리 아이콘 -->
            <span>망고 스토리</span>
         </div>
         <div class="fr header_right"><!-- (5)헤더 오른쪽 맛집 리스트 아이콘 -->
            <span>맛집 리스트</span>
         </div>
         <div class="fr header_right"><!-- (6)헤더 오른쪽 EAT딜 아이콘 -->
            <span class="header_right_new">EAT딜</span>
         </div>
         <div style="clear:both;"></div>
      </div>
	<div class="input_search_keyword">   <!-- 검색어 클릭 이벤트 발생시 나오는 창 -->
         <div class="input_search_backgroundDark"></div>      <!-- $("#input").css({display:"none"}); -->
         <div class="input_search_content">
            <div class="input_search_content_inner">
               <div class="input_search_content_list">
                  <div class="input_search_item_inner">
                     <div class="input_search_item select inputSearchItem_tapButton-selected keyword_recommended">추천 검색어</div>
                  </div>
                  <div class="input_search_item_inner keyword_popular">
                     <div class="input_search_item">인기 검색어</div>
                  </div>
                  <div class="input_search_item_inner keyword_history">
                     <div class="input_search_item">최근 검색어</div>
                  </div>
               </div>
               <div class="keywordListWrap_inner">
                  <div class="input_search_content_keywordListWrap">
                     <div class="small_recommended_search">
                        <div class="input_search_content_keywordList">
                           <span class="keywordList_item_img"></span>
                           <span class="input_search_keywordList_item">강남역</span>
                        </div>
                        <div class="input_search_content_keywordList">
                           <span class="keywordList_item_img"></span>
                           <span class="input_search_keywordList_item">용리단길</span>
                        </div>
                        <div class="input_search_content_keywordList">
                           <span class="keywordList_item_img"></span>
                           <span class="input_search_keywordList_item">유튜버추천</span>
                        </div>
                        <div class="input_search_content_keywordList">
                           <span class="keywordList_item_img"></span>
                           <span class="input_search_keywordList_item">신촌</span>
                        </div>
                        <div class="input_search_content_keywordList">
                           <span class="keywordList_item_img"></span>
                           <span class="input_search_keywordList_item">참치</span>
                        </div>
                        <div class="input_search_content_keywordList">
                           <span class="keywordList_item_img"></span>
                           <span class="input_search_keywordList_item">성수</span>
                        </div>
                        <div class="input_search_content_keywordList">
                           <span class="keywordList_item_img"></span>
                           <span class="input_search_keywordList_item">와인</span>
                        </div>
                     </div>
                     <div class="small_popular_search">
                        <div class="input_search_content_keywordList">
                           <span class="keywordList_item_img"></span>
                           <span class="input_search_keywordList_item">홍대</span>
                        </div>
                        <div class="input_search_content_keywordList">
                           <span class="keywordList_item_img"></span>
                           <span class="input_search_keywordList_item">이태원</span>
                        </div>
                        <div class="input_search_content_keywordList">
                           <span class="keywordList_item_img"></span>
                           <span class="input_search_keywordList_item">신촌</span>
                        </div>
                        <div class="input_search_content_keywordList">
                           <span class="keywordList_item_img"></span>
                           <span class="input_search_keywordList_item">강남역</span>
                        </div>
                        <div class="input_search_content_keywordList">
                           <span class="keywordList_item_img"></span>
                           <span class="input_search_keywordList_item">가로수길</span>
                        </div>
                        <div class="input_search_content_keywordList">
                           <span class="keywordList_item_img"></span>
                           <span class="input_search_keywordList_item">평택시</span>
                        </div>
                        <div class="input_search_content_keywordList">
                           <span class="keywordList_item_img"></span>
                           <span class="input_search_keywordList_item">방배</span>
                        </div>
                     </div>
                     <div class="small_history_search">
                        <span class="input_search_keywordList_item_none">최근 검색어가 없습니다.</span>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
	
	
	<div>		<!-- 3번 div 시작 -->
		<%
			for( MatzipDetailTopDTO dto : matziplistTop) {
		%>
		<p><%=dto.getClick() %> | <%=dto.getDate() %></p>
		<p><%=dto.getTitle() %></p>
		<p><%=dto.getMent() %></p>
		<%
			}
		%>
	</div>		<!-- 3번 div 끝 -->
	<div>		<!-- 4번 div 시작 -->
		<div class="inner">
			<%
				for(int i=0; i<=matziplistDetailWithPaging.size()-1; i++) {
					String shortReview = matziplistDetailWithPaging.get(i).getRecommended_review().substring(0, 75); // 인덱스 0부터 75이 되기 전까지(=74까지).
					shortReview += "...";
			%>
			<div class="list_item"  plate_id="<%=matziplistDetailWithPaging.get(i).getPlate_id() %>">
				<div class="fl"><img src="Images/mango/<%=matziplistDetailWithPaging.get(i).getMain_img() %>"/></div>	
				<div class="fr">
					<div>
						<div class="fl">
							<span class="name"><%=matziplistDetailWithPaging.get(i).getRestaurant_order()%>. <%=matziplistDetailWithPaging.get(i).getName() %></span>
							<span class="score"><%=matziplistDetailWithPaging.get(i).getScore() %></span></br>
							<span class="address"><%=matziplistDetailWithPaging.get(i).getStreet_address() %></span>
						</div>
						<div class="fr">
							<img class="star" src="Images/icon_star.png"/>
							<img class="orangestar" src="Images/icon_orangestar.jpg"/>
							<p>가고싶다</p>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div>
						<div class="fl"><img src="Images/mango/<%=matziplistDetailWithPaging.get(i).getMember_img() %>"/></div>
						<div class="fr">
							<span><%=matziplistDetailWithPaging.get(i).getMember_id() %></span>
							<span class="short_review"><%=shortReview %></span>
							<span class="long_review hide"><%=matziplistDetailWithPaging.get(i).getRecommended_review() %></span>
							<span class="btn_more_review">더보기</span>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="view_res">
						<div class="fr view_more">더보기 &gt;</div>
						<div class="fr little_name"><%=matziplistDetailWithPaging.get(i).getName() %></div>
						<div style="clear:both;"></div>
					</div>	
				</div>
			</div>
			<%
			}
			%>
			<div style="clear:both;"></div>
		</div>	
			<% if(matziplistDetail.size()>10) { %>
				<p><img id="btn_more" src="Images/mango/little_btn_more.jpg" style="margin: 10px 377px 40px 377px; cursor: pointer;"/></p>
			<%} %>
		<div class="inner sns_item">
			<div class="fl share" style="width: 380px;" onclick="copyUrl()">
				<p style="position: relative;">
					<span id="copy_url"></span>
					<button class="btn_url_share">공유하기</button>
				</p>
				<!-- <button type="button" id="btn_share" style="border: none; background-color: #fff; cursor: pointer;">
					<img style="height: 100%; width: 100%;" src="Images/link.png"/>
				</button> -->
			</div>
			<div class="fr">
				<a href="https://twitter.com/intent/tweet?text=%EC%B9%B4%EB%A0%88%EC%9A%B0%EB%8F%99%20%EB%A7%9B%EC%A7%91%20%EB%B2%A0%EC%8A%A4%ED%8A%B8%205%EA%B3%B3%20%EB%B2%A0%EC%8A%A4%ED%8A%B8%205%EA%B3%B3&url=https%3A%2F%2Fwww.mangoplate.com%2Ftop_lists%2F810_curryudon%3Futm_source%3DTWITTER%26utm_medium%3Dtop_lists%26utm_campaign%3D810_curryudon%26utm_term%3Dv1%26utm_content%3DCLICK_SHARE_TWITTER" target="_blank">
					<img class="fr" style="height:50px; width:50px;" src="Images/sns_twiter.jpg"/>
				</a>
				<a href="https://www.facebook.com/login.php?skip_api_login=1&api_key=966242223397117&signed_next=1&next=https%3A%2F%2Fwww.facebook.com%2Fsharer%2Fsharer.php%3Fu%3Dhttps%253A%252F%252Fwww.mangoplate.com%252Ftop_lists%252F810_curryudon%253Futm_source%253DFACEBOOK%26utm_medium%3Dtop_lists%26utm_campaign%3D810_curryudon%26utm_term%3Dv1%26utm_content%3DCLICK_SHARE_FACEBOOK&cancel_url=https%3A%2F%2Fwww.facebook.com%2Fdialog%2Fclose_window%2F%3Fapp_id%3D966242223397117%26connect%3D0%23_%3D_&display=popup&locale=ko_KR" target="_blank">
					<img class="fr" style="height:50px; width:50px;" src="Images/sns_facebook.jpg"/>
				</a>	
			</div>
			<div style="clear:both;"></div>
		</div>
		<div class="inner map_item">
			<span class="title">리스트 지도</span>
			<!-- <img id="img_map" src="Images/map.png"/> -->
			<div id="map" style="width: 100%"></div>
	<script>
		// 인포윈도우를 표시하는 클로저를 만드는 함수
		function kakaoMakeOverListener(map, marker, infowindow, arr_all_info_windows) {
			return function() {
				for(var i=0; i<=<%=matziplistDetailWithPaging.size()%>-1; i++) {
					arr_all_info_windows[i].close();
				}
				infowindow.open(map, marker);
			};
		}
		
		// 인포윈도우를 닫는 클로저를 만드는 함수
		function kakaoMakeOutListener(infowindow) {
          return function() {
              infowindow.close();
          };
      	}
		
		var arr_all_info_windows = new Array(<%=matziplistDetailWithPaging.size()%>);
		var arr_markers = new Array(<%=matziplistDetailWithPaging.size()%>);
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center: new kakao.maps.LatLng(<%=centerLatitude%>, <%=centerLongitude%>),
			<% if(idx==22){ %>
			level: 13
			<% } else {%>
			level: 7
			<% } %>
		};
		var map = new kakao.maps.Map(mapContainer, mapOption);
		
		var positions = [
			<%
			for(int i=0; i<=matziplistDetailWithPaging.size()-1; i++) {
				String main_img = matziplistDetailWithPaging.get(i).getMain_img();
				String name = null;
				if(matziplistDetailWithPaging.get(i).getName().length() > 8){
					name = matziplistDetailWithPaging.get(i).getName();
					name = name.substring(0,5);
					name += "..";
				} else {
					name = matziplistDetailWithPaging.get(i).getName();
				}
				double score =matziplistDetailWithPaging.get(i).getScore();
				String area = matziplistDetailWithPaging.get(i).getArea().replace("//", "/");
				String type = matziplistDetailWithPaging.get(i).getType();
				int reviewCount = matziplistDetailWithPaging.get(i).getReview();
				int wish = matziplistDetailWithPaging.get(i).getWish();
				int plate_id = matziplistDetailWithPaging.get(i).getPlate_id();
			%>
			{
				content: '<div class="map_info_window" style="width:330px; height:135px; display:inline-block; cursor:pointer;" detailPk="<%=plate_id%>">'
						+ '<div class="fl" style="padding: 10px; display:inline;">'
						+ '<img src="Images/mango/<%=main_img%>" style="width: 105px; height: 105px;"/>'
						+ '</div>'
						+ '<div class="fr" style="padding:10px;">'
						+ '<span style="font-size:21px;"><%=name%> </span>'
						+ '<span style="color:#ff792a; font-size:21px;"> <%=score%></span><br/>'
						+ '<span style="color:#9b9b9b; font-size:14px; width:181px; display:inline-block; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;"><%=area%> - <%=type%></span>'
						+ '<br/><br/>'
						+ '<span class="reviewCount" style="color: #9b9b9b; font-size: 13px;"><img src="Images/mango/review.jpg"/><%=reviewCount%> </span><span class="wish" style="color: #9b9b9b; font-size: 13px;"> <img src="Images/mango/wish.jpg"/><%=wish%></span>'
						+ '</div>'
						+ '<div style="clear: both;"></div>'
						+ '</div>',
						
				latlng: new kakao.maps.LatLng(<%=matziplistDetailWithPaging.get(i).getLatitude()%> , <%=matziplistDetailWithPaging.get(i).getLongitude()%>)
			}
			<%
				if(i<matziplistDetailWithPaging.size()-1) {
			%>,<%
			}
			%>	
			<%
			}
			%>
		];
		
		// 마커 이미지 주소
		var ImagesSrc = "https://mp-seoul-Images-production-s3.mangoplate.com/web/resources/ikpswdksy8bnweeq.png?fit=around|*:*&crop=*:*;*,*&output-format=png&output-quality=80";
		
		for(var i=0; i<=positions.length-1; i++) {
			// 마커 이미지의 크기
			var ImagesSize = new kakao.maps.Size(25,35);
			// 마커 이미지 생성
			var markerImage = new kakao.maps.MarkerImage(ImagesSrc, ImagesSize); 
			// 마커 생성
			var marker = new kakao.maps.Marker({
				map: map,	// 마커를 표시할 지도
				position: positions[i].latlng,	// 마커의 위치
				content: positions[i].content,
				Images: markerImage
			});
			// 마커에 표시할 인포윈도우 생성
			var infowindow = new kakao.maps.InfoWindow({
				content: positions[i].content	// 인포윈도우에 표시할 내용
			});
			arr_markers[i] = marker;
			arr_all_info_windows[i] = infowindow;
		}
			console.log(arr_all_info_windows);
		for(var i=0; i<=positions.length-1; i++) {
			// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
		    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
		    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
			//kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
		    //kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
			kakao.maps.event.addListener(arr_markers[i], 'click', kakaoMakeOverListener(map, arr_markers[i], arr_all_info_windows[i], arr_all_info_windows));
		}
		
	</script>
		</div>
	</div>		<!-- 4번 div 끝 -->
	<div>		<!-- 5번 div 시작 -->
		<% if(matziplistDetailBottom.size()!=0) {%>		<!-- 담길 내용이 없으면 div 삭제 -->
		<div class="inner">
			<span class="title">리스트의 식당과 비슷한 맛집</span>			
			<% for( MatzipDetailBottomDTO dto : matziplistDetailBottom) { %>
			<div class="list_item_small fl" plate_id="<%=dto.getPlate_id() %>">
				<img id="first_img" src="Images/mango/<%=dto.getMain_img() %>"/>
				<div id="first_name" class="name fl"><%=dto.getName() %></div>
				<%if(dto.getScore()>0.0) {%>
				<div class="score fr"><%=dto.getScore() %></div>
				<%} %>
				<div style="clear:both;"></div>
				<% String str = dto.getArea();
				   str = str.replace("//","/");
				%>
				<div class="category"><%=str %> - <%=dto.getType() %></div>
			</div>
			<%
				}
			%>
		</div>
		<% } %>
		<!-- 	<div class="list_item_small fl">
				<img id="second_img" src="https://mp-seoul-Images-production-s3.mangoplate.com/1743214_1608082563373775.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
				<div id="second_name" class="name fl">철판남</div>
				<div style="color:#e9e9e9;" class="score fr">3.9</div>
				<div style="clear:both;"></div>
				<div class="category">종로 - 해산물 요리</div>
			</div>
			<div class="list_item_small fl">
				<img id="third_img" src="https://mp-seoul-Images-production-s3.mangoplate.com/879146_1610123393176697.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
				<div id="third_name" class="name fl">반기다</div>
				<div class="score fr"></div>
				<div style="clear:both;"></div>
				<div class="category">종로 - 해산물 요리</div>
			</div>
			<div class="list_item_small fl">
				<img id="fourth_img" src="https://mp-seoul-Images-production-s3.mangoplate.com/1049578_1634284824593601.jpg?fit=around|362:362&crop=362:362;*,*&output-format=jpg&output-quality=80"/>
				<div id="fourth_name" class="name fl">순희네빈대떡</div>
				<div class="score fr">4.2</div>
				<div style="clear:both;"></div>
				<div class="category">종로 - 한정식 / 백반 / 정통 한식</div>
			</div> -->
			<div style="clear:both;"></div>
		<% if(matzipDetailHashtag.getKeyword()!=null) { %>
		<div class="inner">
			<span class="title">실시간 인기 키워드</span>
			<% for( int i=0; i<=matzipDetailHashtag.getHashtag().length-1; i++) { %> 
				<a href="https://www.mangoplate.com/search/%ED%95%B4%EB%AC%BC" class="hashtag"># <%=matzipDetailHashtag.getHashtag()[i] %></a>
			<%  } %>
		</div>
		<% } %>
	</div>		<!-- 5번 div 끝 -->
	
	
	<div class="footer">		<!-- 6번 div 시작 -->
		<div class="inner">
			<div class="fl mango">
				<div class="fl"><a href="MangoMain.jsp"><img id="mangologo" src="Images/mango/mangoplace_removeback.png"/></a></div>
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
				<div class="fr"><a href="https://www.facebook.com/MangoPlate/" target="_blank"><img id="sns" src="Images/mango/facebook.png"/></a>
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
</body>
</html>












































