<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<%@ page import="java.util.*" %>
<%@ page import="com.mango.matzip.dto.*" %>
<%@ page import="com.mango.matzip.dao.*" %>

<%
	MangoDAO Mango = new MangoDAO();
	ArrayList<MatzipHashtagDTO> matziphashtag = Mango.getHashtag();
//	ArrayList<MatzipListDTO> matziplist = Mango.getMatziplist();
	ArrayList<MatzipListDTO> matziplist = Mango.getMatziplistWithPaging(1);
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
	<title>맛집리스트 목록</title>
	<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-kr.css' rel='stylesheet' type='text/css'>
	<link rel='stylesheet' type='text/css' href='CSS/Matziplist.css'/>
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
		var pageNum = 1;	   // function들 밖에다가 선언한 자바스크립트 변수는 "전역변수"(global). 살아있다!

		$(function() {
			
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
	        
	        $(".input_search_content_keywordList").mouseenter(function() {
	        	$(this).css('background','#f7f7f7');
	        });
	        $(".input_search_content_keywordList").mouseleave(function() {
	        	$(this).css('background','#fff');
	        });
	        
	        $(document).on("click", ".input_search_content_keywordList", function() {   // 클릭시 검색어 들어감
	           var item = $(this).find(".input_search_keywordList_item").text();
	           var url_input_search = "Mango_popularSearch2.jsp?keyword="+item;
	           location.href = url_input_search;
	        });
	//헤더 인기검색어 팝업창 끝--------------------------------------------------------------------------------------
			
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
			
			
			
			
			/* $("#logo").click(function( ) {
				location.href = "http://localhost:9090/WebProject1/MangoMain.jsp";
			});
			$(".eatdeal").click(function() {
				location.href = "잇딜.jsp";
			});
			$(".matziplist").click(function() {
				location.href = "http://localhost:9090/WebProject1/Matziplist.jsp";
			});
			$(".mangostory").click(function() {
				location.href = "망고스토리.jsp";
			}); */
			/* $(".main .inner a").addClass("on"); */	// #전체에 불 어떻게 들어오게 할까?!
			$(".main .inner .hashtag").click(function(e) {		// event라서 보통 소문자 e로 해요. 
				$(".main .inner .hashtag").removeClass("on");
				e.preventDefault();    // (기본적인 동작을 막는다) --> 주로, a태그에 사용 --> 이동을 안 해요. 		
				$(this).addClass("on");
			});
			/* $(".header .fl .searchinput").click(function() {
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
			$(".suggestkeywordlist").mouseenter(function() {
				$(this).css('overflow','auto');
			});
			$(".suggestkeywordlist").mouseleave(function() {
				$(this).css('overflow','hidden');
			});
			$(".suggestkeywordlist li").mouseenter(function() {
				$(this).css('background','#f7f7f7');
				$(this).parent().parent().css('overflow','auto');
			});
			$(".suggestkeywordlist li").mouseleave(function() {
				$(this).css('background','#fff');
			}); */
			$(document).on("click", ".main .inner .list > div", function() {
				var idx = $(this).attr('idx');
				//alert("idx : " + idx);
				if(idx==121 || idx==119 || idx==23 || idx==22) {
					location.href = "http://localhost:9090/WebProject1/MatzipDetail.jsp?idx=" + idx;
				} else {
					alert("준비중입니다");
				}
			});
			/* $(".footer .inner .mango .fl #mangologo").click(function() {
				location.href = "http://localhost:9090/WebProject1/MangoMain.jsp";
			});
			$(".footer .inner .bottom .language p span#korean").click(function() {
				alert("이미 적용되어 있습니다.");
			});
			$(".footer .inner .bottom .language p span#english").click(function() {
				alert("준비중입니다.");
			});
			$(".footer .inner .bottom .language p span#chinese").click(function() {
				alert("준비중입니다.");
			}); */
			/* $("#btn_more").click(function() {
				pageNum += 1;
				//alert("더보기 눌러서 요청함 : page:" + pageNum);
				
				$.ajax({
					type: "get",
					url: "MatziplistServlet",
					data: {"page":pageNum},
					datatype: "json",
					success: function(data) {	// data <------ objFinal
						console.log(data.result);   // data.result <------ objFinal.result (JSONArray)
						if(data.result.length<20) {
							$("#btn_more").hide();
						}
						for(var i=0; i<=data.result.length-1; i++) {
							var main_img = data.result[i].main_img;
							var ment = data.result[i].ment;
							var restaurant_list = data.result[i].restaurant_list;
							var restaurant_list_idx = data.result[i].restaurant_list_idx;
							//console.log(main_img + "/" + ment + "/" + restaurant_list + "/" + restaurant_list_idx);
							var str ='';
							if(i%2==0) {   // left-side
								str = '<div class="left_list" idx="' + restaurant_list_idx + '">'
										+ '<div>'
										+ '<span class="title">' + restaurant_list + '</span>'
										+ '<p class="ment">' + ment + '</p>'
										+ '</div>'
										+ '<div class="inner" style="background: center/100% url( Images/mango/'+main_img+');"></div>'
										+ '<div class="inner" style="background-color: rgba(0,0,0,0.2);"></div>'
										+ '</div>';
							} else if(i%2!=0) {   // right-side
								str = 	'<div class="right_list fr" idx="' + restaurant_list_idx + '">'
										+ '<div>'
										+ '<span class="title">' + restaurant_list + '</span>'
										+ '<p class="ment">' + ment + '</p>'
										+ '</div>'
										+ '<div class="inner" style="background: url( Images/mango/' + main_img + ') center/100%;"></div>'
										+ '<div class="inner" style="background-color: rgba(0,0,0,0.2);"></div>'
										+ '</div>';
							}
							$('.main .list').append(str);	
						}
					},
					error: function(r,s,e) {	// Ex13.jsp 참고
						alert("에러");
					}
				});
			}); */
			// 쿠키 --------------------------------------------------------------------------------------------------
			applyRecentListFromList(arrRecent);
			// 쿠키 끝--------------------------------------------------------------------------------------------------
		});
		//var noMore = false;
		$(window).scroll(function() {
			var scrollTop = $(window).scrollTop();
			var innerHeight = $(window).height();
			var scrollHeight = $(document).height();
			if(scrollTop + innerHeight >= scrollHeight) {
				pageNum += 1;
			
			//alert("더보기 눌러서 요청함 : page:" + pageNum);
			
				$.ajax({
					type: "get",
					url: "MatziplistServlet",
					data: {"page":pageNum},
					datatype: "json",
					success: function(data) {	// data <------ objFinal
						console.log(data.result);   // data.result <------ objFinal.result (JSONArray)
						/* if(data.result.length<20) {
							$("#btn_more").hide();
						} */
						for(var i=0; i<=data.result.length-1; i++) {
							var main_img = data.result[i].main_img;
							var ment = data.result[i].ment;
							var restaurant_list = data.result[i].restaurant_list;
							var restaurant_list_idx = data.result[i].restaurant_list_idx;
							//console.log(main_img + "/" + ment + "/" + restaurant_list + "/" + restaurant_list_idx);
							var str ='';
							if(i%2==0) {   // left-side
								str = '<div class="left_list" idx="' + restaurant_list_idx + '">'
										+ '<div>'
										+ '<span class="title">' + restaurant_list + '</span>'
										+ '<p class="ment">' + ment + '</p>'
										+ '</div>'
										+ '<div class="inner" style="background: center/100% url( Images/mango/'+main_img+');"></div>'
										+ '<div class="inner" style="background-color: rgba(0,0,0,0.2);"></div>'
										+ '</div>';
							} else if(i%2!=0) {   // right-side
								str = 	'<div class="right_list fr" idx="' + restaurant_list_idx + '">'
										+ '<div>'
										+ '<span class="title">' + restaurant_list + '</span>'
										+ '<p class="ment">' + ment + '</p>'
										+ '</div>'
										+ '<div class="inner" style="background: url( Images/mango/' + main_img + ') center/100%;"></div>'
										+ '<div class="inner" style="background-color: rgba(0,0,0,0.2);"></div>'
										+ '</div>';
							}
							//if(!noMore) {
							$('.main .list').append(str);
						//}
						}
					},
					error: function(r,s,e) {	// Ex13.jsp 참고
						alert("에러");
					}
				});
			}
		});
	</script>
</head>
<body>
	<!-- <header>		header 시작
		<div class="header">		
			<div class="fr">
				<div class="right"> 
					<img id="profile" src="https://k.kakaocdn.net/dn/dpk9l1/btqmGhA2lKL/Oz0wDuJn1YV2DIn92f6DVK/img_640x640.jpg?fit=around|56:56&crop=56:56;*,*&output-format=jpg&output-quality=80"/>
				</div>
			</div>
			<div class="fr">
				<div class="mangostory">
					<span>망고 스토리</span>
				</div>
			</div>
			<div class="fr">
				<div class="matziplist">
					<span>맛집 리스트</span></a>
				</div>
			</div>
			<div class="fr">
				<div class="eatdeal">
					<span style="position: relative;">EAT딜</span>
				</div>
			</div>
			<div class="fl">
				<img id="logo" src="Images/mango/mangoplace.png" style="witdh: 100px; height: 33px;"/>
				<img id="search" src="Images/search_icon.png"/>
				<div style="clear:both;"></div>
			</div>
			<div class="fl"><input type="text" class="searchinput" name="searchkeyword" placeholder="지역, 식당 또는 음식" value autocomplete="off" maxlength="50"></div>
		</div>
	</header>
	
	
	<div class="keywordsuggester">		1번 div 시작(검색어 화면)
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
						<li>
							<span class="little_search_icon"></span>
							<span class="keyword">강남역</span>
						</li>
						<li>
							<span class="little_search_icon"></span>
							<span class="keyword">용리단길</span>
						</li>
						<li>
							<span class="little_search_icon"></span>
							<span class="keyword">유튜버추천</span>
						</li>
						<li>
							<span class="little_search_icon"></span>
							<span class="keyword">신촌</span>
						</li>
						<li>
							<span class="little_search_icon"></span>
							<span class="keyword">참치</span>
						</li>
						<li>
							<span class="little_search_icon"></span>
							<span class="keyword">성수</span>
						</li>
						<li>
							<span class="little_search_icon"></span>
							<span class="keyword">와인</span>
						</li>
					</ul>
					<ul class="popular_search">
						<li>
							<span class="little_search_icon"></span>
							<span class="keyword">홍대</span>
						</li>
						<li>
							<span class="little_search_icon"></span>
							<span class="keyword">이태원</span>
						</li>
						<li>
							<span class="little_search_icon"></span>
							<span class="keyword">신촌</span>
						</li>
						<li>
							<span class="little_search_icon"></span>
							<span class="keyword">강남역</span>
						</li>
						<li>
							<span class="little_search_icon"></span>
							<span class="keyword">가로수길</span>
						</li>
						<li>
							<span class="little_search_icon"></span>
							<span class="keyword">평택시</span>
						</li>
						<li>
							<span class="little_search_icon"></span>
							<span class="keyword">방배</span>
						</li>
					</ul>
				</div>
			</nav>
		</div>
	</div> -->
	
	
	
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
	
	
	
	
	
	<div class="main">		<!-- 2번 div 시작 -->
		<div class="inner">
			<h1>믿고 보는 맛집 리스트</h1>
			<%
				for( MatzipHashtagDTO dto : matziphashtag) {
			%>
				<a href="https://www.mangoplate.com/top_lists" class="hashtag"><%=dto.getHashtag() %></a>
			<%
			}
			%>
			
			<div class="list">
				<%
					for(int i=0; i<=matziplist.size()-1; i++) {
				%>
				<%
					if(i%2==1) {
				%>
				<div class="right_list fr" idx="<%=matziplist.get(i).getRestaurant_list_idx() %>">
					<div>
						<span class="title"><%=matziplist.get(i).getRestaurant_list() %></span>
						<p class="ment"><%=matziplist.get(i).getMent() %></p>
					</div>
					<div class="inner" style="background: url( Images/mango/<%=matziplist.get(i).getMain_img() %>) center/100%;"></div>
					<div class="inner" style="background-color: rgba(0,0,0,0.2);"></div>
				</div>
				<%
					}
				%>
				<%
					if(i==0 || i%2==0) {
				%>
				<div class="left_list" idx="<%=matziplist.get(i).getRestaurant_list_idx() %>">
					<div>
						<span class="title"><%=matziplist.get(i).getRestaurant_list() %></span>
						<p class="ment"><%=matziplist.get(i).getMent() %></p>
					</div>
					<div class="inner" style="background: center/100% url( Images/mango/<%=matziplist.get(i).getMain_img() %>);"></div>
					<div class="inner" style="background-color: rgba(0,0,0,0.2);"></div>
				</div>
				<%
				} 
				%>
				<%
					}
				%>
			</div>
			<div style="clear:both;"></div>
			<!-- <img id="btn_more" style="margin:40px 535.5px 0; cursor: pointer;" src="Images/more.png"/> -->
		</div>
	</div>		<!-- 2번 div 끝 -->
	
	<!-- <footer class="footer">			footer 시작
		<div class="inner">
			<div class="fl mango">
				<div class="fl"><img id="mangologo" src="Images/mango/mangoplace_removeback.png"/></div>
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
						<span id="korean" style="color:#fff; cursor: pointer;">한국어</span>
						<span id="english" style="cursor: pointer;">English</span>
						<span id="chinese" style="cursor: pointer;">简体中文</span>
					</p>
				</div>
				<p style="font-size:14px; color:#9b9b9b; margin: 0 0;">
				 ㈜ 여기어때컴퍼니</br>서울특별시 강남구 봉은사로 479, 479타워 11층</br>대표이사: 정명훈</br>사업자 등록번호: 742-86-00224 <a href="https://www.ftc.go.kr/bizCommPop.do?wrkr_no=7428600224">[사업자정보확인]</a></br>
				 통신판매업 신고번호: 2017-서울강남-01779</br>고객센터: 02-565-5988</br></br>© 2022 MangoPlate Co., Ltd. All rights reserved.
				</p>
			</div>
		</div>
	</footer> -->		<!-- footer 끝 -->
</body>
</html>
































