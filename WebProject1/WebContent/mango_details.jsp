<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<%@ page import="java.util.*" %>    
<%@ page import="com.mango.details.dto.*" %>    
<%@ page import="com.mango.details.dao.*" %>

<%
int detailPk = Integer.parseInt( request.getParameter("detailPk") );
int pageNum = 1;
int tasty = 5;
int number = 181;
String email = (String)session.getAttribute("loginEmail");

System.out.println(" email : " + email);
	/* try{
		bno = Integer.parseInt( request.getParameter("bno") );
	}catch(NumberFormatException e){ 
		System.out.println("잘못된 접근 bno : " + bno);
	} 
	*/
	mangoDetailsDAO mangoDAO = new mangoDetailsDAO();
	mangoDetailsDTO DetailList = mangoDAO.getBoardDetailByBno(detailPk);
	mangoReviewDetailDTO reviewDetailList = mangoDAO.getReviewDetail(detailPk,number);
	ArrayList<MenuDTO> menuList = mangoDAO.getMenuList(detailPk);
	ArrayList<mangoDetailsTopReviewDTO> topReviewList = mangoDAO.getDetailsTopReview(detailPk);
	ArrayList<mangoReviewDTO> reviewList = mangoDAO.getDetailReviewBoard(detailPk,pageNum);
	ArrayList<mangoReviewDTO> tastyList = mangoDAO.getDetailReviewTasty(detailPk,pageNum,tasty);
	ArrayList<mangoDetailsRelatedDTO> relatedList = mangoDAO.getRelatedRestaurant(detailPk);
	ArrayList<mangoDetailsRelatedStoryDTO> storyList = mangoDAO.getRelatedStory(detailPk);
	ArrayList<mangoDetailsRelatedTopDTO> topList = mangoDAO.getRelatedRestaurantTop(detailPk);
	ArrayList<mangoDetailsMenuDTO> menuImgList = mangoDAO.getMenuContent(detailPk);
	ArrayList<mangoDetailsNearDTO> nearList = mangoDAO.getNearbyPopularRestaurants(detailPk);
	ArrayList<Integer> countList = mangoDAO.getReviewCount(detailPk);
	
	
System.out.println("reviewList.size: " + reviewList.size());
//System.out.println("reviewList size : " + storyList.size());
int tastyGood = 0;
int tastyNotBad = 0;
int tastyBad = 0;
	for(Integer t : countList){
		if(t == 1){tastyBad++;}
		if(t == 3){tastyNotBad++;}
		if(t == 5){tastyGood++;}
	}
%>	
<%
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

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>망고 상세 페이지</title>
	<link rel="icon" href="Images/profile/mango_favicon.png">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
	<link rel="stylesheet" href="CSS/mango_details.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ed05170950c386674ae9f4fdd636dcf0"></script>
	<script>
		var current_slide=0;
		var pageNum = 1;
		var tastyLike = 0;
		var detailPk = 71;
		var mNumber = 0;
		var tastyGood = <%=tastyGood%>;
		var tastyNotBad = <%=tastyNotBad%>;
		var tastyBad = <%=tastyBad%>;
		var data_global_yg;
		function showNewContentWithNewIndex(newIndex) {
			// arrayMenuComent[newIndex]
			// arrayMenuUpdateDate[newIndex]
			//alert("newIdx : " + newIndex);
			$(".img_area_content_content > div:nth-child(1)").text(arrayMenuComent[newIndex]);
			$(".img_area_content_content > div:nth-child(2)").text(arrayMenuUpdateDate[newIndex]);
		}
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
		$(function(){
			
			 $("#div_header > .header_right").eq(3).find("span").click(function() {
		            //alert("EAT딜 이동!");
		            location.href = "eat_deal_main.jsp";
		         });
		         
		         $("#div_header > .header_right").eq(2).find("span").click(function() {
		           // alert("맛집 리스트 이동!");
		            location.href = "Matziplist.jsp";
		         });
		         
		         $("#div_header > .header_right").eq(1).find("span").click(function() {
		           // alert("망고 스토리 이동!");
		            location.href = "Mango_storyList.jsp";
		         });
		         
		         $("#img_logo").click(function() {
		           // alert("망고플레이트 이동!");
		            location.href = "MangoMain.jsp"
		         });
		///////////////////////////////////////////////////////////////
			applyRecentListFromList(arrRecent);
			$(document).on("click",".user_review_img_wrap > img , .user_review_img_wrap > span ",function(){
				var Mnumber = $(this).parent().parent().parent().parent().attr("mnum");
				/* idx = $(".user_review_img").index($(this)); */
				
				$(".user_review_img_big").css({ display:"block"});
				$(".black_screen").css({ display:"block"});
				$("body").css("overflow-y","hidden");
				
				//console.log(Mnumber);
				$.ajax({
					type:"GET",
					url:"mangoReviewBxsliderServlet",
					data:{"plate_id" : 71,"Mnumber" : Mnumber},
					dataType: "json",
					success: function(data){ 
						$('.user_review_img_big').html("");
						for(var i=0; i<=data.result.length-1; i++){
							var name = data.result[i].name;
							var area = data.result[i].area;
							var memberName = data.result[i].memberName;
							var memberImg = data.result[i].memberImg;
							var writeCount = data.result[i].writeCount;
							var followCount = data.result[i].followCount;
							var idx = data.result[i].idx;
							var id = data.result[i].id;
							var memberNumber = data.result[i].memberNumber;
							var img = data.result[i].img.split(",,,");
							var coment = data.result[i].coment;
							var writeDate = data.result[i].writeDate;
							var tasty = data.result[i].tasty;
							var str = '';
							str += '<div class="img_area">'
							 	  +'<div class="img_area_wrap">'
							 	  +'<div class="img_area_img">';
									for(var i=0; i<=img.length-1; i++) {
										str += '<div><img src="Images/Detail_Review_Img/'+ img[i] +'"></div>';
									} 
							str += '</div>'
								  +'<div class="img_area_button">'
								  +'</div>'
								  +'<div class="img_area_small">'
								  +'<div class="img_area_small_img" id="bx_pager3">';
								  for(var y=0; y<=img.length-1; y++){
							str	+= '<a data-slide-index="'+y+'" href=""><div class="fl img_area_small_img_dark" style="background-image: url(Images/Detail_Review_Img/'+ img[y] +');"></div></a>';
								  }
							str	+= '<div style="clear:both"></div>'
								  +'</div>'
								  +'</div>'
								  +'</div>'
								  +'<div class="img_area_content">'
								  +'<div class="img_area_content_title"><span>'+name+'</span></div>'
								  +'<div class="img_area_user_items">'
								  +'<div class="user_header">'
								  +'<div class="fl user_header_img" style="background-image:url(Images/Member_Img/'+memberImg+')"></div>'
								  +'<div class="fl user_header_items_wrap">'
								  +'<div class="user_header_items">'
								  +'<div class="user_header_name">'+memberName+'</div>'
								  +'<div class="user_header_level"></div>'
								  +'</div>'
								  +'<div class="fl user_header_stat">'
								  +'<div class="fl review_icon"></div>'
							   	  +'<span class="fl user_count">'+writeCount+'</span>'
								  +'<div class="fl follow_icon"></div>'
								  +'<span class="fl user_count">'+followCount+'</span>'
								  +'<div style="clear:both"></div>'
								  +'</div>'
								  +'</div>'	
								  if(tasty==5){
										str+='<div class="fr tasty_like_wrap">'
										  +'<div class="user_header_tasty_good"></div>'
										  +'<div class="user_header_review_like">맛있다</div>'
										  +'</div>';
									}else if(tasty==3){
										str+='<div class="fr tasty_like_wrap">'
											+'<div class="user_header_tasty_notbad"></div>'
											+'<div class="user_header_review_like">괜찮다</div>'
											+'</div>';
									}else if(tasty==1){
										str+='<div class="fr tasty_like_wrap">'
											+'<div class="user_header_tasty_bad"></div>'
											+'<div class="user_header_review_like">별로다</div>'
											+'</div>';
									}
							str += '<div style="clear:both"></div>'
								  +'</div>'
								  +'</div>'
								  +'<div class="img_area_content_content">'
								  +'<div>'+coment+'</div>'
								  +'<div>'+writeDate+'</div>'
								  +'</div>'
								  +'</div>'
							 	  +'<div class="close_button"></div>'
								  +'</div>'
								  +'</div>';
							//alert(str);
							$('.user_review_img_big').append(str);
						}// result for문 끝.
						
						idx = ($(".user_review_img").index($(this)))+1;
						
					    slider=$(".user_review_img_big .img_area_img").bxSlider({
					        speed: 100,        // 이동 속도를 설정
					        slideWidth: 1017,
					        pager: true,
					        infiniteLoop: false,	// "Next" 를 클릭하면 처음으로 전환
					        touchEnabled: true,	// 슬라이더에 터치 전환을 허용합니다.
					        pagerCustom: '#bx_pager1',
					        startSlide:idx,
					        onSlideNext: function($slideElement, oldIndex, newIndex) {
								/* alert(" -> p." + newIndex); */
								current_slide = newIndex;
				 				$(".user_review_img_big .img_area_small_img_dark").each(function(p_idx,obj) {
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
								/* alert(" -> p." + newIndex); */
								current_slide = newIndex;
								if(newIndex==0) {
									$(".bx-controls-direction .bx-prev").addClass('first');
									$(".bx-controls-direction .bx-next").click(function(){
					 					$(".bx-controls-direction .bx-prev").removeClass('first');
				 					});
								}
				 				$(".user_review_img_big .img_area_small_img_dark").each(function(p_idx,obj) {
									if(current_slide==p_idx) {
										$(this).addClass('on');
									}else{
										$(this).removeClass('on');
									}
								}); 
							}
					      });
						
						$(".user_review_img_big .img_area_small_img_dark").each(function(p_idx,obj) {
							//console.log($(this).parent().html());    
							if(idx==p_idx) {
								/* alert("p_idx : " + p_idx); */
								$(this).addClass('on');
							}else{
								$(this).removeClass('on');
							}
						});
					},
					error: function(request,status,error){
						alert("code"+request.status+"\n"+"message"+request.responseText+"\n");
						alert("error:"+error);
					}
				});
			});
	/* 		$(document).on("click",".user_review_img",function(){
				var mnum = $(this).parent().parent().parent().parent().attr("mnum"); 
				alert("mnum : " + mnum);
			}); */
			
 			$(document).on("click", ".review_content_list", function(e) {
 				detailPk = $(this).attr('idx');
 				mNumber = $(this).attr('mNum');
			    //특정부분만 실행하는 조건
				if($(e.target).parents('.user_review_img_wrap').length < 1){
					var openNewWindow = window.open("about:blank");
					openNewWindow.location.href="mango_review_detail.jsp?detailPk="+detailPk+"&mNumber="+mNumber;
				}
			});
			$(".title_header > div:nth-child(3)").click(function(){
				location.href="mango_review.jsp?detailPk="+<%=detailPk%>;
			});
			if(tastyLike == 0){
				$(document).on("click", ".more", function() {
					pageNum += 1;
					//alert("더보기 눌러서 요청함 : page:" + pageNum);
					$.ajax({
						type:"GET",
						url:"DetailReviewServlet",
						data:{"page" : pageNum, "plate_id" : 71},
						dataType: "json",
						success: function(data){ //data <----- objFinal
							//data_global_yg = data; //JSON.parse(data);
							//console.log(data);
	
							for(var i=0; i<=data.result.length-1; i++){
								//alert('.data.result.length(i:'+i+') = ' + data.result.length);
								var memberImg = data.result[i].memberImg;
								var name = data.result[i].name;
								var writeCount = data.result[i].writeCount;
								var followCount = data.result[i].followCount;
								var holic = data.result[i].holic;
								var writeDate = data.result[i].writeDate;
								var coment = data.result[i].coment;
								var img = data.result[i].img;
								var imgNum = data.result[i].imgNum.split(",,,");
								var tasty = data.result[i].tasty;
								var id = data.result[i].id;
								var idx = data.result[i].idx;
								var member = data.result[i].member;
								var str = '';
								str += '<div class="review_content_list" idx="'+ detailPk +'" mNum="'+ member +'">'
									   +'<div class="fl review_user">'
									   		+'<div><img class="user_img" src="Images/Member_Img/'+memberImg+'"></div>'
									  		+'<div class="user_name">' + name + '</div>'
									   		+'<div class="user_count_wrap">'
									   			+'<div class="fl user_write_count"><div class="user_write_img"></div>' + writeCount + '</div>'
							    	   			+'<div class="fl user_follow_count"><div class="user_follow_img"></div>' + followCount + '</div>'
							    	   			+'<div style="clear:both;"></div>'
							    	   		+'</div>';
										if(holic==1) {
										    str+='<div class="user_level"><img class="user_level_img" src="Images/user_level.png"></div>';
										}
										str+='</div>'
										+'<div class="fl review_content">'
										+'<div class="user_review_writedate">' + writeDate + '</div>'
										+'<p class="user_review">' + coment + '</p>'
										+'<div class="user_review_img_list">'
										+'<div class="user_review_img_wrap">';
										if(img != null){
											for(var j=0; j<=imgNum.length-1; j++) {
												if(j <= 2){
													str+='<img class= "fl user_review_img" src="Images/Detail_Review_Img/' + imgNum[j] + '">';
												}else if(j == 3){
													str+='<img class="fl user_review_img" style="filter: brightness(0.4);" src="Images/Detail_Review_Img/' + imgNum[j] + '">'
													+'<span class="user_review_img_else">+' + (imgNum.length - 4) + '</span>'; 
												}
										 	} 
										}
										str+='</div>'
										+'</div>'
										+'</div>';
								if(tasty==5){
									str+='<div class="fl review_score">'
										+'<div class="icon_tasty_like_good"></div>'
										+'<div class="user_review_like">맛있다</div>'
										+'</div>';
								}else if(tasty==3){
									str+='<div class="fl review_score">'
										+'<div class="icon_tasty_like_notbad"></div>'
										+'<div class="user_review_like">괜찮다</div>'
										+'</div>';
								}else if(tasty==1){
									str+='<div class="fl review_score">'
										+'<div class="icon_tasty_like_bad"></div>'
										+'<div class="user_review_like">별로다</div>'
										+'</div>';
								}
								str +='<div style="clear:both; min-height:0 !important; height:0; border:none;"></div>'
									+'</div>';
								$('.review_content_list_Wrap').append(str);
							} //for문 끝.
	
						},
						error: function(request,status,error){
							alert("code"+request.status+"\n"+"message"+request.responseText+"\n");
							alert("error:"+error);
						}
						
					});
				});
			} else if(tastyLike > 0) {
	 			$(document).on("click", ".more", function() {
					pageNum += 1;
					$.ajax({
						type:"GET",
						url:"DetailReviewTastyServlet",
						data:{"page" : pageNum, "plate_id" : 71,"tastyLike" : tastyLike},
						dataType: "json",
						success: function(data){ //data <----- objFinal
	
							for(var i=0; i<=data.result.length-1; i++){
								var memberImg = data.result[i].memberImg;
								var name = data.result[i].name;
								var writeCount = data.result[i].writeCount;
								var followCount = data.result[i].followCount;
								var holic = data.result[i].holic;
								var writeDate = data.result[i].writeDate;
								var coment = data.result[i].coment;
								var img = data.result[i].img;
								var imgNum = data.result[i].imgNum.split(",,,");
								var tasty = data.result[i].tasty;
								var id = data.result[i].id;
								var idx = data.result[i].idx;
								var member = data.result[i].member;
								var str = '';
								str += '<div class="review_content_list" idx="'+ detailPk +'" mNum="'+ member +'">'
									   +'<div class="fl review_user">'
									   		+'<div><img class="user_img" src="Images/Member_Img/'+memberImg+'"></div>'
									  		+'<div class="user_name">' + name + '</div>'
									   		+'<div class="user_count_wrap">'
									   			+'<div class="fl user_write_count"><div class="user_write_img"></div>' + writeCount + '</div>'
							    	   			+'<div class="fl user_follow_count"><div class="user_follow_img"></div>' + followCount + '</div>'
							    	   			+'<div style="clear:both;"></div>'
							    	   		+'</div>';
										if(holic==1) {
										    str+='<div class="user_level"><img class="user_level_img" src="Images/user_level.png"></div>';
										}
										str+='</div>'
										+'<div class="fl review_content">'
										+'<div class="user_review_writedate">' + writeDate + '</div>'
										+'<p class="user_review">' + coment + '</p>'
										+'<div class="user_review_img_list">'
										+'<div class="user_review_img_wrap">';
										if(img != null){
											for(var j=0; j<=imgNum.length-1; j++) {
												if(j <= 2){
													str+='<img class= "fl user_review_img" src="Images/Detail_Review_Img/' + imgNum[j] + '">';
												}else if(j == 3){
													str+='<img class="fl user_review_img" style="filter: brightness(0.4);" src="Images/Detail_Review_Img/' + imgNum[j] + '">'
													+'<span class="user_review_img_else">+' + (imgNum.length - 4) + '</span>'; 
												}
										 	} 
										}
										str+='</div>'
										+'</div>'
										+'</div>';
								if(tasty==5){
									str+='<div class="fl review_score">'
										+'<div class="icon_tasty_like_good"></div>'
										+'<div class="user_review_like">맛있다</div>'
										+'</div>';
								}else if(tasty==3){
									str+='<div class="fl review_score">'
										+'<div class="icon_tasty_like_notbad"></div>'
										+'<div class="user_review_like">괜찮다</div>'
										+'</div>';
								}else if(tasty==1){
									str+='<div class="fl review_score">'
										+'<div class="icon_tasty_like_bad"></div>'
										+'<div class="user_review_like">별로다</div>'
										+'</div>';
								}
								str +='<div style="clear:both; min-height:0 !important; height:0; border:none;"></div>'
									+'</div>';
								$('.review_content_list_Wrap').append(str);
							} //for문 끝.
	
						},
						error: function(request,status,error){
							alert("code"+request.status+"\n"+"message"+request.responseText+"\n");
							alert("error:"+error);
						}
						
					});
				});
			} //if문 끝.
			
			if( tastyBad > 0 ){		
	 			$(document).on("click", ".review_tasty_bad", function() {
					tastyLike = 1;
					pageNum = 1;
					$(this).css({ color: "#ff792a" });
					$(".review_tasty_good").css({ color: "#9b9b9b" });
					$(".review_tasty_notBad").css({ color: "#9b9b9b" });
					$(".review_tasty_like").css({ color: "#9b9b9b" });
					$.ajax({
						type:"GET",
						url:"DetailReviewTastyServlet",
						data:{"page" : pageNum, "plate_id" : 71, "tastyLike" : tastyLike},
						dataType: "json",
						success: function(data){ //data <----- objFinal
							data_global_yg = data; //JSON.parse(data);
							console.log(data);
							$('.review_content_list_Wrap').html("");
							for(var i=0; i<=data.result.length-1; i++){
								var memberImg = data.result[i].memberImg;
								var name = data.result[i].name;
								var writeCount = data.result[i].writeCount;
								var followCount = data.result[i].followCount;
								var holic = data.result[i].holic;
								var writeDate = data.result[i].writeDate;
								var coment = data.result[i].coment;
								var img = data.result[i].img;
								var imgNum = data.result[i].imgNum.split(",,,");
								var tasty = data.result[i].tasty;
								var id = data.result[i].id;
								var idx = data.result[i].idx;
								var member = data.result[i].member;
								var str = '';
								if(tasty==1){
									str += '<div class="review_content_list" idx="'+ detailPk +'" mNum="'+ member +'">'
										   +'<div class="fl review_user">'
										   		+'<div><img class="user_img" src="Images/Member_Img/'+memberImg+'"></div>'
										  		+'<div class="user_name">' + name + '</div>'
										   		+'<div class="user_count_wrap">'
										   			+'<div class="fl user_write_count"><div class="user_write_img"></div>' + writeCount + '</div>'
								    	   			+'<div class="fl user_follow_count"><div class="user_follow_img"></div>' + followCount + '</div>'
								    	   			+'<div style="clear:both;"></div>'
								    	   		+'</div>';
											if(holic==1) {
											    str+='<div class="user_level"><img class="user_level_img" src="Images/user_level.png"></div>';
											}
											str+='</div>'
											+'<div class="fl review_content">'
											+'<div class="user_review_writedate">' + writeDate + '</div>'
											+'<p class="user_review">' + coment + '</p>'
											+'<div class="user_review_img_list">'
											+'<div class="user_review_img_wrap">';
											if(img != null){
												for(var j=0; j<=imgNum.length-1; j++) {
													if(j <= 2){
														str+='<img class= "fl user_review_img" src="Images/Detail_Review_Img/' + imgNum[j] + '">';
													}else if(j == 3){
														str+='<img class="fl user_review_img" style="filter: brightness(0.4);" src="Images/Detail_Review_Img/' + imgNum[j] + '">'
														+'<span class="user_review_img_else">+' + (imgNum.length - 4) + '</span>'; 
													}
											 	} 
											}
											str+='</div>'
											+'</div>'
											+'</div>';
									if(tasty==5){
										str+='<div class="fl review_score">'
											+'<div class="icon_tasty_like_good"></div>'
											+'<div class="user_review_like">맛있다</div>'
											+'</div>';
									}else if(tasty==3){
										str+='<div class="fl review_score">'
											+'<div class="icon_tasty_like_notbad"></div>'
											+'<div class="user_review_like">괜찮다</div>'
											+'</div>';
									}else if(tasty==1){
										str+='<div class="fl review_score">'
											+'<div class="icon_tasty_like_bad"></div>'
											+'<div class="user_review_like">별로다</div>'
											+'</div>';
									}
									str +='<div style="clear:both; min-height:0 !important; height:0; border:none;"></div>'
										+'</div>';
								} //if문 끝.
								$('.review_content_list_Wrap').append(str);
							} //for문 끝.
						},
						error: function(request,status,error){
							alert("code"+request.status+"\n"+"message"+request.responseText+"\n");
							alert("error:"+error);
						}
					});	
				});
			} //if문 끝.	
			
			if( tastyGood > 0 ){		
	 			$(document).on("click", ".review_tasty_good", function() {
					tastyLike = 5;
					pageNum = 1;
					$(this).css({ color: "#ff792a" });
					$(".review_tasty_like").css({ color: "#9b9b9b" });
					$(".review_tasty_notBad").css({ color: "#9b9b9b" });
					$(".review_tasty_bad").css({ color: "#9b9b9b" });
					$.ajax({
						type:"GET",
						url:"DetailReviewTastyServlet",
						data:{"page" : pageNum, "plate_id" : 71, "tastyLike" : tastyLike},
						dataType: "json",
						success: function(data){ //data <----- objFinal
							data_global_yg = data; //JSON.parse(data);
							console.log(data);
	
							$('.review_content_list_Wrap').html("");	// 문장 초기화
							for(var i=0; i<=data.result.length-1; i++){
								var memberImg = data.result[i].memberImg;
								var name = data.result[i].name;
								var writeCount = data.result[i].writeCount;
								var followCount = data.result[i].followCount;
								var holic = data.result[i].holic;
								var writeDate = data.result[i].writeDate;
								var coment = data.result[i].coment;
								var img = data.result[i].img;
								var imgNum = data.result[i].imgNum.split(",,,");
								var tasty = data.result[i].tasty;
								var id = data.result[i].id;
								var idx = data.result[i].idx;
								var member = data.result[i].member;
								var str = '';
								if(tasty==5){
									str += '<div class="review_content_list" idx="'+ detailPk +'" mNum="'+ member +'">'
										   +'<div class="fl review_user">'
										   		+'<div><img class="user_img" src="Images/Member_Img/'+memberImg+'"></div>'
										  		+'<div class="user_name">' + name + '</div>'
										   		+'<div class="user_count_wrap">'
										   			+'<div class="fl user_write_count"><div class="user_write_img"></div>' + writeCount + '</div>'
								    	   			+'<div class="fl user_follow_count"><div class="user_follow_img"></div>' + followCount + '</div>'
								    	   			+'<div style="clear:both;"></div>'
								    	   		+'</div>';
											if(holic==1) {
											    str+='<div class="user_level"><img class="user_level_img" src="Images/user_level.png"></div>';
											}
											str+='</div>'
											+'<div class="fl review_content">'
											+'<div class="user_review_writedate">' + writeDate + '</div>'
											+'<p class="user_review">' + coment + '</p>'
											+'<div class="user_review_img_list">'
											+'<div class="user_review_img_wrap">';
											if(img != null){
												for(var j=0; j<=imgNum.length-1; j++) {
													if(j <= 2){
														str+='<img class= "fl user_review_img" src="Images/Detail_Review_Img/' + imgNum[j] + '">';
													}else if(j == 3){
														str+='<img class="fl user_review_img" style="filter: brightness(0.4);" src="Images/Detail_Review_Img/' + imgNum[j] + '">'
														+'<span class="user_review_img_else">+' + (imgNum.length - 4) + '</span>'; 
													}
											 	} 
											}
											str+='</div>'
											+'</div>'
											+'</div>';
									if(tasty==5){
										str+='<div class="fl review_score">'
											+'<div class="icon_tasty_like_good"></div>'
											+'<div class="user_review_like">맛있다</div>'
											+'</div>';
									}else if(tasty==3){
										str+='<div class="fl review_score">'
											+'<div class="icon_tasty_like_notbad"></div>'
											+'<div class="user_review_like">괜찮다</div>'
											+'</div>';
									}else if(tasty==1){
										str+='<div class="fl review_score">'
											+'<div class="icon_tasty_like_bad"></div>'
											+'<div class="user_review_like">별로다</div>'
											+'</div>';
									}
									str +='<div style="clear:both; min-height:0 !important; height:0; border:none;"></div>'
										+'</div>';
								} //if문 끝.
								$('.review_content_list_Wrap').append(str);
							} //for문 끝.
						},
						error: function(request,status,error){
							alert("code"+request.status+"\n"+"message"+request.responseText+"\n");
							alert("error:"+error);
						}
					});	
				});
			}//if문 끝.
			
			if( tastyNotBad > 0 ){
	 			$(document).on("click", ".review_tasty_notBad", function() {
					tastyLike = 3;
					pageNum = 1; 
					$(this).css({ color: "#ff792a" });
					$(".review_tasty_good").css({ color: "#9b9b9b" });
					$(".review_tasty_like").css({ color: "#9b9b9b" });
					$(".review_tasty_bad").css({ color: "#9b9b9b" });
					$.ajax({
						type:"GET",
						url:"DetailReviewTastyServlet",
						data:{"page" : pageNum, "plate_id" : 71, "tastyLike" : tastyLike},
						dataType: "json",
						success: function(data){ //data <----- objFinal
							data_global_yg = data; //JSON.parse(data);
							console.log(data);
	
							$('.review_content_list_Wrap').html("");	// 문장 초기화
							for(var i=0; i<=data.result.length-1; i++){
								var memberImg = data.result[i].memberImg;
								var name = data.result[i].name;
								var writeCount = data.result[i].writeCount;
								var followCount = data.result[i].followCount;
								var holic = data.result[i].holic;
								var writeDate = data.result[i].writeDate;
								var coment = data.result[i].coment;
								var img = data.result[i].img;
								var imgNum = data.result[i].imgNum.split(",,,");
								var tasty = data.result[i].tasty;
								var id = data.result[i].id;
								var idx = data.result[i].idx;
								var member = data.result[i].member;
								var str = '';
								if(tasty==3){
									str += '<div class="review_content_list" idx="'+ detailPk +'" mNum="'+ member +'">'
										   +'<div class="fl review_user">'
										   		+'<div><img class="user_img" src="Images/Member_Img/'+memberImg+'"></div>'
										  		+'<div class="user_name">' + name + '</div>'
										   		+'<div class="user_count_wrap">'
										   			+'<div class="fl user_write_count"><div class="user_write_img"></div>' + writeCount + '</div>'
								    	   			+'<div class="fl user_follow_count"><div class="user_follow_img"></div>' + followCount + '</div>'
								    	   			+'<div style="clear:both;"></div>'
								    	   		+'</div>';
											if(holic==1) {
											    str+='<div class="user_level"><img class="user_level_img" src="Images/user_level.png"></div>';
											}
											str+='</div>'
											+'<div class="fl review_content">'
											+'<div class="user_review_writedate">' + writeDate + '</div>'
											+'<p class="user_review">' + coment + '</p>'
											+'<div class="user_review_img_list">'
											+'<div class="user_review_img_wrap">';
											if(img != null){
												for(var j=0; j<=imgNum.length-1; j++) {
													if(j <= 2){
														str+='<img class= "fl user_review_img" src="Images/Detail_Review_Img/' + imgNum[j] + '">';
													}else if(j == 3){
														str+='<img class="fl user_review_img" style="filter: brightness(0.4);" src="Images/Detail_Review_Img/' + imgNum[j] + '">'
														+'<span class="user_review_img_else">+' + (imgNum.length - 4) + '</span>'; 
													}
											 	} 
											}
											str+='</div>'
											+'</div>'
											+'</div>';
									if(tasty==5){
										str+='<div class="fl review_score">'
											+'<div class="icon_tasty_like_good"></div>'
											+'<div class="user_review_like">맛있다</div>'
											+'</div>';
									}else if(tasty==3){
										str+='<div class="fl review_score">'
											+'<div class="icon_tasty_like_notbad"></div>'
											+'<div class="user_review_like">괜찮다</div>'
											+'</div>';
									}else if(tasty==1){
										str+='<div class="fl review_score">'
											+'<div class="icon_tasty_like_bad"></div>'
											+'<div class="user_review_like">별로다</div>'
											+'</div>';
									}
									str +='<div style="clear:both; min-height:0 !important; height:0; border:none;"></div>'
										+'</div>';
								} //if문 끝.
								$('.review_content_list_Wrap').append(str);
							} //for문 끝.
						},
						error: function(request,status,error){
							alert("code"+request.status+"\n"+"message"+request.responseText+"\n");
							alert("error:"+error);
						}
					});	
				});
			} // if문 끝.	
 			$(document).on("click", ".review_tasty_like", function() {
				tastyLike = 0;
				pageNum = 1;
				$(this).css({ color: "#ff792a" });
				$(".review_tasty_good").css({ color: "#9b9b9b" });
				$(".review_tasty_notBad").css({ color: "#9b9b9b" });
				$(".review_tasty_bad").css({ color: "#9b9b9b" });
				$.ajax({
					type:"GET",
					url:"DetailReviewServlet",
					data:{"page" : pageNum, "plate_id" : 71},
					dataType: "json",
					success: function(data){ //data <----- objFinal
						data_global_yg = data; //JSON.parse(data);
						console.log(data);

						$('.review_content_list_Wrap').html("");	// 문장 초기화
						for(var i=0; i<=data.result.length-1; i++){
							//alert('.data.result.length(i:'+i+') = ' + data.result.length);
							var memberImg = data.result[i].memberImg;
							var name = data.result[i].name;
							var writeCount = data.result[i].writeCount;
							var followCount = data.result[i].followCount;
							var holic = data.result[i].holic;
							var writeDate = data.result[i].writeDate;
							var coment = data.result[i].coment;
							var img = data.result[i].img;
							var imgNum = data.result[i].imgNum.split(",,,");
							var tasty = data.result[i].tasty;
							var id = data.result[i].id;
							var idx = data.result[i].idx;
							var member = data.result[i].member;
							var str = '';
								str += '<div class="review_content_list" idx="'+ detailPk +'" mNum="'+ member +'">'
									   +'<div class="fl review_user">'
									   		+'<div><img class="user_img" src="Images/Member_Img/'+memberImg+'"></div>'
									  		+'<div class="user_name">' + name + '</div>'
									   		+'<div class="user_count_wrap">'
									   			+'<div class="fl user_write_count"><div class="user_write_img"></div>' + writeCount + '</div>'
							    	   			+'<div class="fl user_follow_count"><div class="user_follow_img"></div>' + followCount + '</div>'
							    	   			+'<div style="clear:both;"></div>'
							    	   		+'</div>';
										if(holic==1) {
										    str+='<div class="user_level"><img class="user_level_img" src="Images/user_level.png"></div>';
										}
										str+='</div>'
										+'<div class="fl review_content">'
										+'<div class="user_review_writedate">' + writeDate + '</div>'
										+'<p class="user_review">' + coment + '</p>'
										+'<div class="user_review_img_list">'
										+'<div class="user_review_img_wrap">';
										if(img != null){
											for(var j=0; j<=imgNum.length-1; j++) {
												if(j <= 2){
													str+='<img class= "fl user_review_img" src="Images/Detail_Review_Img/' + imgNum[j] + '">';
												}else if(j == 3){
													str+='<img class="fl user_review_img" style="filter: brightness(0.4);" src="Images/Detail_Review_Img/' + imgNum[j] + '">'
													+'<span class="user_review_img_else">+' + (imgNum.length - 4) + '</span>'; 
												}
										 	} 
										}
										str+='</div>'
										+'</div>'
										+'</div>';
								if(tasty==5){
									str+='<div class="fl review_score">'
										+'<div class="icon_tasty_like_good"></div>'
										+'<div class="user_review_like">맛있다</div>'
										+'</div>';
								}else if(tasty==3){
									str+='<div class="fl review_score">'
										+'<div class="icon_tasty_like_notbad"></div>'
										+'<div class="user_review_like">괜찮다</div>'
										+'</div>';
								}else if(tasty==1){
									str+='<div class="fl review_score">'
										+'<div class="icon_tasty_like_bad"></div>'
										+'<div class="user_review_like">별로다</div>'
										+'</div>';
								}
								str +='<div style="clear:both; min-height:0 !important; height:0; border:none;"></div>'
									+'</div>';
							//$('.review_content_list_Wrap').html("");
							$('.review_content_list_Wrap').append(str);
						} //for문 끝.
					},
					error: function(request,status,error){
						alert("code"+request.status+"\n"+"message"+request.responseText+"\n");
						alert("error:"+error);
					}
				});	
			});

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
	         
	         $(document).on("click", ".input_search_content_keywordList", function() {   // 클릭시 검색어 들어감
	            var item = $(this).find(".input_search_keywordList_item").text();
	              var url_input_search = "Mango_popularSearch2.jsp?keyword="+item;
	              location.href = url_input_search;
	         });
	// 헤더 인기검색어 팝업창 끝--------------------------------------------------------------------------------------
	
	
			// 테이블 메뉴판 이미지 모달창 띄우기
			$(".menu_img").click(function(){
				idx = $(".menu_img").index($(this));
				
				$(".menu_img_big").css({ display:"block"});
				$(".black_screen").css({ display:"block"});
				$("body").css("overflow-y","hidden");
				
				// bx슬라이더
 				$(document).ready(function(){
				      slider=$(".menu_img_big .img_area_img").bxSlider({
				        speed: 100,        // 이동 속도를 설정
				        slideWidth: 1017,
				        pager: true,
				        infiniteLoop: false,	// "Next" 를 클릭하면 처음으로 전환
				        touchEnabled: true,	// 슬라이더에 터치 전환을 허용합니다.
				        pagerCustom: '#bx_pager2',
				        startSlide:idx,
				       
						onSlideNext: function($slideElement, oldIndex, newIndex) {
							/* alert(" -> p." + newIndex); */
							current_slide = newIndex;
			 				$(".menu_img_big .img_area_small_img_dark").each(function(p_idx,obj) {
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
			 				showNewContentWithNewIndex(newIndex);
						},
						onSlidePrev: function($slideElement, oldIndex, newIndex) {
							/* alert(" -> p." + newIndex); */
							current_slide = newIndex;
							if(newIndex==0) {
								$(".bx-controls-direction .bx-prev").addClass('first');
								$(".bx-controls-direction .bx-next").click(function(){
				 					$(".bx-controls-direction .bx-prev").removeClass('first');
			 					});
							}
			 				$(".menu_img_big .img_area_small_img_dark").each(function(p_idx,obj) {
								if(current_slide==p_idx) {
									$(this).addClass('on');
								}else{
									$(this).removeClass('on');
								}
							});
			 				showNewContentWithNewIndex(newIndex);
						}

				     });
				});
 				
				
				$(".menu_img_big .img_area_small_img_dark").each(function(p_idx,obj) {
					if(idx==p_idx) {
						$(this).addClass('on');
					}else{
						$(this).removeClass('on');
					}
				});
			});		
			
			// 상단 이미지 모달창 띄우기
			$(".img_left").click(function(){
				idx = $(".img_left").index($(this));
				
				$(".main_review_img_big").css({ display:"block"});
				$(".black_screen").css({ display:"block"});
				$("body").css("overflow-y","hidden");
				
			    slider=$(".main_review_img_big .img_area_img").bxSlider({
			        speed: 100,        // 이동 속도를 설정
			        slideWidth: 1017,
			        pager: true,
			        infiniteLoop: false,	// "Next" 를 클릭하면 처음으로 전환
			        touchEnabled: true,	// 슬라이더에 터치 전환을 허용합니다.
			        pagerCustom: '#bx_pager1',
			        startSlide:idx,
			        onSlideNext: function($slideElement, oldIndex, newIndex) {
						/* alert(" -> p." + newIndex); */
						current_slide = newIndex;
		 				$(".main_review_img_big .img_area_small_img_dark").each(function(p_idx,obj) {
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
						/* alert(" -> p." + newIndex); */
						current_slide = newIndex;
						if(newIndex==0) {
							$(".bx-controls-direction .bx-prev").addClass('first');
							$(".bx-controls-direction .bx-next").click(function(){
			 					$(".bx-controls-direction .bx-prev").removeClass('first');
		 					});
						}
		 				$(".main_review_img_big .img_area_small_img_dark").each(function(p_idx,obj) {
							if(current_slide==p_idx) {
								$(this).addClass('on');
							}else{
								$(this).removeClass('on');
							}
						});
					}
			      });
				
				$(".main_review_img_big .img_area_small_img_dark").each(function(p_idx,obj) {
					if(idx==p_idx) {
						$(this).addClass('on');
					}else{
						$(this).removeClass('on');
					}
				});
			});
			
			// 사진 더보기 클릭 시 모달 창 띄우기
			$(document).on("click", ".hide_text", function() {
//		$(".hide_text").click(function(){
				idx = $(".img_left").index($(this));
				
				$(".main_review_img_big").css({ display:"block"});
				$(".black_screen").css({ display:"block"});
				$("body").css("overflow-y","hidden");
				
			    slider=$(".main_review_img_big .img_area_img").bxSlider({
			        speed: 100,        // 이동 속도를 설정
			        slideWidth: 1017,
			        pager: true,
			        infiniteLoop: false,	// "Next" 를 클릭하면 처음으로 전환
			        touchEnabled: true,	// 슬라이더에 터치 전환을 허용합니다.
			        pagerCustom: '#bx_pager1',
			        startSlide:5,
			        onSlideNext: function($slideElement, oldIndex, newIndex) {
						/* alert(" -> p." + newIndex); */
						current_slide = newIndex;
		 				$(".main_review_img_big .img_area_small_img_dark").each(function(p_idx,obj) {
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
						/* alert(" -> p." + newIndex); */
						current_slide = newIndex;
						if(newIndex==0) {
							$(".bx-controls-direction .bx-prev").addClass('first');
							$(".bx-controls-direction .bx-next").click(function(){
			 					$(".bx-controls-direction .bx-prev").removeClass('first');
		 					});
						}
		 				$(".main_review_img_big .img_area_small_img_dark").each(function(p_idx,obj) {
							if(current_slide==p_idx) {
								$(this).addClass('on');
							}else{
								$(this).removeClass('on');
							}
						});
					}
			      });
				
				$(".main_review_img_big .img_area_small_img_dark").each(function(p_idx,obj) {
					//console.log($(this).parent().html());    
					if(5==p_idx) {
						/* alert("p_idx : " + p_idx); */
						$(this).addClass('on');
					}else{
						$(this).removeClass('on');
					}
				});
			});
			
			// 리뷰 이미지 클릭 시 모달 창 띄우기
/* 			$(document).on("click", ".user_review_img_wrap > img , .user_review_img_wrap > span ", function(){
				idx = $(".user_review_img").index($(this));
				
				$(".user_review_img_big").css({ display:"block"});
				$(".black_screen").css({ display:"block"});
				$("body").css("overflow-y","hidden");
				
			    slider=$(".user_review_img_big .img_area_img").bxSlider({
			        speed: 100,       
			        slideWidth: 1017,
			        pager: true,
			        infiniteLoop: false,	
			        touchEnabled: true,	
			        pagerCustom: '#bx_pager1',
			        startSlide:idx,
			        onSlideNext: function($slideElement, oldIndex, newIndex) {
						current_slide = newIndex;
		 				$(".user_review_img_big .img_area_small_img_dark").each(function(p_idx,obj) {
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
		 				$(".user_review_img_big .img_area_small_img_dark").each(function(p_idx,obj) {
							if(current_slide==p_idx) {
								$(this).addClass('on');
							}else{
								$(this).removeClass('on');
							}
						});
					}
			      });
				
				$(".user_review_img_big .img_area_small_img_dark").each(function(p_idx,obj) {
					if(idx==p_idx) {
						$(this).addClass('on');
					}else{
						$(this).removeClass('on');
					}
				});
			}); */
			//pager 이미지 이동했을때 필터적용
			
			//$(".img_area_small_img_dark").on('click', function (event) {
			$(document).on("click", ".img_area_small_img_dark", function(event) {
	            $(".img_area_small_img_dark").removeClass('on');
	            $(this).addClass('on');
			});

			//모달 창 나가기 (close버튼)
			
			$(document).on("click", ".close_button", function() {
				$(".menu_img_big").css({ display:"none"});
				$(".main_review_img_big").css({ display:"none"});
				$(".user_review_img_big").css({ display:"none"});
				$(".black_screen").css({ display:"none"});
				$("body").css("overflow-y","auto");
				slider.destroySlider();
			});
			//모달 창 나가기 (black_screen)
			$(document).on("click", ".black_screen", function() {
				$(".menu_img_big").css({ display:"none"});
				$(".main_review_img_big").css({ display:"none"});
				$(".user_review_img_big").css({ display:"none"});
				$(".black_screen").css({ display:"none"});
				$("#map2").css({display:"none"});
				$("body").css("overflow-y","auto");
				slider.destroySlider();
			});
			$(document).on("click", "#map", function() {
				$(".black_screen").css({display:"block"});
				$("#map2").css({display:"block"});
				map.relayout();
				map.setCenter(markerPosition);
			});
			$(document).keydown(function(event) {
			    if ( event.keyCode == 27 || event.which == 27 ) {
					$(".menu_img_big").css({ display:"none"});
					$(".main_review_img_big").css({ display:"none"});
					$(".user_review_img_big").css({ display:"none"});
					$(".black_screen").css({ display:"none"});
					$("body").css("overflow-y","auto");
					slider.destroySlider();
			    }
			});
			
		});
			
			
	</script>	
</head>
<body>
		<!-- 상단 바 -->
<!-- 	<div id="div_header">
		<div class="fl">
			<a href="https://www.mangoplate.com/">
				<img id="img_logo" src="Images/img_logo.png">
			</a>
		</div>
		<div class="fl">
			<img id="img_search" src="Images/icon_search.png">
			<label for="input_search" style="width:500px;">
				<input type="text" id="input_search" style="width:500px;" placeholder="지역, 식당 또는 음식"/>
			</label>
		</div>
		<div class="fr header_right"><img class ="UserProfileButton__PersonIcon" src="Images/icon_user.png"></div>
		<a href = "https://www.mangoplate.com/mango_picks"><div class="fr header_right"><span>망고 스토리</span></div></a>
		<a href = "https://www.mangoplate.com/top_lists"><div class="fr header_right"><span>맛집 리스트</span></div></a>
		<a href = "https://www.mangoplate.com/eat_deals"><div class="fr header_right"><span>EAT딜</span></div></a>
		<div style="clear:both;"></div>
	</div> -->
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
   <!-- ///////////////////////////  헤더 끝   ////////////////////////////////////////////////// -->
   <!-- nth child(2) 상단 메인 스토리 -->
	<div id="details_background_dark"></div>
		<div id="search_wrap">
			<div id="Keyword_items_wrap">
				<div class="Keyword_items_list">
					<div class="Keyword_item Keyword_item_Active">추천 검색어</div>
					<div class="Keyword_item">인기 검색어</div>
					<div class="Keyword_item">최근 검색어</div>
				</div>
			</div>
			<div id="Keyword_content_wrap">
				<div class="Keyword_content_items">
					<a href="https://www.mangoplate.com/search/%EA%B0%95%EB%82%A8%EC%97%AD">
						<div class="search_img"></div>
						<div class="Keyword_contents">강남역</div>
					</a>
				</div>
				<div class="Keyword_content_items">
					<a href="https://www.mangoplate.com/search/%EC%9A%A9%EB%A6%AC%EB%8B%A8%EA%B8%B8">
						<div class="search_img"></div>
						<div class="Keyword_contents">용리단길</div>
					</a>
				</div>
				<div class="Keyword_content_items">	
					<a href="https://www.mangoplate.com/search/%EC%9C%A0%ED%8A%9C%EB%B2%84%EC%B6%94%EC%B2%9C">
						<div class="search_img"></div>
						<div class="Keyword_contents">유튜버추천</div>
					</a>
				</div>
				<div class="Keyword_content_items">
					<a href="https://www.mangoplate.com/search/%EC%8B%A0%EC%B4%8C">
						<div class="search_img"></div>
						<div class="Keyword_contents">신촌</div>
					</a>
				</div>
				<div class="Keyword_content_items">
					<a href="https://www.mangoplate.com/search/%EC%B0%B8%EC%B9%98">
						<div class="search_img"></div>
						<div class="Keyword_contents">참치</div>
					</a>
				</div>
				<div class="Keyword_content_items">
					<a href="https://www.mangoplate.com/search/%EC%84%B1%EC%88%98">
						<div class="search_img"></div>
						<div class="Keyword_contents">성수</div>
					</a>
				</div>
				<div class="Keyword_content_items">
					<a href="https://www.mangoplate.com/search/%EC%99%80%EC%9D%B8">
						<div class="search_img"></div>
						<div class="Keyword_contents">와인</div>
					</a>
				</div>
			</div>
			<div id="popular_content_wrap">
				<div class="Keyword_content_items">
					<a href="https://www.mangoplate.com/search/%ED%99%8D%EB%8C%80">
						<div class="search_img"></div>
						<div class="Keyword_contents">홍대</div>
					</a>
				</div>
				<div class="Keyword_content_items">
					<a href="https://www.mangoplate.com/search/%EC%9D%B4%ED%83%9C%EC%9B%90">
						<div class="search_img"></div>
						<div class="Keyword_contents">이태원</div>
					</a>
				</div>
				<div class="Keyword_content_items">	
					<a href="https://www.mangoplate.com/search/%EC%8B%A0%EC%B4%8C">
						<div class="search_img"></div>
						<div class="Keyword_contents">신촌</div>
					</a>
				</div>
				<div class="Keyword_content_items">
					<a href="https://www.mangoplate.com/search/%EA%B0%95%EB%82%A8%EC%97%AD">
						<div class="search_img"></div>
						<div class="Keyword_contents">강남역</div>
					</a>
				</div>
				<div class="Keyword_content_items">
					<a href="https://www.mangoplate.com/search/%EA%B0%80%EB%A1%9C%EC%88%98%EA%B8%B8">
						<div class="search_img"></div>
						<div class="Keyword_contents">가로수길</div>
					</a>
				</div>
				<div class="Keyword_content_items">
					<a href="https://www.mangoplate.com/search/%ED%8F%89%ED%83%9D%EC%8B%9C">
						<div class="search_img"></div>
						<div class="Keyword_contents">평택시</div>
					</a>
				</div>
				<div class="Keyword_content_items">
					<a href="https://www.mangoplate.com/search/%EB%B0%A9%EB%B0%B0">
						<div class="search_img"></div>
						<div class="Keyword_contents">방배</div>
					</a>
				</div>
			</div>
			<div id="lately_content_wrap">
				<div class="Keyword_content_items">
						<div class="lately_Keyword_none">최근 검색어가 없습니다.</div>
				</div>
			</div>
			<div class="scroll">
				<div class="scroll_item"></div>
			</div>
		</div>
	<div id = "div_img">
	
	 <%
		 int cnt = 0;
	 	 for(mangoDetailsTopReviewDTO dto : topReviewList){
	 		if(cnt==5){break;}
	 		if(dto.getImg() != null){ 
	 			for(int i=0; i<=dto.getImgNum().length-1; i++){ 
			 		/* System.out.println(dto.getImgNum()[i]); */
			 		if(cnt==5){break;}
	%>
				<div><img class="img_left" src="Images/Detail_Review_Img/<%=dto.getImgNum()[i]%>"></div>
	<%			cnt++;
				} 
			}
		}
	%> 
		<div class="hide_text"><p class="txt"> 사진 더보기  </p><div class="allow-white"></div></div>
		<div style="clear:both;"></div>
	</div>
	<div class="main_review_img_big">
		<div class="img_area">
			<div class="img_area_wrap">
				<div class="img_area_img">
				<% for(mangoDetailsTopReviewDTO dto : topReviewList){
					for(int i=0; i<=dto.getImgNum().length-1; i++){	%>
					<div><img src="Images/Detail_Review_Img/<%=dto.getImgNum()[i] %>"></div>
				<% }
				  }	%>
				</div>
				<div class="img_area_button">
<!-- 					<img src="Images/icon_left.png">
					<img src="Images/icon_right.png"> -->
				</div>
				<div class="img_area_small">
					<div class="img_area_small_img" id="bx_pager1">
						<% %>
						 <a data-slide-index="0" href=""><div class="fl img_area_small_img_dark" style="background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/87430/59_1491141169295_9384?fit=around|66:68&crop=66:68;*,*&output-format=jpg&output-quality=80);"></div></a>
  					 	 <a data-slide-index="1" href=""><div class="fl img_area_small_img_dark" style="background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/47875_1664354631132577.jpg?fit=around|66:68&crop=66:68;*,*&output-format=jpg&output-quality=80);"></div></a>
					 	 <a data-slide-index="2" href=""><div class="fl img_area_small_img_dark" style="background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/47875_1664354633101170.jpg?fit=around|66:68&crop=66:68;*,*&output-format=jpg&output-quality=80);"></div></a>
					 	 <a data-slide-index="3" href=""><div class="fl img_area_small_img_dark" style="background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/47875_1664354633728158.jpg?fit=around|66:68&crop=66:68;*,*&output-format=jpg&output-quality=80);"></div></a>
					 	 <a data-slide-index="4" href=""><div class="fl img_area_small_img_dark" style="background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/1104193_1662643753780984.jpg?fit=around|66:68&crop=66:68;*,*&output-format=jpg&output-quality=80);"></div></a>
					 	 <a data-slide-index="5" href=""><div class="fl img_area_small_img_dark" style="background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/584169_1636614583240310.jpg?fit=around|66:68&crop=66:68;*,*&output-format=jpg&output-quality=80);"></div></a>
						 <div style="clear:both"></div>
					</div>
				</div>
			</div>
			<div class="img_area_content">
				<div class="img_area_content_title"><span><%=DetailList.getName()%></span></div>
				<div class="img_area_user_items">
					<div class="user_header">
						<div class="fl user_header_img" style="background-image:url(Images/user_junyuong.jpg)"></div>
						<div class="fl user_header_items_wrap">
							<div class="user_header_items">
								<div class="user_header_name">준영</div>
								<div class="user_header_level"></div>
							</div>
							<div class="fl user_header_stat">
								<div class="fl review_icon"></div>
								<span class="fl user_count">4395</span>
								<div class="fl follow_icon"></div>
								<span class="fl user_count">1322</span>
								<div style="clear:both"></div>
							</div>
						</div>	
						<div class="fr tasty_like_wrap">
							<div class="user_header_tasty_good"></div>
							<div class="user_header_review_like">맛있다</div>
						</div>
						<div style="clear:both"></div>
					</div>
				</div>
				<div class="img_area_content_content">
					<div>망플1위 순대국을 믿고 갔습니당 2호선 강남역에서는 조금 거리가 있습니다 분당선쪽에 있어용 여름에는 걷기 조금 더울 것 같습니다 강남에서 순대국은 처음 먹어봤는데 맛있었습니당 순댓국에서 특별함은 잘 모르겠으나 국물이 깔끔하고 고기양이 매우 많은 것은 좋았어용 두둑하게 한끼 식사를 적당한 가격에 할 수 있다는 장점이 있습니다 음식이 빨리 나오고 혼자 드시는 분들도 많아서 강남에서 혼밥하기도 괜찮은 장소인 것 같습니당</div>
					<div>2019-07-24</div>
				</div>
			</div>
			<div class="close_button"></div>
		</div>
	</div>
	<div class="black_screen"></div>
	<!-- inner 만들기-->
	<!-- <div class="fl"></div> -->
	<!-- column-contents in -->
	<div id="body_contents">
		<div id= "column-contents" class="fl">
			<!-- title in -->
			<div class="title">
				<div class="title_header">
					<!-- detail in -->
					<div class="fl restaurant_detail">
						<h1 class="fl restaurant_name"><%=DetailList.getName()%></h1> 
						<strong class="fl score">
							<span><%=DetailList.getScore()%></span>
						</strong>
						<div style="clear:both;"></div>
						<p class="branch"><%=DetailList.getBranch()%></p>
			
			            <!-- count in -->
						<div id="status">
							<div class="fl count"><img src="Images/icon_hitcount.png"> <%=DetailList.getHitcount2()%></div>
							<div class="fl count"><img src="Images/icon_review_count.png"> <%=DetailList.getReview2()%></div>
							<div class="fl count"><img src="Images/icon_wannago_count.png"> <%=DetailList.getWish2()%></div>
						</div>	
						<div style="clear:both;"></div>
						<!-- count out -->
					</div>
					<!-- button in -->
					<div class="fr button">
		               	<!-- <button class="restaurant_wannago_button"> -->
		             	<img id= "wannago_button" src="Images/icon_wannago.png"/><br/>
		             	<span id="wannago">가고싶다</span>
		               	<!-- </button> -->
					</div>
					<div class= "fr button">
		               	<!-- <button class="restaurant_writer_button"> -->
		               	<div class="writer_button">
		              		<!-- <a href="mango_review.html"> -->
		               			<img class= "writer_button1" src="Images/icon_writer.png"/>
		               			<img class= "writer_button2" src="https://mp-seoul-image-production-s3.mangoplate.com/web/resources/review_writing_active_icon2.png"/>
		               		<!-- </a> -->
		               	</div>
		               	<span id="writer">리뷰쓰기</span>
		               	<!-- </button> -->
		            </div>
		            <div style="clear:both;"></div>
					<!-- button out -->
					<div>
						<div class="line"></div>
						<!-- table in -->
						<div class="detail_table">
							<table>
								<tr>
									<th>주소</th>
									<td><%=DetailList.getStAddress()%><br/>
										<span class="jibun_address_icon">지번</span>
										<span class="jibun_address"><%=DetailList.getJibunAddress()%></span>
									</td>
								</tr>
								<tr>
									<th>전화번호</th>
									<td><%=DetailList.getPhoneNum()%></td>
								</tr>
								<tr>
									<th>음식 종류</th>
									<td><%=DetailList.getType()%></td>
								</tr>
								<tr>
									<th>가격대</th>
									<td><%=DetailList.getPrice()%></td>
								</tr>
								<tr>
									<th>주차</th>
									<td><%=DetailList.getParking()%></td>
								</tr>
								<tr>
									<th>영업시간</th>
									<td><%=DetailList.getBusinessHour()%>
									</td>
								</tr>
								<%if(DetailList.getDayOff() != null){ %>
								<tr>
									<th>휴일</th>
									<td><%=DetailList.getDayOff()%></td>
								</tr>
			                   <% } %>
								<tr>
									<th>메뉴</th>
									<td>
										<ul>
										<% for(MenuDTO menu : menuList){ %>
											<li class="menu_list">
												<span class="menu"><%=menu.getMenuName()%></span>
												<span class="fr"><%=(menu.getMenuPrice())+"원"%></span>
											</li>
										<% } %>
										</ul>
									</td>
								</tr>
								<tr>
									<th></th>
									<td>
										<div>	<!-- 메뉴판이미지 -->
										    <% for (mangoDetailsMenuDTO dto : menuImgList){ 
                                    			if(dto.getMenuImg() != null){%>

											<img class="fl menu_img" src="Images/TableMenuImg/<%=dto.getMenuImg()%>">
											<% }
	                                    	} %>	
										</div>
									</td>
									<div style="clear:both;"></div>
								</tr>
							</table>
						</div>	<!-- table out -->
						<div class="menu_img_big">
							<div class="img_area">
								<div class="img_area_wrap">
									<div class="img_area_img">
									<%for(mangoDetailsMenuDTO dto : menuImgList){  %>
										<div>
											<img src="Images/TableMenuImg/<%=dto.getMenuImg() %>">
										</div>
									<% } %>	
									</div>
									<div class="img_area_button"></div>
									<div class="img_area_small">
										<div class="img_area_small_img" id="bx_pager2">
										<script>
											var arrayMenuComent = new Array(<%=menuImgList.size()%>);
											var arrayMenuUpdateDate = new Array(<%=menuImgList.size()%>);
										</script>
										<%for (int i=0; i<=menuImgList.size()-1; i++){ %>
											<script>
												<%-- <%System.out.println(menuImgList.get(i).getUpdateDate2());%> --%>
												arrayMenuComent[<%=i%>] = '<%=menuImgList.get(i).getComent() %>';
												<%if(menuImgList.get(i).getUpdateDate2()!=null){%>
													arrayMenuUpdateDate[<%=i%>] = '<%=menuImgList.get(i).getUpdateDate2().split(" ")[0] %>';
												<% } %>
											</script>
										 	<a data-slide-index="<%=i %>" href=""><div class="fl img_area_small_img_dark" style="background-image: url(Images/TableMenuImg/<%=menuImgList.get(i).getMenuImg() %>);"></div></a>
									    <% } %>
										</div>
									</div>
								</div>
								<div class="img_area_content">
									<div class="img_area_content_title"><span><%=DetailList.getName()%></span></div>
									<div class="img_area_content_content">
										<div><%=menuImgList.get(0).getComent() %></div> 
										<div><%=menuImgList.get(0).getUpdateDate2() %></div>
									</div>
								</div>
								<div class="close_button"></div>
							</div>
						</div>
						<div class="black_screen"></div>
						<p class="update_date"> 업데이트 : <%=DetailList.getUpdate_date()%> </p>
						<div class="line"></div>	<!-- 선나누기 -->
					<!-- 리뷰 시작 -->
					</div>	<!-- detail out -->
				</div> <!-- title herder out -->
				<div class="title_header2">
					<div class="review_table">
						<div class="review_list">
						<% 	int sum=0;
							int good=0;
							int notBad=0;
							int bad=0;
							for(int i=0; i<=countList.size()-1; i++){
								sum++;
								if(countList.get(i) == 5){ good++; }
								if(countList.get(i) == 3){ notBad++; }
								if(countList.get(i) == 1){ bad++; }
						  	}					
						%>
							<span class="review_title">리뷰</span>
							<span class="review_count">(<%=sum %>)</span>
							<span class="fr review_tasty_bad">별로다 (<%=bad %>)</span>
							<span class="fr review_tasty_notBad">괜찮다 (<%=notBad %>)</span>
							<span class="fr review_tasty_good">맛있다 (<%=good %>)</span>
							<span class="fr review_tasty_like">전체 (<%=sum %>)</span>
						</div>
					</div>
					<div class="review_content_list_Wrap">
						<% for(mangoReviewDTO dto : reviewList) { %>
							<div class="review_content_list" idx="<%=detailPk %>" mNum="<%=dto.getMember() %>">
								<div class="fl review_user">
									<div><img class="user_img" src="Images/Member_Img/<%=dto.getMemberImg()%>"></div>
									<div class="user_name"><%=dto.getName()%></div>
									<div class="user_count_wrap">
										<div class="fl user_write_count"><div class="user_write_img"></div><%=dto.getWriteCount()%></div>
										<div class="fl user_follow_count"><div class="user_follow_img"></div><%=dto.getFollowCount()%></div>
										<div style="clear:both;"></div>
									</div>
									<% if(dto.getHolic()==1) {%>
										<div class="user_level"><img class="user_level_img" src="Images/user_level.png"></div>
									<% } %>
								</div>
								<div class="fl review_content">
									<div class="user_review_writedate"><%=dto.getWritedate()%></div>
									<p class="user_review"><%=dto.getComent()%></p>
									<div class="user_review_img_list">
									 	<div class="user_review_img_wrap">	
										<% if(reviewList.size() != 0){
											if(reviewDetailList!=null){
												for(int i=0; i<=dto.getImgNum().length-1; i++) { 
													if(i <= 2){ %>
														<img class="fl user_review_img" number = "<%=reviewDetailList.getMemberNumber() %>" src="Images/Detail_Review_Img/<%=dto.getImgNum()[i]%>">
												 <% } else if(i == 3) { %>
														<img class="fl user_review_img" style="filter: brightness(0.4);" src="Images/Detail_Review_Img/<%=dto.getImgNum()[i]%>">
														<span class="user_review_img_else">+<%=dto.getImgNum().length-1-i%></span>
												 <% }
											 	}
											}
										   } %>
										   <div style="clear:both;"></div>
										</div>	
									</div>
								</div>
								<% if(dto.getTasty()==5){ %>
									<div class="fl review_score">
										<div class="icon_tasty_like_good"></div>
										<div class="user_review_like">맛있다</div>
									</div>
								<% }else if(dto.getTasty()==3){ %>
									<div class="fl review_score">
										<div class="icon_tasty_like_notbad"></div>
										<div class="user_review_like">괜찮다</div>
									</div>
								<% }else if(dto.getTasty()==1){ %>
									<div class="fl review_score">
										<div class="icon_tasty_like_bad"></div>
										<div class="user_review_like">별로다</div>
									</div>
								<% } %>
								<div style="clear:both; min-height:0 !important; height:0; border:none;"></div>
							</div>	<!-- 리뷰끝 -->
						<% } %>
					</div>
					<div class="user_review_img_big">
						<div class="img_area">
							<div class="img_area_wrap">
								<div class="img_area_img">
								<%if(reviewDetailList!=null){ %>
								<%for(int i=0; i<=reviewDetailList.getImg().length-1; i++) {%>
									<div class="Bximg"><img src="Images/Detail_Review_Img/<%=reviewDetailList.getImg()[i] %>"></div>
								<% }
								}%>
									<!-- <div><img src="https://mp-seoul-image-production-s3.mangoplate.com/47875_1664354631132577.jpg"></div>
									<div><img src="https://mp-seoul-image-production-s3.mangoplate.com/47875_1664354633101170.jpg"></div>
									<div><img src="https://mp-seoul-image-production-s3.mangoplate.com/47875_1664354633728158.jpg"></div> -->
								</div>
								<div class="img_area_button">
				<!-- 					<img src="Images/icon_left.png">
									<img src="Images/icon_right.png"> -->
								</div>
								<div class="img_area_small">
									<div class="img_area_small_img" id="bx_pager3">
										 <a data-slide-index="0" href=""><div class="fl img_area_small_img_dark" style="background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/47875_1664354631132577.jpg);"></div></a>
									 	 <a data-slide-index="1" href=""><div class="fl img_area_small_img_dark" style="background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/47875_1664354633101170.jpg);"></div></a>
									 	 <a data-slide-index="2" href=""><div class="fl img_area_small_img_dark" style="background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/47875_1664354633728158.jpg);"></div></a>
										 <div style="clear:both"></div>
									</div>
								</div>
							</div>
							<div class="img_area_content">
								<div class="img_area_content_title"><span>농민백암왕순대</span></div>
								<div class="img_area_user_items">
									<div class="user_header">
										<div class="fl user_header_img" style="background-image:url(Images/user_junyuong.jpg)"></div>
										<div class="fl user_header_items_wrap">
											<div class="user_header_items">
												<div class="user_header_name">준영</div>
												<div class="user_header_level"></div>
											</div>
											<div class="fl user_header_stat">
												<div class="fl review_icon"></div>
												<span class="fl user_count">4395</span>
												<div class="fl follow_icon"></div>
												<span class="fl user_count">1322</span>
												<div style="clear:both"></div>
											</div>
										</div>	
										<div class="fr tasty_like_wrap">
											<div class="user_header_tasty_good"></div>
											<div class="user_header_review_like">맛있다</div>
										</div>
										<div style="clear:both"></div>
									</div>
								</div>
								<div class="img_area_content_content">
									<div>오랜만에 다시 찾은 농민백암순대! 주말 점심 12시 좀 전에 방문했는데 웨이팅이 6팀 있었어요. 다행히 10~20분 안에 들어갈 수 있었답니다. 2인이었는데도 2인 테이블에 좁게 안앉히고 4인 테이블에 넉넉하게 앉혀주셔서 좋았어요. 앞치마도 먼저 챙겨주시고ㅎㅎ 순대국은 정식 안된대서 특으로 먹었는데 고기가 정말 바텀리스..! 순대가 쪼그맣게 4피스인건 조금 아쉬웠지만 부들부들 맛있는 고기가 가득해서 너무 좋았어요. 여기는 언제 먹어도 너무 맛있는 듯ㅎㅎㅎ</div>
									<div>2022-09-28</div>
								</div>
							</div>
							<div class="close_button"></div>
						</div>
					</div>
					<div class="black_screen"></div>
					<div id="more_list"> 
						<!-- <div class="icon_more"> --><img class="fl icon_more1" src="Images/icon_more.png"><!-- </div> -->
						<div class="fl more">더보기</div>
						<!-- <div class="icon_more"> --><img class="fl icon_more2" src="Images/icon_more.png"><!-- </div> -->
						<div style="clear:both;"></div>
					</div>
				</div><!-- header2 out -->
				<!-- header3 in -->
				<div class="title_header3">
					<%if(relatedList.size()!=0){%>
					<!-- best 시작 -->
					<div class="best_restaurant_title"><a href="MatzipDetail.jsp?idx=23" style="text-decoration: underline;"><%=relatedList.get(0).getR_list()%></a>에 있는 다른 식당</div>
					<div class="best_restaurants_list">
					
					<%for(mangoDetailsRelatedDTO dto : relatedList) {%> 
						<div class="fl best_restaurant_content1">
							<a href="mango_details.jsp?detailPk=<%=dto.getId()%>">
								<img class="best_restaurant_img" src="Images/Main_img/<%=dto.getImg()%>">
								<div class="best_restaurant_name">
									<span class="best_name"><%=dto.getName()%></span>
									<strong class="best_score"><%=dto.getScore()%></strong>
									<div class="best_category"><%=dto.getArea()%> - <%=dto.getType()%></div>
								</div>
							</a>	
						</div>
					<% } 
					}%>	
						<div style="clear:both;"></div>
					</div>	<!-- best out -->
				<% if(topList.size() != 0){ %>
					<div id="related_top">
						<div class="related_top_title">관련 TOP 리스트</div>
						<div>
							<div class="related_top_list">
								<div class="related_top_item">							
									<div class="fl related_top_content1">
										<a href="MatzipDetail.jsp?idx=22">
											<div class="dark"></div>
											<div class="image_below_dark" style="background-image : url(Images/Main_img/<%=topList.get(0).getImg()%>)"></div>
											<div class="related_top_content_title"><%=topList.get(0).getTitle() %></div>
											<div class="related_top_content_content">"<%=topList.get(0).getMent() %>"</div>
										</a>
									</div>
								<% if(topList.size() >= 2){ %>
									<div class="fl related_top_content2">
										<a href="MatzipDetail.jsp?idx=22">
											<div class="dark"></div>
											<div class="image_below_dark" style="background-image : url(Images/Main_img/<%=topList.get(1).getImg()%>)"></div>
											<div class="related_top_content_title"><%=topList.get(1).getTitle() %></div>
											<div class="related_top_content_content">"<%=topList.get(1).getMent() %>"</div>
										</a>
									</div>
								<% } %>	
									<div style="clear:both;"></div>
								</div>	
								<div class="related_top_item">
								<% if(topList.size() >= 3){ %>							
									<div class="fl related_top_content3">
										<a href="MatzipDetail.jsp?idx=22">
											<div class="dark"></div>
											<div class="image_below_dark" style="background-image : url(Images/Main_img/<%=topList.get(2).getImg()%>)"></div>
											<div class="related_top_content_title"><%=topList.get(2).getTitle() %></div>
											<div class="related_top_content_content">"<%=topList.get(2).getMent() %>"</div>
										</a>
									</div>
								<% } %> 
								<% if(topList.size() >= 4){ %>
									<div class="fl related_top_content4">
										<a href="MatzipDetail.jsp?idx=22">
											<div class="dark"></div>
											<div class="image_below_dark" style="background-image : url(Images/Main_img/<%=topList.get(3).getImg()%>)"></div>
											<div class="related_top_content_title"><%=topList.get(3).getTitle() %></div>
											<div class="related_top_content_content">"<%=topList.get(3).getMent() %>"</div>
										</a>
									</div>
								<% } %>	
									<div style="clear:both;"></div>
								</div>	
							</div>	<!-- related_list out -->
						</div>
					</div>	<!-- related top out -->
				<% } %>	
				<% if(storyList.size() != 0 ) {%>
					<div id="related_story">
						<div class="related_story_title">관련 스토리</div>
							<div>
								<div class="related_story_list">
									<div class="related_story_item">
										<div class="fl related_story_content1">
											<a href="Mango_storyContent2.jsp?story_id=12">
												<div class="dark"></div>											
												<div class="image_below_dark" style="background-image : url(Images/StoryMain_Img/<%=storyList.get(0).getImg()%>)"></div>
												<div class="related_story_content_title"><%=storyList.get(0).getTitle() %></div>
												<div class="related_story_content_content">"<%=storyList.get(0).getSubTitle() %>"</div>
											</a>
										</div>
									<% if(storyList.size() >= 2){ %>
										<div class="fl related_story_content2">
											<a href="Mango_storyContent2.jsp?story_id=13">
												<div class="dark"></div>
												<div class="image_below_dark" style="background-image: url(Images/StoryMain_Img/<%=storyList.get(1).getImg()%>)"></div>
												<div class="related_story_content_title"><%=storyList.get(1).getTitle() %></div>
												<div class="related_story_content_content">"<%=storyList.get(1).getSubTitle() %>"</div>
											</a>
										</div>
									<% } %>
										<div style="clear:both;"></div>
									</div>	
									<div class="related_story_item">			
									<% if(storyList.size() >= 3){ %>				
										<div class="fl related_story_content3">
											<a href="Mango_storyContent2.jsp?story_id=14">
												<div class="dark"></div>
												<div class="image_below_dark" style="background-image: url(Images/StoryMain_Img/<%=storyList.get(2).getImg()%>)"></div>
												<div class="related_story_content_title"><%=storyList.get(2).getTitle() %></div>
												<div class="related_story_content_content">"<%=storyList.get(2).getSubTitle() %>"</div>
											</a>
										</div>
									<% } %>
									<% if(storyList.size() >= 4){ %>	
										<div class="fl related_story_content4">
											<a href="Mango_storyContent2.jsp?story_id=155">
												<div class="dark"></div>
												<div class="image_below_dark" style="background-image: url(Images/StoryMain_Img/<%=storyList.get(3).getImg()%>)"></div>
												<div class="related_story_content_title"><%=storyList.get(3).getTitle() %></div>
												<div class="related_story_content_content">"<%=storyList.get(3).getSubTitle() %>"</div>
											</a>
										</div>
									<% } %>	
										<div style="clear:both;"></div>
									</div>
								</div>	<!-- related_list out -->
							</div>
						</div>	<!-- related_story out -->
						<% } %>
				</div>	<!-- header3 out -->
			</div>	<!-- title out -->
			<!-- map in-->
			<div class="fl side">
				<div id="map"></div>
				
		<script>	//지도 위에 설정하면 ERR(body안에 사용해야함)
		//----------------------------------------------------------------카카오지도
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
			mapOption = {
			    center: new kakao.maps.LatLng(<%=DetailList.getLatitude()%>, <%=DetailList.getLongitude()%>), // 지도의 중심좌표
			    level: 3 // 지도의 확대 레벨
			};
			
			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
			
			//마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다
			var positions = [
			{
			    content: '<div>농민백암왕순대</div>',
			    latlng: new kakao.maps.LatLng(<%=DetailList.getLatitude()%>, <%=DetailList.getLongitude()%>)
			}
			];
			
			for (var i = 0; i < positions.length; i ++) {
			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
			    map: map, // 마커를 표시할 지도
			    position: positions[i].latlng // 마커의 위치
			});
			
			// 마커에 표시할 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
			    content: positions[i].content // 인포윈도우에 표시할 내용
			});
			
			// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
			// 이벤트 리스너로는 클로저를 만들어 등록합니다
			// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
			kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
			kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
			}
			
			//인포윈도우를 표시하는 클로저를 만드는 함수입니다
			function makeOverListener(map, marker, infowindow) {
			return function() {
			    	infowindow.open(map, marker);
				};
			}
			
			//인포윈도우를 닫는 클로저를 만드는 함수입니다
			function makeOutListener(infowindow) {
			return function() {
			   		infowindow.close();
				};
			}
		//-----------------------------------------------------------------------
		</script>
				<!-- map out-->
				<div id="side_body">
					<div class="near_restaurant">
						<div class="near_title">주변 인기 식당</div>
						<div class="near_items">
						<% for(mangoDetailsNearDTO dto : nearList){ %>
							<div class="near_content">
								<div>
									<a href="mango_details.jsp?detailPk=<%=dto.getId()%>"><img class="fl near_img" src="Images/Main_img/<%=dto.getMainImg()%>"></a>
									<div class="fl near_content_inner">
										<div class="near_content_inner_box">
											<a href="https://www.mangoplate.com/restaurants/t_t308ONIJ"><div class="fl near_name"><%=dto.getName() %></div></a>
											<div class="fl near_score"><%=dto.getScore() %></div>
											<div style="clear:both;"></div>
										</div>
										<div class="near_content_inner_box">
											<div class="fl near_category1">음식 종류:</div>
											<div class="fl near_category2"><%=dto.getType() %></div>
											<div style="clear:both;"></div>
										</div>
										<div class="near_content_inner_box">
											<div class="fl near_category1">위치:</div>
											<div class="fl near_category2"><%=dto.getArea() %></div>
											<div style="clear:both;"></div>
										</div>
										<div class="near_content_inner_box">
											<div class="fl near_category1">가격대:</div>
											<div class="fl near_category2"><%=dto.getPrice() %></div>
											<div style="clear:both;"></div>
										</div>
									</div>
									<div style="clear:both;"></div>
								</div>
							</div>
						<% } %>	
						</div>	<!-- near_item out -->
					</div>	<!-- near_restaurant out -->
					<div class="related_hashtag">
						<div class="hashtag_title">이 식당 관련 태그</div>
						<div class="hashtag_items">
						<% if(DetailList.getHashtag() != null){
							for(int i=0; i<=DetailList.getHashtagArr().length-1; i++) { %>
							<div class="fl hashtag_box">
								<a href="Mango_popularSearch2.jsp?keyword=강남역">
									<div class="hashtag">#<%=DetailList.getHashtagArr()[i] %></div>
								</a>
							</div>
						<% 	} 
						   }%>
							<div style="clear:both;"></div>
						</div>
					</div>
				</div>	<!-- side_body out -->
			</div> <!--  side out -->
		</div>
		<div id = "map2"></div>
<script>	//지도 위에 설정하면 ERR(body안에 사용해야함)
	//----------------------------------------------------------------카카오지도
		var mapContainer = document.getElementById('map2'), // 지도를 표시할 div  
		mapOption = {
		    center: new kakao.maps.LatLng(<%=DetailList.getLatitude()%>, <%=DetailList.getLongitude()%>), // 지도의 중심좌표
		    level: 7 // 지도의 확대 레벨
		};
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		
		//마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다
		var positions = [
		{
		    content: '<div>농민백암왕순대</div>',
		    latlng: new kakao.maps.LatLng(<%=DetailList.getLatitude()%>, <%=DetailList.getLongitude()%>)
		}
		];
		
		for (var i = 0; i < positions.length; i ++) {
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    map: map, // 마커를 표시할 지도
		    position: positions[i].latlng // 마커의 위치
		});
		var markerPosition = marker.getPosition(); 
		 
		function relayout() {    
		  

			// 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
		    // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
		    // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
		    map.relayout();
		}
		
		
		// 마커에 표시할 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
		    content: positions[i].content // 인포윈도우에 표시할 내용
		});
		
		// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
		// 이벤트 리스너로는 클로저를 만들어 등록합니다
		// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
		kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
		kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
		}
		
		//인포윈도우를 표시하는 클로저를 만드는 함수입니다
		function makeOverListener(map, marker, infowindow) {
		return function() {
		    	infowindow.open(map, marker);
			};
		}
		
		//인포윈도우를 닫는 클로저를 만드는 함수입니다
		function makeOutListener(infowindow) {
		return function() {
		   		infowindow.close();
			};
		}
	//-----------------------------------------------------------------------
</script>
		<div class="black_screen"></div>
	</div>	<!-- column-contents out -->
	<div style="clear:both"></div>
	<div class="footer">
		<div class="footer_inner">
			<div class="footer_logo">
				<img class="footer_logo_img" src="Images/footer_logo.png">
				<div class="footer_logo_subtitle">Eat, Share, Be Happy.</div>
			</div>
			<div class="footer_content">
				<div class="fl footer_content_item">
					<div class="footer_content_name">회사소개</div>			
					<div class="footer_content_name">망고플레이트 채용</div>			
					<div class="footer_content_name">투자 정보</div>			
					<div class="footer_content_name">브랜드 가이드라인</div>			
					<div class="footer_content_name">망고플레이트 비즈니스</div>			
					<div class="footer_content_name">광고 문의</div>			
				</div>
				<div class="fl footer_content_item">
					<div class="footer_content_name">공지사항</div>			
					<div class="footer_content_name">이용약관</div>			
					<div class="footer_content_name">비회원 이용자 이용정책</div>			
					<div class="footer_content_name">개인정보처리방침</div>			
					<div class="footer_content_name">위치기반서비스 이용약관</div>			
					<div class="footer_content_name">커뮤니티 가이드라인</div>			
					<div class="footer_content_name">청소년보호정책</div>			
					<div class="footer_content_name">홀릭 소개</div>			
					<div class="footer_content_name">문의하기</div>			
				</div>
				<div style="clear:both;"></div>
			</div>
			<div class="footer_sns">
				<img class="fl footer_sns_img" src="Images/icon_facebook.png">
				<img class="fl footer_sns_img" src="Images/icon_instargram.png">
				<div style="clear:both;"></div>
			</div>
			<div class="footer_location">
				<div class="fl footer_location_item">인기지역&nbsp:&nbsp</div> 
				<div class="fl footer_location_item">이태원&nbsp|&nbsp</div> 
				<div class="fl footer_location_item">홍대&nbsp|&nbsp</div> 
				<div class="fl footer_location_item">강남역&nbsp|&nbsp</div>
				<div class="fl footer_location_item">가로수길&nbsp|&nbsp</div>
				<div class="fl footer_location_item">신촌&nbsp|&nbsp</div>
				<div class="fl footer_location_item">명동&nbsp|&nbsp</div>
				<div class="fl footer_location_item">대학로&nbsp|&nbsp</div>
				<div class="fl footer_location_item">연남동&nbsp|&nbsp</div>
				<div class="fl footer_location_item">부산&nbsp|&nbsp</div>
				<div class="fl footer_location_item">합정&nbsp|&nbsp</div>
				<div class="fl footer_location_item">대구&nbsp|&nbsp</div>
				<div class="fl footer_location_item">여의도&nbsp|&nbsp</div>
				<div class="fl footer_location_item">건대&nbsp|&nbsp</div>
				<div class="fl footer_location_item">광화문&nbsp|&nbsp</div>
				<div class="fl footer_location_item">일산&nbsp|&nbsp</div>
				<div class="fl footer_location_item">제주&nbsp|&nbsp</div>
				<div class="fl footer_location_item">경리단길&nbsp|&nbsp</div>
				<div class="fl footer_location_item">한남동&nbsp|&nbsp</div>
				<div class="fl footer_location_item">삼청동&nbsp|&nbsp</div>
				<div class="fl footer_location_item">대전&nbsp|&nbsp</div>
				<div class="fl footer_location_item">종로&nbsp|&nbsp</div>
				<div class="fl footer_location_item">서촌&nbsp|&nbsp</div>
				<div class="fl footer_location_item">잠실&nbsp|&nbsp</div>
				<div class="fl footer_location_item">사당역&nbsp|&nbsp</div>
				<div class="fl footer_location_item">인천</div>
				<div class="fl footer_location_item">|&nbsp코엑스&nbsp|&nbsp</div>
				<div class="fl footer_location_item">상수&nbsp|&nbsp</div>
				<div class="fl footer_location_item">서래마을&nbsp|&nbsp</div>
				<div class="fl footer_location_item">송도&nbsp|&nbsp</div>
				<div class="fl footer_location_item">왕십리&nbsp|&nbsp</div>
				<div class="fl footer_location_item">분당&nbsp|&nbsp</div>
				<div class="fl footer_location_item">혜화&nbsp|&nbsp</div>
				<div class="fl footer_location_item">고속터미널</div>
				<div style="clear:both;"></div>
			</div>
			<div class="footer_copyrights">
				<div class="fr footer_copyrights_language">
					<div class="fl language">한국어</div>
					<div class="fl language">&nbsp&nbsp|&nbsp&nbsp English &nbsp&nbsp|&nbsp&nbsp</div>
					<div class="fl language">简体中文</div>
					<div style="clear:both;"></div>
				</div>
				<p class="fl">
					㈜ 여기어때컴퍼니<br/>
					서울특별시 강남구 봉은사로 479, 479타워 11층<br/>
					대표이사: 정명훈<br/>
					사업자 등록번호: 742-86-00224 [<u style="font-weight: 700;">사업자정보확인</u>]<br/>
					통신판매업 신고번호: 2017-서울강남-01779<br/>
					고객센터: 02-565-5988<br/>
					<br/>
					© 2022 MangoPlate Co., Ltd. All rights reserved.
				</p>
				
				<div style="clear:both;"></div>
			</div>
		</div><!-- footer_inner out -->
	</div>	<!-- footer out -->
</body>
</html>