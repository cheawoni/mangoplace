<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>강남역 맛집 인기 검색순위 ㅣ 맛집 추천, 망고플레이트</title>
	<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-kr.css' rel='stylesheet' type='text/css'><!-- 망고폰트 -->
	<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'><!-- 망고폰트 -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/font-applesdgothicneo@1.0/all.min.css"><!-- APPLE SD Gothic NEO -->
	<link rel='stylesheet' type='text/css' href='CSS/Mango_popularSearch.css'/>
	<script src="https://code.jquery.com/jquery-3.6.2.js" integrity="sha256-pkn2CUZmheSeyssYw3vMp1+xyub4m+e+QK4sQskvuo4=" crossorigin="anonymous"></script>
	<script>
		
		$(function() {
			//page_number = new URLSearchParams(location.search).get("pageNumber");
			//alert(page_number);
			//if(page_number==null) {
			//	page_number=1;				
			//}
			
			$(".page_button_item").removeClass('pageButton_on');
			$(".page_button_item").eq(page_number-1).addClass('pageButton_on');
			
			$(".page_button_item").click(function() {
			 	location.href = "http://localhost:9090/WebProject1/Mango_popularSearch.html?pageNumber="+Number($(this).attr('pageNumber'));
			});
			
			$(".search_top_keyword").find("a").click(function() {
				//alert("준비중입니다");
				//alert($(".topkeyword")attr(href)); // 누를경우 누른 태그의 텍스트를 가져오기
				location.href = "Mango_popularSearch.html?topkeyword="+Number($(this).attr('topkey'));
				
			}); 
			
			$(".popular_relatedContent_list").click(function() {
				location.href = "Mango_popularSearch.html?relatedContent_listNumber="+Number($(this).attr('listNumber'));
			});
			
			$(".popular_item").click(function() {
				location.href = "Mango_detail.html?plate_id="+Number($(this).attr('plateid'));
			});
			
			$(".search_top_filter").click(function() {
				$(this).toggleClass("select")	//컬러 안받고있음
			});
			
			$(".metro_wrap").each(function(idx, item) {
				if(idx==0) {
					$(item).css('display','block');
				} else {
					$(item).css('display','none');
				}
			});
			
			$(".area_wrap_item").click(function() {
				var idx = $(".area_wrap .area_wrap_item").index($(this));
				if(idx==5) {
					alert('준비중입니다');
					return;
				}
				$(".area_wrap_item").removeClass("selected");
				$(this).addClass("selected");
				//alert(idx);   // 0~4
				
				$("#input_area_wrap").val($(this).text()); // ex. "서울-강남"
				
				$(".metro_wrap").each(function(mw_idx, item) {
					if(idx==mw_idx) {
						$(item).css('display','block');
					} else {
						$(item).css('display','none');
					}
				});
			});
			
			$(".black_screen").click(function() {
				$(".popup_search_filter").css('display','none');
				$(this).css('display','none');
			});
			$(".search_top_filter").click(function() {
				$(".popup_search_filter").css('display','block');
				$(".black_screen").css('display','block');
			});
			
			// area_wrap 선택표시
			$("#input_area_wrap").val("서울-강남");
			// 선택된 area_wrap 의 area_wrap_item들 표시
			var metro_idx = $(".area_wrap_item").index($(".area_wrap_item.selected"));
			//alert(metro_idx);
			$(".metro_wrap").each(function(idx, item)) {
				if(metro_idx==idx) {
					$(item).css('display','block');
				} else {
					$(item).css('display','none');
				}
			});
			
			for(var i=0; i<=arr_area_item_selected.length-1; i++) {
				var area = arr_area_item_selected[i];
				$(".metro_wrap .small. span").each(function(idx, item) {
					if($(item).text()==area) {
						$(item).parent().parent().find('input').prop("checked", true);
					}
				});
			}
			
			// '필터'를 선택표시
			if( $(".search_top_filter").hasClass("selected") == true ) {
				$(".search_top_filter img").attr('src', 'Images/img_filterIconOrange.png');		// 편집 선택 어떻게?
			}
		});
	</script>
</head>
<body>
	<!-- ///////////////////////////  헤더 시작   ////////////////////////////////////////////////// -->
	<!-- nth child(1) 헤더(로고..검색..등등) -->
	<div id="div_header">
		<div class="fl"><!-- (1)헤더 왼쪽 망고플레이트 로고 -->
			<img id="img_logo" src="Images/img_logo.png"/>
		</div>
		<div class="fl"><!-- (2)헤더 왼쪽 서치아이콘 -->
			<img id="img_search" src="Images/img_searchicon.png"/>
			<label for="input_search">
				<input type="text" id="Input_search" placeholder="지역, 식당 또는 음식"/>
			</label>
		</div>
		<div class="fr header_right"><!-- (3)헤더 오른쪽 유저아이콘 -->
			<img class="UserProfileButton_PersonIcon" src="Images/icon_user.png"/>
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
	<!-- ///////////////////////////  헤더 끝   ////////////////////////////////////////////////// -->
	<div id="div_container" class="flex">
		<!-- left: (검색순위, 필터, 분류, 메인이미지, 식당이름, 평점, 장소-분류,조회수,리뷰수) -->
		<div class="black_screen" style="display: none;"></div>
		<div class="popular_left">
			<div class="search_top">
				<h1 class="search_top_title" searchkeyword="search_result_keyword.length">강남역 맛집 인기 검색순위</h1>
				<div class="search_top_filter <%=selectedSearchTopFilter%>">
					<img src="Images/img_filterIcon.png"/>
					<span>필터</span>			
				</div>
				<div style="clear:both;"></div>
				<div class="search_top_keyword">
					<a class="topkeyword" topkey="1">한식</a>
					<a class="topkeyword" topkey="2">분식</a>
					<a class="topkeyword" topkey="3">양식</a>
					<a class="topkeyword" topkey="4">세계음식</a>
					<a class="topkeyword" topkey="5">뷔페</a>
					<a class="topkeyword" topkey="6">디저트</a>
					<a class="topkeyword" topkey="7">카페</a>
					<a class="topkeyword" topkey="8">술집</a>
					<a class="topkeyword" topkey="9">치킨</a>
					<a class="topkeyword" topkey="10">브런치</a>
					<a class="topkeyword" topkey="11">이탈리안</a>
				</div>
				<div style="clear:both;"></div>
			</div>
			<div class="list_popular">
				<div class="list_popular_result">
					<%
						for(PopularPlateDto dto : list1) {
					%>
						<div class="popular_item" plateid="71">
							<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/87430/59_1491141169295_9384?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
							<div class="popular_item_info">
								<span class="popular_item_info_title">농민백암왕순대
									<span class="popular_item_info_title_branch">(강남역점)</span>
								</span>
								<strong class="popular_item_info_point">4.6</strong>
								<p class="popular_item_info_areaAndType">강남역 - 탕 / 찌게 / 전골</p>
								<div class="popular_item_info_viewcountAndReview">
									<img src="Images/img_viewcount.png"/>
									<span>504,833</span>
									<img src="Images/img_reviewIcon.png"/>
									<span>270</span>
								</div>
							</div>
						</div>
					<%
						}
					%>
					<!-- 
					<div class="popular_item" plateid="72">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/651394_1603016288185937.jpg?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">옥토스
								<span class="popular_item_info_title_branch"></span>
							</span>
							<strong class="popular_item_info_point">4.6</strong>
							<p class="popular_item_info_areaAndType">강남역 - 해산물 요리</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>42,958</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>12</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="76">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/452637/1168063_1639733462425_13128?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">반티엔야오카오위
								<span class="popular_item_info_title_branch">(강남점)</span>
							</span>
							<strong class="popular_item_info_point">4.5</strong>
							<p class="popular_item_info_areaAndType">강남역 - 기타 중식</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>39,386</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>25</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="74">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/2034518_1629532770014711.jpg?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">청류벽
								<span class="popular_item_info_title_branch"></span>
							</span>
							<strong class="popular_item_info_point">4.4</strong>
							<p class="popular_item_info_areaAndType">강남역 - 국수 / 면 요리</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>95,455</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>73</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="75">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/523082_1497584727932655.jpg?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">강남진해장
								<span class="popular_item_info_title_branch"></span>
							</span>
							<strong class="popular_item_info_point">4.4</strong>
							<p class="popular_item_info_areaAndType">강남역 - 탕 / 찌게 / 전골</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>170,652</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>86</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="83">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/460278_1601069724370749.jpg?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">서동한우
								<span class="popular_item_info_title_branch">(강남점)</span>
							</span>
							<strong class="popular_item_info_point">4.4</strong>
							<p class="popular_item_info_areaAndType">강남역 - 고기 요리</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>62,141</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>20</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="71">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/87430/59_1491141169295_9384?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">농민백암왕순대
								<span class="popular_item_info_title_branch">(강남역점)</span>
							</span>
							<strong class="popular_item_info_point">4.6</strong>
							<p class="popular_item_info_areaAndType">강남역 - 탕 / 찌게 / 전골</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>504,833</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>270</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="72">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/651394_1603016288185937.jpg?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">옥토스
								<span class="popular_item_info_title_branch"></span>
							</span>
							<strong class="popular_item_info_point">4.6</strong>
							<p class="popular_item_info_areaAndType">강남역 - 해산물 요리</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>42,958</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>12</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="76">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/452637/1168063_1639733462425_13128?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">반티엔야오카오위
								<span class="popular_item_info_title_branch">(강남점)</span>
							</span>
							<strong class="popular_item_info_point">4.5</strong>
							<p class="popular_item_info_areaAndType">강남역 - 기타 중식</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>39,386</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>25</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="74">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/2034518_1629532770014711.jpg?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">청류벽
								<span class="popular_item_info_title_branch"></span>
							</span>
							<strong class="popular_item_info_point">4.4</strong>
							<p class="popular_item_info_areaAndType">강남역 - 국수 / 면 요리</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>95,455</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>73</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="75">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/523082_1497584727932655.jpg?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">강남진해장
								<span class="popular_item_info_title_branch"></span>
							</span>
							<strong class="popular_item_info_point">4.4</strong>
							<p class="popular_item_info_areaAndType">강남역 - 탕 / 찌게 / 전골</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>170,652</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>86</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="83">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/460278_1601069724370749.jpg?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">서동한우
								<span class="popular_item_info_title_branch">(강남점)</span>
							</span>
							<strong class="popular_item_info_point">4.4</strong>
							<p class="popular_item_info_areaAndType">강남역 - 고기 요리</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>62,141</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>20</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="71">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/87430/59_1491141169295_9384?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">농민백암왕순대
								<span class="popular_item_info_title_branch">(강남역점)</span>
							</span>
							<strong class="popular_item_info_point">4.6</strong>
							<p class="popular_item_info_areaAndType">강남역 - 탕 / 찌게 / 전골</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>504,833</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>270</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="72">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/651394_1603016288185937.jpg?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">옥토스
								<span class="popular_item_info_title_branch"></span>
							</span>
							<strong class="popular_item_info_point">4.6</strong>
							<p class="popular_item_info_areaAndType">강남역 - 해산물 요리</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>42,958</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>12</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="76">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/452637/1168063_1639733462425_13128?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">반티엔야오카오위
								<span class="popular_item_info_title_branch">(강남점)</span>
							</span>
							<strong class="popular_item_info_point">4.5</strong>
							<p class="popular_item_info_areaAndType">강남역 - 기타 중식</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>39,386</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>25</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="74">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/2034518_1629532770014711.jpg?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">청류벽
								<span class="popular_item_info_title_branch"></span>
							</span>
							<strong class="popular_item_info_point">4.4</strong>
							<p class="popular_item_info_areaAndType">강남역 - 국수 / 면 요리</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>95,455</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>73</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="75">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/523082_1497584727932655.jpg?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">강남진해장
								<span class="popular_item_info_title_branch"></span>
							</span>
							<strong class="popular_item_info_point">4.4</strong>
							<p class="popular_item_info_areaAndType">강남역 - 탕 / 찌게 / 전골</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>170,652</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>86</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="83">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/460278_1601069724370749.jpg?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">서동한우
								<span class="popular_item_info_title_branch">(강남점)</span>
							</span>
							<strong class="popular_item_info_point">4.4</strong>
							<p class="popular_item_info_areaAndType">강남역 - 고기 요리</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>62,141</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>20</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="75">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/523082_1497584727932655.jpg?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">강남진해장
								<span class="popular_item_info_title_branch"></span>
							</span>
							<strong class="popular_item_info_point">4.4</strong>
							<p class="popular_item_info_areaAndType">강남역 - 탕 / 찌게 / 전골</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>170,652</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>86</span>
							</div>
						</div>
					</div>
					<div class="popular_item" plateid="83">
						<img class="popular_item_img" src="https://mp-seoul-image-production-s3.mangoplate.com/460278_1601069724370749.jpg?fit=around|359:240&crop=359:240;*,*&output-format=jpg&output-quality=80"/>
						<div class="popular_item_info">
							<span class="popular_item_info_title">서동한우
								<span class="popular_item_info_title_branch">(강남점)</span>
							</span>
							<strong class="popular_item_info_point">4.4</strong>
							<p class="popular_item_info_areaAndType">강남역 - 고기 요리</p>
							<div class="popular_item_info_viewcountAndReview">
								<img src="Images/img_viewcount.png"/>
								<span>62,141</span>
								<img src="Images/img_reviewIcon.png"/>
								<span>20</span>
							</div>
						</div>
					</div>
					 -->
					<div style="clear:both;"></div>
				</div>
			</div>
			<div class="page_button"><!-- 페이지 번호 버튼 --><!-- on: 현재 페이지 -->
				<!-- <span class="page_button_item pageButton_on" pageNumber="1">1</span>
				<span class="page_button_item" pageNumber="2">2</span>
				<span class="page_button_item" pageNumber="3">3</span>
				<span class="page_button_item" pageNumber="4">4</span>
				<span class="page_button_item" pageNumber="5">5</span>
				<span class="page_button_item" pageNumber="6">6</span>
				<span class="page_button_item" pageNumber="7">7</span>
				<span class="page_button_item" pageNumber="8">8</span>
				<span class="page_button_item" pageNumber="9">9</span>
				<span class="page_button_item" pageNumber="10">10</span> -->
				<%
					int startPageNum = 0;
					int endPageNum = startPageNum + 9;
					if(pageNum%10==0) {
						startPageNum = pageNum - 9;
						endPageNum = pageNum;
					} else {
						startPageNum = pageNum-pageNum%10 + 1;
						endPageNum = startPageNum + 9;
					}
					
					if(lastPageNum<endPageNum) {
						endPageNum = lastPageNum;
					}
					for(int i=startPageNum; i<endPageNum; i++) {
				%>
					<span class="page_button_item" pageNumber="<%=i%>"><%=i%></span>
				<%
					}
				%>
			</div>
		</div>
		<!-- 검색 필터 적용 시작 -->
		<div class="popup_search_filter" style="display: none;">
			<form>
				<div class="popup_search_filter_inner">
					<!-- 검색 필터 -->
					<div class="filter_item">
						<label for="sorting01">검색 필터</label>
						<p class="order_wrap">											<!-- YGYGYGYG -->
							<input type="radio" id="sorting01" name="sorting" value="평점순" <%=checkedSorting1%>/>
							<label for="sorting01">평점순</label>
							<input type="radio" id="sorting02" name="sorting" value="인기순" <%=checkedSorting2%>/>
							<label for="sorting02">인기순</label>
						</p>
					</div>
					<div class="filter_item">
						<label>가격/1인당</label>
						<span class="options">중복 선택 가능</span>
						<p class="cost_wrap">
							<input type="checkbox" id="cost01" name="cost" class="cost" value="만원미만" <%=checkedCost1%>/>
							<label for="cost01" class="cost01">
								<span>만원미만</span>
							</label>
							<input type="checkbox" id="cost02" name="cost" class="cost" value="1만원대" <%=checkedCost2%>/>
							<label for="cost02" class="cost02">
								<span>1만원대</span>
							</label>
							<input type="checkbox" id="cost03" name="cost" class="cost" value="2만원대" <%=checkedCost3%>/>
							<label for="cost03" class="cost03">
								<span>2만원대</span>
							</label>
							<input type="checkbox" id="cost04" name="cost" class="cost" value="3만원대" <%=checkedCost4%>/>
							<label for="cost04" class="cost04">
								<span>3만원대</span>
							</label>
							<input type="checkbox" id="cost05" name="cost" class="cost" value="4만원대" <%=checkedCost5%>/>
							<label for="cost05" class="cost05">
								<span>4만원대</span>
							</label>
						</p>
					</div>
					<input type="hidden" name="area_wrap" id="input_area_wrap"/>
					<div class="filter_item">
						<label>지역</label>
						<span class="options">중복 선택 가능</span>
						<p class="area_wrap">
							<span class="area_wrap_item <%=selectedAreaWrap1%>">서울-강남</span>
							<span class="area_wrap_item <%=selectedAreaWrap2%>">서울-강북</span>
							<span class="area_wrap_item <%=selectedAreaWrap3%>">경기도</span>
							<span class="area_wrap_item <%=selectedAreaWrap4%>">인천</span>
							<span class="area_wrap_item <%=selectedAreaWrap5%>">대구</span>
							<span class="area_wrap_item more">더보기</span>
						</p>
						<p class="metro_wrap">
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_01" name="area" value="가로수길"/>
								<label class="small" for="area01_01">
									<span>가로수길</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_02" name="area" value="강남역"/>
								<label class="small" for="area01_02">
									<span>강남역</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_03" name="area" value="강동구"/>
								<label class="small" for="area01_03">
									<span>강동구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_04" name="area" value="개포/수서/일원"/>
								<label class="small" for="area01_04">
									<span>개포/수서/일원</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_05" name="area" value="관악구"/>
								<label class="small" for="area01_05">
									<span>관악구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_06" name="area" value="교대/서초"/>
								<label class="small" for="area01_06">
									<span>교대/서초</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_07" name="area" value="구로구"/>
								<label class="small" for="area01_07">
									<span>구로구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_08" name="area" value="금천구"/>
								<label class="small" for="area01_08">
									<span>금천구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_09" name="area" value="논현동"/>
								<label class="small" for="area01_09">
									<span>논현동</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_10" name="area" value="대치동"/>
								<label class="small" for="area01_10">
									<span>대치동</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_11" name="area" value="도곡동"/>
								<label class="small" for="area01_11">
									<span>도곡동</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_12" name="area" value="동작/사당"/>
								<label class="small" for="area01_12">
									<span>동작/사당</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_13" name="area" value="등촌/강서"/>
								<label class="small" for="area01_13">
									<span>등촌/강서</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_14" name="area" value="목동/양천"/>
								<label class="small" for="area01_14">
									<span>목동/양천</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_15" name="area" value="방배/반포/잠원"/>
								<label class="small" for="area01_15">
									<span>방배/반포/잠원</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_16" name="area" value="방이동"/>  
								<label class="small" for="area01_16">
									<span>방이동</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_17" name="area" value="삼성동"/>
								<label class="small" for="area01_17">
									<span>삼성동</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_18" name="area" value="서래마을"/>
								<label class="small" for="area01_18">
									<span>서래마을</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_19" name="area" value="송파/가락"/>
								<label class="small" for="area01_19">
									<span>송파/가락</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_20" name="area" value="신사/압구정"/>
								<label class="small" for="area01_20">
									<span>신사/압구정</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_21" name="area" value="신천/잠실"/>
								<label class="small" for="area01_21">
									<span>신천/잠실</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_22" name="area" value="양재동"/>
								<label class="small" for="area01_22">
									<span>양재동</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_23" name="area" value="여의도"/>
								<label class="small" for="area01_23">
									<span>여의도</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_24" name="area" value="역삼/선릉"/>
								<label class="small" for="area01_24">
									<span>역삼/선릉</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_25" name="area" value="영등포구"/>
								<label class="small" for="area01_25">
									<span>영등포구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area01_26" name="area" value="청담동"/>
								<label class="small" for="area01_26">
									<span>청담동</span>
								</label>
							</span>
						</p>
						<p class="metro_wrap">
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_01" name="area" value="건대/군자/광진"/>
								<label class="small" for="area02_01">
									<span>건대/군자/광진</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_02" name="area" value="광화문"/>
								<label class="small" for="area02_02">
									<span>광화문</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_03" name="area" value="노원구"/>
								<label class="small" for="area02_03">
									<span>노원구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_04" name="area" value="대학로/혜화"/>
								<label class="small" for="area02_04">
									<span>대학로/혜화</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_05" name="area" value="동대문구"/>
								<label class="small" for="area02_05">
									<span>동대문구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_06" name="area" value="동부이촌동"/>
								<label class="small" for="area02_06">
									<span>동부이촌동</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_07" name="area" value="마포/공덕"/>
								<label class="small" for="area02_07">
									<span>마포/공덕</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_08" name="area" value="명동/남산"/>
								<label class="small" for="area02_08">
									<span>명동/남산</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_09" name="area" value="삼청/인사"/>
								<label class="small" for="area02_09">
									<span>삼청/인사</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_10" name="area" value="상암/성산"/>
								<label class="small" for="area02_10">
									<span>상암/성산</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_11" name="area" value="서대문구"/>
								<label class="small" for="area02_11">
									<span>서대문구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_12" name="area" value="성북구"/>
								<label class="small" for="area02_12">
									<span>성북구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_13" name="area" value="수유/도봉/강북"/>
								<label class="small" for="area02_13">
									<span>수유/도봉/강북</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_14" name="area" value="시청/남대문"/>
								<label class="small" for="area02_14">
									<span>시청/남대문</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_15" name="area" value="신촌/이대"/>
								<label class="small" for="area02_15">
									<span>신촌/이대</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_16" name="area" value="연남동"/>
								<label class="small" for="area02_16">
									<span>연남동</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_17" name="area" value="왕십리/성동"/>
								<label class="small" for="area02_17">
									<span>왕십리/성동</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_18" name="area" value="용산/숙대"/>
								<label class="small" for="area02_18">
									<span>용산/숙대</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_19" name="area" value="은평구"/>
								<label class="small" for="area02_19">
									<span>은평구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_20" name="area" value="이태원/한남동"/>
								<label class="small" for="area02_20">
									<span>이태원/한남동</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_21" name="area" value="종로"/>
								<label class="small" for="area02_21">
									<span>종로</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_22" name="area" value="중구"/>
								<label class="small" for="area02_22">
									<span>중구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_23" name="area" value="중랑구"/>
								<label class="small" for="area02_23">
									<span>중랑구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_24" name="area" value="합정/망원"/>
								<label class="small" for="area02_24">
									<span>합정/망원</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area02_25" name="area" value="홍대"/>
								<label class="small" for="area02_25">
									<span>홍대</span>
								</label>
							</span>
						</p>
						<p class="metro_wrap">
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_01" name="area" value="가평군"/>
								<label class="small" for="area03_01">
									<span>가평군</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_02" name="area" value="고양시"/>
								<label class="small" for="area03_02">
									<span>고양시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_03" name="area" value="과천시"/>
								<label class="small" for="area03_03">
									<span>과천시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_04" name="area" value="광명시"/>
								<label class="small" for="area03_04">
									<span>광명시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_05" name="area" value="광주시"/>
								<label class="small" for="area03_05">
									<span>광주시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_06" name="area" value="구리시"/>
								<label class="small" for="area03_06">
									<span>구리시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_07" name="area" value="군포시"/>
								<label class="small" for="area03_07">
									<span>군포시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_08" name="area" value="김포시"/>
								<label class="small" for="area03_08">
									<span>김포시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_09" name="area" value="남양주시"/>
								<label class="small" for="area03_09">
									<span>남양주시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_10" name="area" value="동두천시"/>
								<label class="small" for="area03_10">
									<span>동두천시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_11" name="area" value="부천시"/>
								<label class="small" for="area03_11">
									<span>부천시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_12" name="area" value="성남시"/>
								<label class="small" for="area03_12">
									<span>성남시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_13" name="area" value="수원시"/>
								<label class="small" for="area03_13">
									<span>수원시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_14" name="area" value="시흥시"/>
								<label class="small" for="area03_14">
									<span>시흥시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_15" name="area" value="안산시"/>
								<label class="small" for="area03_15">
									<span>안산시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_16" name="area" value="안성시"/>
								<label class="small" for="area03_16">
									<span>안성시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_17" name="area" value="안양시"/>
								<label class="small" for="area03_17">
									<span>안양시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_18" name="area" value="양주시"/>
								<label class="small" for="area03_18">
									<span>양주시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_19" name="area" value="양평군"/>
								<label class="small" for="area03_19">
									<span>양평군</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_20" name="area" value="여주시"/>
								<label class="small" for="area03_20">
									<span>여주시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_21" name="area" value="연천군"/>
								<label class="small" for="area03_21">
									<span>연천군</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_22" name="area" value="오산시"/>
								<label class="small" for="area03_22">
									<span>오산시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_23" name="area" value="용인시"/>
								<label class="small" for="area03_23">
									<span>용인시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_24" name="area" value="의왕시"/>
								<label class="small" for="area03_24">
									<span>의왕시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_25" name="area" value="의정부시"/>
								<label class="small" for="area03_25">
									<span>의정부시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_26" name="area" value="이천시"/>
								<label class="small" for="area03_26">
									<span>이천시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_27" name="area" value="파주시"/>
								<label class="small" for="area03_27">
									<span>파주시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_28" name="area" value="평택시"/>
								<label class="small" for="area03_28">
									<span>평택시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_29" name="area" value="포천시"/>
								<label class="small" for="area03_29">
									<span>포천시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_30" name="area" value="하남시"/>
								<label class="small" for="area03_30">
									<span>하남시</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area03_31" name="area" value="화성시"/>
								<label class="small" for="area03_31">
									<span>화성시</span>
								</label>
							</span>
						</p>
						<p class="metro_wrap">
							<span class="metro_wrap_item">
								<input type="checkbox" id="area04_01" name="area" value="인천/강화군"/>
								<label class="small" for="area04_01">
									<span>인천 강화군</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area04_02" name="area" value="인천/계양구"/>
								<label class="small" for="area04_02">
									<span>인천 계양구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area04_03" name="area" value="인천/남동구"/>
								<label class="small" for="area04_03">
									<span>인천 남동구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area04_04" name="area" value="인천/동구"/>
								<label class="small" for="area04_04">
									<span>인천 동구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area04_05" name="area" value="인천/미추홀구"/>
								<label class="small" for="area04_05">
									<span>인천 미추홀구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area04_06" name="area" value="인천/부평구"/>
								<label class="small" for="area04_06">
									<span>인천 부평구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area04_07" name="area" value="인천/서구"/>
								<label class="small" for="area04_07">
									<span>인천 서구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area04_08" name="area" value="인천/연수구"/>
								<label class="small" for="area04_08">
									<span>인천 연수구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area04_09" name="area" value="인천/옹진군"/>
								<label class="small" for="area04_09">
									<span>인천 옹진군</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area04_10" name="area" value="인천/중구"/>
								<label class="small" for="area04_10">
									<span>인천 중구</span>
								</label>
							</span>
						</p>
						<p class="metro_wrap">
							<span class="metro_wrap_item">
								<input type="checkbox" id="area05_01" name="area" value="대구/남구"/>
								<label class="small" for="area05_01">
									<span>대구 남구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area05_02" name="area" value="대구/달서구"/>
								<label class="small" for="area05_02">
									<span>대구 달서구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area05_03" name="area" value="대구/달성군"/>
								<label class="small" for="area05_03">
									<span>대구 달성군</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area05_04" name="area" value="대구/동구"/>
								<label class="small" for="area05_04">
									<span>대구 동구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area05_05" name="area" value="대구/북구"/>
								<label class="small" for="area05_05">
									<span>대구 북구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area05_06" name="area" value="대구/서구"/>
								<label class="small" for="area05_06">
									<span>대구 서구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area05_07" name="area" value="대구/수성구"/>
								<label class="small" for="area05_07">
									<span>대구 수성구</span>
								</label>
							</span>
							<span class="metro_wrap_item">
								<input type="checkbox" id="area05_08" name="area" value="대구/중구"/>
								<label class="small" for="area05_08">
									<span>대구 중구</span>
								</label>
							</span>
						</p>
						<div class="more_area"></div>
					</div>
					<div class="filter_item">
						<label>음식종류</label>
						<span class="options">중복 선택 가능</span>
						<p class="type_list_wrap">
							<input class="food" type="checkbox" id="food01" name="food" value="한식" <%=checkedFood1%>/>
							<label class="food01" for="food01">
								<span>한식</span>
							</label>
							<input class="food" type="checkbox" id="food02" name="food" value="일식" <%=checkedFood2%>/>
							<label class="food02" for="food02">
								<span>일식</span>
							</label>
							<input class="food" type="checkbox" id="food03" name="food" value="중식" <%=checkedFood3%>/>
							<label class="food03" for="food03">
								<span>중식</span>
							</label>
							<input class="food" type="checkbox" id="food04" name="food" value="양식" <%=checkedFood4%>/>
							<label class="food04" for="food04">
								<span>양식</span>
							</label>
							<input class="food" type="checkbox" id="food05" name="food" value="세계음식" <%=checkedFood5%>/>
							<label class="food05" for="food05">
								<span>세계음식</span>
							</label>
							<input class="food" type="checkbox" id="food06" name="food" value="뷔페" <%=checkedFood6%>/>
							<label class="food06" for="food06">
								<span>뷔페</span>
							</label>
							<input class="food" type="checkbox" id="food07" name="food" value="카페" <%=checkedFood7%>/>
							<label class="food07" for="food07">
								<span>카페</span>
							</label>
							<input class="food" type="checkbox" id="food08" name="food" value="주점" <%=checkedFood8%>/>
							<label class="food08" for="food08">
								<span>주점</span>
							</label>
						</p>
					</div>
					<div class="filter_item">
						<label for="parking01">주차</label>
						<p class="parking_warp">
							<input type="radio" id="parking01" name="parking" value="상관없음" <%=checkedParking1%>/>
							<label for="parking01">상관없음</label>
							<input type="radio" id="parking02" name="parking" value="주차가능" <%=checkedParking1%>/>
							<label for="parking02">가능한 곳만</label>
						</p>
					</div>
				</div>
				<div class="submit_container">
					<button class="btn cancel" type="reset">취소</button>
					<button class="btn submit" type="submit">적용</button>
				</div>
			</form>
		</div>
		<!-- right: (지도, 관련콘텐츠, 강남역 주변 지역) -->
		<div class="popular_right">
			<img class="popular_map" src="Images/img_popular_map.png"/>
			<div class="popular_relatedContent"><!-- 관련 콘텐츠 div -->
				<p class="popular_relatedContent_title">관련 콘텐츠</p>
				<div class="popular_relatedContent_list" listNumber="1">
					<img src="https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/jyeikgputreadaqu.jpg?fit=around|738:738&crop=738:738;*,*&output-format=jpg&output-quality=80"/>
					<div class="popular_relatedContent_list_info">
						<p class="popular_relatedContent_list_info_title">신논현역 맛집 베스트 50곳</p>
						<p class="popular_relatedContent_list_info_comment">"회식, 모임, 데이트 무엇이든 상관없지"</p>
					</div>
				</div>
				<div class="popular_relatedContent_list" listNumber="2">
					<img src="https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/2addb-tcbv-njolq.jpg?fit=around|738:738&crop=738:738;*,*&output-format=jpg&output-quality=80"/>
					<div class="popular_relatedContent_list_info">
						<p class="popular_relatedContent_list_info_title">강남역 맛집 베스트 80곳</p>
						<p class="popular_relatedContent_list_info_comment">"혼밥도 단체모임도 가능한 강남!"</p>
					</div>
				</div>
				<div class="popular_relatedContent_list" listNumber="3">
					<img src="https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/snhbdc3tioc_gw73.jpg?fit=around|738:738&crop=738:738;*,*&output-format=jpg&output-quality=80"/>
					<div class="popular_relatedContent_list_info">
						<p class="popular_relatedContent_list_info_title">역삼역 맛집 베스트 40곳</p>
						<p class="popular_relatedContent_list_info_comment">"간단한 혼밥부터 각종 모임까지 한방에!"</p>
					</div>
				</div>
				<div class="popular_relatedContent_list" listNumber="4">
					<img src="https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/w7-zwzc2g-85uozg.jpg?fit=around|738:738&crop=738:738;*,*&output-format=jpg&output-quality=80"/>
					<div class="popular_relatedContent_list_info">
						<p class="popular_relatedContent_list_info_title">강남 직장인 회식장소 추천 맛집 베스트 30곳</p>
						<p class="popular_relatedContent_list_info_comment">"팀장님 이번 회식 장소는 여기 어때요?"</p>
					</div>
				</div>
				<div class="popular_relatedContent_list" listNumber="5">
					<img src="https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/jyeikgputreadaqu.jpg?fit=around|738:738&crop=738:738;*,*&output-format=jpg&output-quality=80"/>
					<div class="popular_relatedContent_list_info">
						<p class="popular_relatedContent_list_info_title">신논현역 맛집 베스트 50곳</p>
						<p class="popular_relatedContent_list_info_comment">"회식, 모임, 데이트 무엇이든 상관없지"</p>
					</div>
				</div>
				<div class="popular_relatedContent_list" listNumber="6">
					<img src="https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/2addb-tcbv-njolq.jpg?fit=around|738:738&crop=738:738;*,*&output-format=jpg&output-quality=80"/>
					<div class="popular_relatedContent_list_info">
						<p class="popular_relatedContent_list_info_title">강남역 맛집 베스트 80곳</p>
						<p class="popular_relatedContent_list_info_comment">"혼밥도 단체모임도 가능한 강남!"</p>
					</div>
				</div>
				<div class="popular_relatedContent_list" listNumber="7">
					<img src="https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/snhbdc3tioc_gw73.jpg?fit=around|738:738&crop=738:738;*,*&output-format=jpg&output-quality=80"/>
					<div class="popular_relatedContent_list_info">
						<p class="popular_relatedContent_list_info_title">역삼역 맛집 베스트 40곳</p>
						<p class="popular_relatedContent_list_info_comment">"간단한 혼밥부터 각종 모임까지 한방에!"</p>
					</div>
				</div>
				<div class="popular_relatedContent_list" listNumber="8">
					<img src="https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/w7-zwzc2g-85uozg.jpg?fit=around|738:738&crop=738:738;*,*&output-format=jpg&output-quality=80"/>
					<div class="popular_relatedContent_list_info">
						<p class="popular_relatedContent_list_info_title">강남 직장인 회식장소 추천 맛집 베스트 30곳</p>
						<p class="popular_relatedContent_list_info_comment">"팀장님 이번 회식 장소는 여기 어때요?"</p>
					</div>
				</div>
				<div class="popular_relatedContent_list" listNumber="9">
					<img src="https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/jyeikgputreadaqu.jpg?fit=around|738:738&crop=738:738;*,*&output-format=jpg&output-quality=80"/>
					<div class="popular_relatedContent_list_info">
						<p class="popular_relatedContent_list_info_title">신논현역 맛집 베스트 50곳</p>
						<p class="popular_relatedContent_list_info_comment">"회식, 모임, 데이트 무엇이든 상관없지"</p>
					</div>
				</div>
				<div class="popular_relatedContent_list" listNumber="10">
					<img src="https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/2addb-tcbv-njolq.jpg?fit=around|738:738&crop=738:738;*,*&output-format=jpg&output-quality=80"/>
					<div class="popular_relatedContent_list_info">
						<p class="popular_relatedContent_list_info_title">강남역 맛집 베스트 80곳</p>
						<p class="popular_relatedContent_list_info_comment">"혼밥도 단체모임도 가능한 강남!"</p>
					</div>
				</div>
				<div class="popular_relatedContent_list" listNumber="11">
					<img src="https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/snhbdc3tioc_gw73.jpg?fit=around|738:738&crop=738:738;*,*&output-format=jpg&output-quality=80"/>
					<div class="popular_relatedContent_list_info">
						<p class="popular_relatedContent_list_info_title">역삼역 맛집 베스트 40곳</p>
						<p class="popular_relatedContent_list_info_comment">"간단한 혼밥부터 각종 모임까지 한방에!"</p>
					</div>
				</div>
				<div class="popular_relatedContent_list" listNumber="12">
					<img src="https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/w7-zwzc2g-85uozg.jpg?fit=around|738:738&crop=738:738;*,*&output-format=jpg&output-quality=80"/>
					<div class="popular_relatedContent_list_info">
						<p class="popular_relatedContent_list_info_title">강남 직장인 회식장소 추천 맛집 베스트 30곳</p>
						<p class="popular_relatedContent_list_info_comment">"팀장님 이번 회식 장소는 여기 어때요?"</p>
					</div>
				</div>
				<div class="popular_relatedContent_list" listNumber="13">
					<img src="https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/snhbdc3tioc_gw73.jpg?fit=around|738:738&crop=738:738;*,*&output-format=jpg&output-quality=80"/>
					<div class="popular_relatedContent_list_info">
						<p class="popular_relatedContent_list_info_title">역삼역 맛집 베스트 40곳</p>
						<p class="popular_relatedContent_list_info_comment">"간단한 혼밥부터 각종 모임까지 한방에!"</p>
					</div>
				</div>
				<div class="popular_relatedContent_list" listNumber="14">
					<img src="https://mp-seoul-image-production-s3.mangoplate.com/keyword_search/meta/pictures/w7-zwzc2g-85uozg.jpg?fit=around|738:738&crop=738:738;*,*&output-format=jpg&output-quality=80"/>
					<div class="popular_relatedContent_list_info">
						<p class="popular_relatedContent_list_info_title">강남 직장인 회식장소 추천 맛집 베스트 30곳</p>
						<p class="popular_relatedContent_list_info_comment">"팀장님 이번 회식 장소는 여기 어때요?"</p>
					</div>
				</div>
			</div>
			<div class="popular_hashtag_line"></div>
			<div class="popular_hashtag"><!-- 강남역 주변 지역 (해시태그) -->
				<p class="popular_hashtag_title">강남역 주변 지역</p>
				<div class="popular_hashtag_item">
					<span>강남역거리</span>
					<span>신논현역</span>
					<span>신논현역6번출구</span>
					<span>신논현역4번출구</span>
					<span>역삼역</span>
					<span>역삼역2번출구</span>
					<span>강남역11번출구</span>
					<span>강남역10번출구</span>
					<span>강남역3번출구</span>
					<span>강남역5번출구</span>
				</div>
			</div>
		</div>
		<div style="clear:both;"></div>
	</div>
	<!-- //////////////////////////푸터 시작/////////////////////////////////////////////////////////////////////////////// -->
	<div id="div_footer"><!-- footer: 하단 영역 (회사소개 등등) -->
		<div class="footer_inner">
			<div class="footer_mango_logo fl"><!-- footer_inner > div.nth-child(1) > div.nth-child(1) -->
				<img src="Images/white_mango_logo.svg"/>
				<p class="footer_mango_logo_subtitle">Eat, Share, Be Happy.</p>
			</div>
			<div class="fl"><!-- footer_inner > div.nth-child(1) > div.nth-child(2) -->
				<a>회사소개</a>
				<a>망고플레이트 채용</a>
				<a>투자 정보</a>
				<a>브랜드 가이드라인</a>
				<a>망고플레이트 비즈니스</a>
				<a>광고 문의</a>			
			</div>
			<div class="fl"><!-- footer_inner > div.nth-child(1) > div.nth-child(3) -->
				<a>공지사항</a>
				<a>이용약관</a>
				<a>비회원 이용자 이용정책</a>
				<a class="footer_bold">개인정보처리방침</a>
				<a>위치기반서비스 이용약관</a>
				<a>커뮤니티 가이드라인</a>
				<a>청소년보호정책</a>
				<a>홀릭 소개</a>
				<a>문의하기</a>
			</div>
			<div class="fr"><!-- footer_inner > div.nth-child(1) > div.nth-child(4) -->
				<img src="Images/facebook.png"/>
				<img src="Images/instagram.png"/>			
			</div>
			<div style="clear:both;"></div>
		</div>
		<div class="footer_inner"><!-- footer_inner > div.nth-child(2) -->
			인기지역 : 
			<a>이태원</a> | <a>홍대</a> | <a>강남역</a> | <a>가로수길</a> | <a>신촌</a> | <a>명동</a> | <a>대학로</a> | <a>연남동</a> 
		  	| <a>부산</a> | <a>합정</a> | <a>대구</a> | <a>여의도</a> | <a>건대</a> | <a>광화문</a> | <a>일산</a> | <a>제주</a> 
		  	| <a>경리단길</a> | <a>한남동</a> | <a>삼청동</a> | <a>대전</a> | <a>종로</a> | <a>서촌</a> | <a>잠실</a> | <a>사당역</a> 
		  	| <a>인천</a> | <a>코엑스</a> | <a>상수</a> | <a>서래마을</a> | <a>송도</a> | <a>왕십리</a> | <a>분당</a> | <a>혜화</a> | <a>고속터미널</a>
		</div>
		<div class="footer_inner"><!-- footer_inner > div.nth-child(3) -->
			<div class="fl">
				<p>㈜ 여기어때컴퍼니<br>서울특별시 강남구 봉은사로 479, 479타워 11층<br>대표이사: 정명훈<br>사업자 등록번호: 742-86-00224 
				<a class="footer_bold_small">[사업자정보확인]</a>
				<br>통신판매업 신고번호: 2017-서울강남-01779<br>고객센터: 02-565-5988<br><br>
	          	<span class="copyrights">© 2022 MangoPlate Co., Ltd. All rights reserved.</span>
        		</p>
          	</div>
          	<div class="fr">
          		<a id="footer_selected">한국어</a>  <a>English</a>  <a>简体中文</a>
          	</div>
			<div style="clear:both;"></div>
		</div>
	</div>
	<!-- //////////////////////////푸터 끝/////////////////////////////////////////////////////////////////////////////// -->
</body>
</html> --%>