<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mango.dao.MangoStoryContentDao2"%>
<%@ page import="com.mango.dto.MangoStoryDetailDto"%>
<%@ page import="com.mango.dto.MangoContentViewMoreListDto"%>
<%@ page import="com.mango.dto.MangoContentInStoryListDto"%>
<%@ page import="com.mango.dto.MangoStoryDetailContentDto"%>

<%
	int loginMemberNumber = 6;   // 너는 채원이. (testing ---> 세션에서 읽어와야 함. TODO.)
%>
<%
	int storyId = 0;
	try {
		storyId = Integer.parseInt( request.getParameter("story_id") ); 
	} catch(NumberFormatException e) { 
		e.printStackTrace();
%>
		<script>alert("주의!!!!!! story_id가 없음!!!!!!!");</script>
<%
	}

	MangoStoryContentDao2 mcDao = new MangoStoryContentDao2();
	MangoStoryDetailDto dto = mcDao.getDetailMangoFromStoryId(storyId);
	
	if(dto == null)
		System.out.println("dto가 널이다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
%>
<%

	String paramShowFilter = request.getParameter("filter_applied");  // "true" or "false"
	//String paramTopkeyword = request.getParameter("topkeyword");
	
	String strCookieRecentSearch = "";
		//----------------------------------------------------------------------------------
		// add cookie.
		Cookie[] cookies = request.getCookies();
		if(cookies!=null) {
			for(Cookie c : cookies) {
				if("recent_search".equals(c.getName())) {
					strCookieRecentSearch = c.getValue();
				}
			}	
		}
		if(strCookieRecentSearch!=null && strCookieRecentSearch.length()>0 && strCookieRecentSearch.charAt(0)=='_')
			strCookieRecentSearch = strCookieRecentSearch.substring(1);
	System.out.println("strCookieRecentSearch : " + strCookieRecentSearch);
		//----------------------------------------------------------------------------------
%>
<script>
	// 쿠키
	function applyRecentListFromList(arr) {
		if(arr.length==0) {
			$(".small_history_search").html('<span class="input_search_keywordList_item_none">최근 검색어가 없습니다.</span>');			
		} else {
			$(".small_history_search").html('');
		}
		
		for(var i=0; i<=arr.length-1; i++) {
			var str = '<div class="input_search_content_keywordList">'
					+'<span class="keywordList_item_img"></span>'
					+'<span class="input_search_keywordList_item">'+arr[i]+'</span>'
					+'</div>';
			$(".small_history_search").append(str);
		}
	}
</script>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>망고스토리 디테일 - 전국 24시간 영업 맛집 10곳</title>
	<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-kr.css' rel='stylesheet' type='text/css'><!-- 망고폰트 -->
	<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'><!-- 망고폰트 -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/font-applesdgothicneo@1.0/all.min.css"><!-- APPLE SD Gothic NEO -->
	<link rel='stylesheet' type='text/css' href='CSS/Mango_storyContent2.css'/>
	<script src="https://code.jquery.com/jquery-3.6.2.js" integrity="sha256-pkn2CUZmheSeyssYw3vMp1+xyub4m+e+QK4sQskvuo4=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.10/clipboard.min.js"></script>
	<script>
	
// 쿠키 ------------------------------------------------------------------------------
<%
		String str_making_array2 = "";
		if(strCookieRecentSearch.length()>0) {
			//for(String s : strCookieRecentSearch.split("_")) {
			for(int i=0; i<=strCookieRecentSearch.split("_").length-1; i++) {
				str_making_array2 += "'" + strCookieRecentSearch.split("_")[i] + "'";
				if(i<strCookieRecentSearch.split("_").length-1) {
					str_making_array2 += ",";
				}
			}
		}
%>
		var arrRecent = [<%=str_making_array2%>];   // "'방배1','방배2','방배3','방배4'"
// 쿠키 끝------------------------------------------------------------------------------

		
		$(function() {
			$(".contentName").click(function() {	// 컨텐트 식당 이름
				location.href = "mango_details.jsp?detailPk="+Number($(this).attr('plateid'));
			});
			
			$(".content_moreView_item").click(function() {	// 다른 스토리 더보기
				location.href = "Mango_storyContent2.jsp?story_id="+Number($(this).attr('storyid'));
			});
			
			$(".content_inStory_content_fl").click(function() { // 스토리 속 식당
				var plate_id = Number($(this).find(".content_inStory_img").attr('plateid'));
				location.href = "mango_details.jsp?detailPk="+Number(plate_id); // NaN 해결
			
			});
			
			$(".content_inStory_wannago").click( function(){	// 스토리 속 식당 > 가고싶다 별
			
	            idx = $(".content_inStory_wannago").index($(this));
	            
	            $(".content_inStory_wannago").each(function(wannago_idx,obj) {
	               if(idx==wannago_idx) {
	                  $(this).toggleClass('wannago_on');	
	               }
	            });
	         });
			
			$("#bookmark").click(function() {
				alert("가고싶다!");
			});
			
			$("#shareicon").click(function() {
				if(!$(this).hasClass("shareView_show")) {
					$(".shareView").addClass("shareView_show");
					$(this).addClass("shareView_show");
				}
			});
			$(".shareView_closeIcon").on("click",function(){
				$(".shareView").removeClass("shareView_show");
				$("#shareicon").removeClass("shareView_show");
			});
			
			$("#btn_share").text(window.document.location.href);
			
			// clipboard API.
	        var clipboard = new ClipboardJS('.copy_btn');
	      
	        clipboard.on('success', function(e) {
	            alert("URL이 클립보드에 복사되었습니다.");
	        });
	      
	        clipboard.on('error', function(e) {
	            alert("error:" + e);
	        });
	        
			$("#div_header > .header_right").eq(3).find("span").click(function() {
				alert("EAT딜 이동!");
				location.href = "Mango_eatDeal.jsp";
			});
			
			$("#div_header > .header_right").eq(2).find("span").click(function() {
				alert("맛집 리스트 이동!");
				location.href = "Matziplist.jsp";
			});
			
			$("#div_header > .header_right").eq(1).find("span").click(function() {
				alert("망고 스토리 이동!");
				location.href = "Mango_storyList.jsp";
			});
			
			$("#img_logo").click(function() {
				alert("망고플레이트 이동!");
				location.href = "MangoMain.jsp"
			});

// 헤더 인기검색 팝업창 시작--------------------------------------------------------------------------------
			$(".input_search_backgroundDark").click(function() {
				$(this).parent().removeClass("open");
			}); 
			
			$("#Input_search").click(function() {
				$(".input_search_keyword").addClass("open");
			});
			
			$(".input_search_item").click(function() {
				idx = $(".input_search_item").index($(this));
				
				$(".input_search_item").each(function(select_idx,obj) {
					if(idx==select_idx) {
						$(this).addClass("select inputSearchItem_tapButton-selected");
					} else {
						$(this).removeClass("select inputSearchItem_tapButton-selected");
					}
				});
			});
			
			$(".input_search_content_keywordList").mouseenter(function() {
	              $(this).css('background','#f7f7f7');
	           });
	           $(".input_search_content_keywordList").mouseleave(function() {
	              $(this).css('background','#fff');
	           });
	           
			$(".keyword_recommended").click(function() {
				$(".small_popular_search").css('display','none');
				$(".small_history_search").css('display','none');
				$(".small_recommended_search").css('display','block');
			});
			
			$(".keyword_popular").click(function() {
				$(".small_recommended_search").css('display','none');
				$(".small_history_search").css('display','none');
				$(".small_popular_search").css('display','block');
			});
			
			$(".keyword_history").click(function() {
				$(".small_recommended_search").css('display','none');
				$(".small_popular_search").css('display','none');
				$(".small_history_search").css('display','block');
			});
			
			// 스크롤
			$(".keywordListWrap_inner").mouseenter(function() {
				$(this).css('overflow','auto');
			});
			
			$(".keywordListWrap_inner").mouseleave(function() {
				$(this).css('overflow','hidden');
			});
			
			$(".small_popular_search").css('display','none');
			$(".small_history_search").css('display','none');
			$(".small_recommended_search").css('display','block');
			
			// 엔터키이벤트 엔터를 누르면 발생
			$("#Input_search").keypress(function(e) { // 입력시 검색어 들어감
			    if (e.keyCode == 13){	
			        var url_input_search = "Mango_popularSearch2.jsp?keyword="+$("#Input_search").val().replace(" ","_");
			        location.href = url_input_search;
			    }    
			});
			
			$(document).on("click", ".input_search_content_keywordList", function() {	// 클릭시 검색어 들어감
				var item = $(this).find(".input_search_keywordList_item").text();
		        var url_input_search = "Mango_popularSearch2.jsp?keyword="+item;
		        location.href = url_input_search;
			});
// 헤더 인기검색어 팝업창 끝--------------------------------------------------------------------------------------
// 쿠키 --------------------------------------------------------------------------------------------------
			applyRecentListFromList(arrRecent);
// 쿠키 끝--------------------------------------------------------------------------------------------------
		});
	</script>
</head>
<body>
	<!-- ///////////////////////////  헤더 시작   ////////////////////////////////////////////////// -->
	<!-- nth child(1) 헤더(로고..검색..등등) -->
	<div id="div_header">
		<div class="fl"><!-- (1)헤더 왼쪽 망고플레이스 로고 -->
			<img id="img_logo" src="Images/mangoplace_logo.png"/>
		</div>
		<div class="fl"><!-- (2)헤더 왼쪽 서치아이콘 -->
			<img id="img_search" src="Images/img_searchicon.png"/>
			<label for="Input_search">
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
	<div class="input_search_keyword">	<!-- 검색어 클릭 이벤트 발생시 나오는 창 -->
		<div class="input_search_backgroundDark"></div>		<!-- $("#input").css({display:"none"}); -->
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
	<!-- ///////////////////////////  헤더 끝   ////////////////////////////////////////////////// -->
	<div id="div_container" class="flex">
		<div><!-- nth child(2) 디테일 메인창(메인이미지,에디터이름,타이틀,서브타이틀,작성일,조회수) -->
			<div class="detail_left">
				<div class="detail_mainImg">
					<img src="Images/detail/MangoStoryDetail/<%=dto.getMain_img()%>"/>
					<span class="main_source"><%=dto.getMain_source() != null ? dto.getMain_source() : "" %></span><!-- 메인 이미지 소스 (&nbsp;) -->
				</div>
				<div class="detail_header">
					<div class="storyHeader">
						<div class="storyHeader_editor">
							<img src="Images/img_editor.svg"/><span><%=dto.getMember_id() %></span>
						</div>
						<div class="storyHeader_ActiveButtons">
							<img id="bookmark" src="Images/img_bookmark.svg"/>
							<img id="shareicon" src="Images/img_shareicon.svg"/>
						</div>
					</div>
	 				<h1 class="title"><%=dto.getStory_title() %></h1>
					<p class="subtitle"><%=dto.getStory_subtitle() %></p>
					<div class="DateAndView">
						<span class="write_date"><%=dto.getWrite_date().substring(0,10) %></span>
						<img src="Images/img_hitcounticon.svg"/>
						<span class="hitcount"><%=dto.getHitcount() %></span>
					</div>
				</div>
			</div>
		</div>
		<div><!-- nth-child(3) 컨텐츠창(디테일 메인: gif이미지1,gif내용1, 디테일 컨텐츠: 식당지역,식당이름,컨텐트이미지1-2,이미지소스1-2,컨텐트텍스트1-2, 디테일 메인: gif이미지2,gif내용2)-->
			<div class="detail_right">
				<div class="gif">
					<img src="Images/detail/MangoStoryDetail/<%=dto.getGif_img1()%>"/>
					<p><%=dto.getGif_text1() %></p>
					<img id="dotdotdot" src="Images/img_dotdotdot.svg"/>
					<span class="gif1_source"><%=dto.getGif_source1() != null ? dto.getGif_source1() : "" %></span><!-- gif1 소스 (&nbsp;) -->
				</div>
				<%
				for(MangoStoryDetailContentDto cDto : dto.getListContentDto()) {
					String area = cDto.getPlate_name().split("_")[0];       // 지역
					String plateName = cDto.getPlate_name().split("_")[1];	// 식당이름

				%>
					<div class="content">
						<div class="contentName" plateid="<%=mcDao.getPlateIdFromPlateName(plateName)%>">
							<span class="content_area"><%=area %></span>
							<p class="content_name"><%=plateName %></p>
							<img id="InfoButton" src="Images/Content_RestaurantInfoButtonIcon.svg"/>
						</div>
						<div class="content_img">
							<img class="content_img1" src="Images/detail/MangoStoryDetail/<%=cDto.getContent_img1()%>"/>
							<span class="content_img1_source"><%=cDto.getImg_source1() %></span><!-- content_img1 소스 없을경우(MangoPlate) -->
						</div>
						<p class="content_text1"><%=cDto.getContent_text1() %></p>
						<div class="content_img">
							<img class="content_img2" src="Images/detail/MangoStoryDetail/<%=cDto.getContent_img2()%>"/>
							<span class="content_img2_source"><%=cDto.getImg_source2() %></span><!-- content_img1 소스 -->
						</div>
						<p class="content_text2"><%=cDto.getContent_text2() %></p>
						<img id="dotdotdot" src="Images/img_dotdotdot.svg"/>
					</div>
				<%
				}
				%>
				<div class="gif">
					<img id="gif2" src="Images/detail/MangoStoryDetail/<%=dto.getGif_img2()%>"/>
					<p><%=dto.getGif_text2() %></p>
					<span class="gif_source2"><%=dto.getGif_source2() != null ? dto.getGif_source2() : "" %></span><!-- gif1 소스 (&nbsp;) -->
				</div>
				
				<div class="content_inStory">
					<h2 id="content_inStory_title">스토리 속 식당</h2>
					<%				
					for(MangoContentInStoryListDto inDto : mcDao.getInStoryListFromStoryId(storyId, loginMemberNumber)) {
					%>
						<div class="content_inStory_content">
							<div class="content_inStory_content_fl">
								<div class="content_inStory_img" plateid="<%=inDto.getPlate_id()%>">
									<!-- 식당디테일페이지의 첫번째 사진 -->
									<img src="Images/detail/MangoStoryDetail/<%=inDto.getContent_img1()%>"/>
								</div>
								<div class="content_inStory_areaAndName" plateid="<%=inDto.getPlate_id()%>">
									<p id="content_inStory_area"><%=inDto.getArea() %></p>
									<p id="content_inStory_Name"><%=inDto.getPure_plate_name() %></p>
								</div>
							</div>
							<div class="content_inStory_content_fr">
								<% if(mcDao.getWishFromMemberNumberAndPlateId(loginMemberNumber, inDto.getPlate_id())) { %>
									<div class="content_inStory_wannago">
										<img src="Images/img_WannagoColorIcon.svg"/> <!-- 채워진 별 가정 -->
									</div>
								<% } else { %>
									<div class="content_inStory_wannago">
										<img src="Images/img_WannagoIcon.svg"/> <!-- 안 채워진 별 가정 -->
									</div>
								<% } %>
							</div>
						</div>
					<%
					}
					%>
				</div>
				<div class="content_moreView">
					<h3>다른 스토리 더 보기</h3>
					<%
					for(MangoContentViewMoreListDto viewMoreDto : mcDao.getListViewMoreMangoFromStoryId(storyId)) {
					%>
						<div class="content_moreView_item" storyid="<%=viewMoreDto.getStory_id()%>">
							<div> <!-- style="float:left;" -->
								<div class="content_moreView_item_img" style="background-image:url(Images/detail/MangoStoryDetail/<%=viewMoreDto.getMain_img()%>)">
									<!-- <img src="https://mp-seoul-image-production-s3.mangoplate.com/mango_pick/full/o_q5otjup1ixpv.png?fit=around|412:216&crop=412:216;*,*&output-format=jpg&output-quality=80"/> -->
								 </div>
								 <div class="content_moreView_item_title">
									<span><%=viewMoreDto.getStory_title() %></span>
								 </div>
							 </div>
						</div>
					<%
					}
					%>
					<div style="clear:both;"></div>
				</div>
			</div>
		</div>
		<div class="shareView">
			<div class="shareView_wrap">
				<div class="shareView_close">
					<span class="shareView_closeIcon"></span>
				</div>
				<div class="shareView_header">
					<p class="shareView_title">친구에게 공유해보세요.</p>
				</div>
				<div class="shareView_itemList">
					<div class="shareView_item">
						<img src="Images/content_share_kakao.png"/>
						<span class="shareView_item_name">카카오톡</span>
					</div>
					<div class="shareView_item">
						<img src="Images/content_share_line.png"/>
						<span class="shareView_item_name">라인</span>
					</div>
					<div class="shareView_item">
						<img src="Images/content_share_url.svg"/>
						<span id="btn_share" class="shareView_item_name" style="position: absolute; z-index: -111111; opacity: 0;" ></span>
						<!-- <textarea id="textArea">URL복사</textarea> -->
    					<button class="copy_btn" data-clipboard-target="#btn_share" style="all: unset;">URL</button>
					</div>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
	</div>
	<!-- //////////////////////////푸터 시작/////////////////////////////////////////////////////////////////////////////// -->
	<div id="div_footer"><!-- footer: 하단 영역 (회사소개 등등) -->
		<div class="footer_inner">
			<div class="footer_mango_logo fl"><!-- footer_inner > div.nth-child(1) > div.nth-child(1) -->
				<img src="Images/white_mangoplace_logo.png"/>
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
		</div>
	</div>
	<!-- //////////////////////////푸터 끝/////////////////////////////////////////////////////////////////////////////// -->
</body>
</html>