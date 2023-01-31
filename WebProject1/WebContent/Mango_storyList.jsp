<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.mango.dto.MangoStoryListDto"%>
<%@ page import="com.mango.dao.MangoStoryListDao"%>

<%
	/* int storyListPageNumber = 1;
	try {
		storyListPageNumber = Integer.parseInt(request.getParameter("storyListPageNumber"));
	} catch(NumberFormatException e) { } */
%>
<%
	MangoStoryListDao slDao = new MangoStoryListDao();
	//ArrayList<MangoStoryListDto> slDto = slDao.getListMangoFromStoryPage(storyListPageNumber);
	ArrayList<MangoStoryListDto> slDto = slDao.getListMangoFromStoryPage(1);
%>
<%
	// 여기부터 쿠키쿠키 ------------------------------------------------------------------------------
	String strCookieRecentSearch = "";
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
	// 여기까지 쿠키쿠키 ------------------------------------------------------------------------------
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>망고플레이트 스토리 - 당신을 위해 엄선한 추천 맛집</title>
	<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'><!-- 망고폰트 -->
	<link rel='stylesheet' type='text/css' href='CSS/Mango_storyList.css'/>
	<script src="https://code.jquery.com/jquery-3.6.2.js" integrity="sha256-pkn2CUZmheSeyssYw3vMp1+xyub4m+e+QK4sQskvuo4=" crossorigin="anonymous"></script>
	<script>
		// 여기부터 쿠키쿠키 ------------------------------------------------------------------------------
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
		// 여기까지 쿠키쿠키 ------------------------------------------------------------------------------
		// 여기부터 쿠키쿠키 ------------------------------------------------------------------------------
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
		// 여기까지 쿠키쿠키 ------------------------------------------------------------------------------

	</script>
	<script>
		var storyListPageNumber = 1;	// function들 밖에다가 선언한 자바스크립트 변수는 "전역변수"(global). 살아있다!
		var test_global;
		
		$(function() {
			<%-- var page_number = <%=storyListPageNumber%>; --%>
			
			$(".monthly_list_item, #div_monthly").click(function() {	// monthly story에 로케이션 적용
				location.href = "Mango_storyContent2.jsp" + "?story_id="+Number($(this).attr('storyid'));
			});
			
			
			$(".list_item").click(function() { 
				location.href="Mango_storyContent2.jsp?story_id="+Number($(this).attr('storyid'));
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
				alert("망고플레이트 이동!")
				location.href = "Mango_home.jsp"
			});
			
			$("#searchkeyword, #searchsubkeyword").keydown(function(key) {	// 콤마로 구분
				if( key.keyCode == 13 ){
					alert("엔터키발생")
					console.log('Enter');
					location.href = "Mango_popularSearch.jsp?searchkeyword="+Number($(this).attr('searchkeyword'));
				}
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

			$(document).on("click",".storyList_wrap > .list_item", function() {
				var idx = $(this).attr('storyid');
				alert("idx : " + idx);
				location.href = "Mango_storyList.jsp" + "?story_id=" + idx;  
			});
			
			$(".btn_more").click(function(){
				storyListPageNumber += 1;
				alert(storyListPageNumber);
				
				var noMore = false;
				
			});
			//↓이거 내렸음
			$(window).scroll(function(){
			    var scrollTop = $(window).scrollTop();
			    var innerHeight = $(window).height();
			    var scrollHeight = $(document).height();
			    if (scrollTop + innerHeight >= scrollHeight) {   // YGYGYGYG
			    	storyListPageNumber += 1;
					//console.log("요청 : " + storyListPageNumber);	 
					$.ajax({
						type: "get",
						url: "MangoStoryListServlet",
						data: {"storyListPageNumber":storyListPageNumber},
						datatype: "json",
						success: function(data) {	// (data)<----- objFinal
							test_global = data.result;	// [object Object] 전역변수 선언해서 데이터값 볼수있음.
							//console.log(data.result);	// data.result <------- objFinal.result (JSONArray)
							var last_page_number = data.last_storyListPageNumber;
							/* if(storyListPageNumber==last_page_number) { ... } */
							if(data.result.length<20) {
								$(".btn_more").hide();
							}
							if(data.result.length==0) {
								storyListPageNumber -= 1;
							}
							for(var i=0; i<=data.result.length-1; i++) {
								var story_id = data.result[i].story_id;
								var main_img = data.result[i].main_img;
								var story_title = data.result[i].story_title;
								var story_subtitle = data.result[i].story_subtitle;
								var member_img = data.result[i].member_img;
								var member_id = data.result[i].member_id;
								var recommended_review = data.result[i].recommended_review;
								//console.log(main_img + "/" + story_title + "/" + story_subtitle + "/" + member_img + "/" + member_id + "/" + recommended_review);
								//앞에 추가: prepend() vs 뒤에 추가: append() storyList_wrap
								var str ='';
								str += '<div class="list_item" storyid="'+story_id+'">'
										+ '<img src="Images/StoryList/' + main_img + '"/>'
										+ '<strong class="title">' + story_title + '</strong>'
										+ '<p class="subtitle">' + story_subtitle + '</p>'
										+ '<span class="badge"></span>'
										+ '<div class="profile">'
										+ '<img src="Images/profile/' + member_img + '"/>'
										+ '</div>'
										+ '<div class="profilename">' + member_id + '</div>'
										+ '<span class="comment_img"></span>'
										+ '<p class="comment">' + recommended_review + '</p>'
										+ '<p class="comment_name">' + member_id + '</b></p>'
										+ '</div>';
								$('.storyList_wrap').append(str);
							}
						},
						error: function(r,s,e) {
							alert("에러!");
						}
					});
				
			    }
			});
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
	<!-- nth child(2) 상단 메인 스토리 -->
	<%
		int monthlyStoryId = 15;    // 이걸 맨 위로 옮기시는 게 좋아요!!
//		다오.getMonthlyTitleByStoryId(monthlyStoryId) ------> "[11월 월간망고] 망고걸이 대신 가본 ＜보보식당＞"
					// select title from ________ where story_id=?;
//		다오.getMonthlySubtitleByStoryId(monthlyStoryId) -------> "압구정에서 경험하는 수준급의 모던 중식!"
					// select subtitle from ________ where story_id=?;

	%>
	<div class="monthly_list_item_img">
		<div class="monthly_list_item" storyid="<%=monthlyStoryId%>" style="background-image: url(Images/StoryList/<%=slDao.getMonthlyMainImgByStoryId(monthlyStoryId)%>);"></div>
	</div>
	<div class="div_monthly" storyid="<%=monthlyStoryId%>"><!-- nth child(3) Monthly 글씨 적용, story_id="15" -->											<!-- YGYGYGYG -->
		<strong class="monthly_title"><%=slDao.getMonthlyTitleByStoryId(monthlyStoryId)%></strong>
		<p class="monthly_subtitle"><%=slDao.getMonthlySubtitleByStoryId(monthlyStoryId)%></p>
	</div>
	<div class="storyList_title"><!-- nth child(4) h1 리스트 타이틀 제목 -->
		<h1>에디터 입맛별 맛집 매거진</h1>
	</div>
	<div class="storyList_wrap"> <!-- nth child(5) 에디터 입맛별 맛집 매거진 리스트 -->
		<%
		for(MangoStoryListDto dto : slDto) {
			/* if(storyid!=15) { */
		%>
			<div class="list_item" storyid="<%=dto.getStoryId()%>">
				<img src="Images/StoryList/<%=dto.getMainImg()%>"/>
				<strong class="title"><%=dto.getStoryTitle() %></strong>
				<p class="subtitle"><%=dto.getStorySubtitle() %></p>
				<span class="badge"></span>
				<div class="profile">
					<img src="Images/profile/<%=dto.getMemberImg()%>"/>
				</div>
				<div class="profilename"><%=dto.getMemberId() %></div>
				<span class="comment_img"></span>
				<p class="comment">
					<%=dto.getRecommendedReview() %>
				</p>
				<p class="comment_name"><b><%=dto.getMemberId() %></b></p>
			</div>
		<%
			/* } */
		}
		%>
	</div>
	<div style="clear:both;"></div>
	<%--
	<div class="storyList_more"> <!-- (6)더보기 아이콘 -->
		<img class="btn_more" src="Images/icon_moreview.png"/>
		<p class="btn_more">더보기</p>
		<img class="btn_more" src="Images/icon_moreview.png"/>
	</div>
	--%>
</body>
</html>