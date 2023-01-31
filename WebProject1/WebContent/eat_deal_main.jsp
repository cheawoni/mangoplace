 <%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.mango.eatdeal.dto.*"%>
<%@page import="com.mango.eatdeal.dao.*"%>
<%@page import="org.json.simple.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<html lang="kor">
 <link rel="stylesheet" href="mango_bener.css">
<head>

    <meta charset="UTF-8">
    <!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>eat_deal</title>
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
    <link rel="icon" href="Images/mango_favicon.png">
    <link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-kr.css' rel='stylesheet' type='text/css'>
    <script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
    <script>
    $(".input_search_content_keywordList").mouseenter(function() {
        $(this).css('background','#f7f7f7');
     });
     $(".input_search_content_keywordList").mouseleave(function() {
        $(this).css('background','#fff');
     });
    $(function(){
    	$("#div_header > .header_right").eq(3).find("span").click(function() {
            alert("EAT딜 이동!");
            location.href = "Mango_eatDeal.jsp";
         });
         
         $("#div_header > .header_right").eq(2).find("span").click(function() {
            alert("맛집 리스트 이동!");
            location.href = "Mango_resturantList.jsp";
         });
         
         $("#div_header > .header_right").eq(1).find("span").click(function() {
            alert("망고 스토리 이동!");
            location.href = "Mango_storyList.jsp";
         });
         
         $("#img_logo").click(function() {
            alert("망고플레이트 이동!");
            location.href = "Mango_home.jsp"
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

    //스크롤
    $(".keywordListWrap_inner").mouseenter(function() {
    $(this).css('overflow','auto');
    });

    $(".keywordListWrap_inner").mouseleave(function() {
    $(this).css('overflow','hidden');
    });

    $(".small_popular_search").css('display','none');
    $(".small_history_search").css('display','none');
    $(".small_recommended_search").css('display','block');

    //엔터키이벤트 엔터를 누르면 발생
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
 // 쿠키 --------------------------------------------------------------------------------------------------
    applyRecentListFromList(arrRecent);
    // 쿠키 끝--------------------------------------------------------------------------------------------------
 
    });
    //헤더 인기검색 팝업창 시작--------------------------------------------------------------------------------

    //헤더 인기검색어 팝업창 끝--------------------------------------------------------------------------------------

            function light_off() {
                if ($('#black').css('display') == 'inline-block') {
                    $('#black').css('display', 'none');
                } else {
                    $('#black').css('display', 'inline-block');
                }
            }




            function change() {
                if ($('#button2').css('display') == 'inline') {
                    $('#button1').css('display', 'inline');
                    $('#button2').css('display', 'none');
                    $('#button3').css('display', 'none');
                    $('#button4').css('display', 'inline');
                    $('#lately').css('display', 'inline');
                    $('#wish').css('display', 'none');
                }
                else if ($('#button4').css('display') == 'inline') {
                    $('#button3').css('display', 'inline');
                    $('#button4').css('display', 'none');
                    $('#button2').css('display', 'inline');
                    $('#button1').css('display', 'none');
                    $('#lately').css('display', 'none');
                    $('#wish').css('display', 'inline');
                }
            };
            $(function (){
                function service(){
                		let signIn = "${loginEmail}";
                		//alert(signIn);
                		console.log(signIn);
                		
                		if (signIn == ""){
                			$('.logout').css('display', 'inline');
                			$('.login').css('display', 'none');
                			$('.Login_Button').css('display', 'inline');
                			$('.My_Info').css('display', 'none');
                			//alert("서비스 페이지는 로그인 후 사용하실 수 있습니다.");
                			/* location.href="${cpath}/login.do"; */
                		} else {
                			/* location.href="${cpath}/service.do" */
                		}
                	}
                service();
            	});

    let pageNumber = 1;
    $(function(){
        $('nav ul li button').click(function(){
                $('nav ul li button').each(function(){
                    $(this).attr('class', 'area_filter_detail');
                    $(this).parent().attr('class', 'area_filter');
                });
                $(this).attr('class', 'area_filter_detail2');
                $(this).parent().attr('class', 'area_filter_on');
            });
            
        $('.area_select_buttons').click(function(){
            if($(this).attr('class')=='area_select_buttons'){
                $(this).attr('class', 'area_select_buttons2');
                $(this).children().attr('class', 'area_select_button2');
            }else{
                $(this).attr('class', 'area_select_buttons');
                $(this).children().attr('class', 'area_select_button');
                $('.area_list li:first-child').attr('class', 'area_select_buttons');
                $('.area_list li').children().attr('class', 'area_select_button');
            }
        });

        $('.area_list li:first-child').click(function(){
            if($(this).attr('class')=='area_select_buttons2'){
                $(this).attr('class', 'area_select_buttons2');
                $(this).siblings('li').attr('class', 'area_select_buttons2');
                $(this).siblings().children('button').attr('class', 'area_select_button2');
                $(this).children('button').attr('class', 'area_select_button2');
            }else{
                $(this).attr('class', 'area_select_buttons');
                $(this).siblings('li').attr('class', 'area_select_buttons');
                $(this).siblings().children('button').attr('class', 'area_select_button');
                $(this).children('button').attr('class', 'area_select_button');
            }
        });

        $('nav ul li button').click(function(){
            idx = $('nav ul li button').index($(this));
            
            $('.area_list').each(function(idx_2, obj){
                
                if(idx==idx_2){ 
                    $(this).css({ display:'block'});
                }else{
                    $(this).css({ display:'none'});
                }
            });
    
        });
		
        $(function(){
            // 무한 스크롤
            $(window).scroll(function() {
                // 맨 밑으로 스크롤이 갔을경우 if문을 탑니다.
                 let $window = $(this);
		         let scrollTop = $window.scrollTop();
		         let windowHeight = $window.height();
		         let documentHeight = $(document).height();
                if(scrollTop + windowHeight + 10 > documentHeight) { 
                    //alert("됨?");
                	pageNumber++; // 현재 페이지에서 +1 처리.
                	
//    					contentType: "application/json", //; charset=UTF-8",
                    $.ajax({
    					type: "get",
    					contentType: "application/json; charset=UTF-8",
    					url: "EatDealMainServlet",
    					data: {"pageNumber" : pageNumber},
    					datatype: "json",
    					success: function(data){
    						
    						let list = data;
    						//alert(list[0].area);
    						//console.log(list.size);
    						$.each(data,function(idx,e){
    							let display1 = "";
    							let display2 = "";
    							if(list[idx].neww!=null){
    								display1 = "inline-block";
    							}else{display1 = "none";}
    							if(list[idx].info!=null){
    								display2 = "inline-block";
    							}else{display2 = "none";}
    							console.log('asd');
    							console.log(list[1].area, list[1].name);
		                    	$('.endDiv').last().append(
		                    			
		                    			'<div style=\"position: relative; margin: 0 auto; height: 383px; width: 766px; display: block;\">'+
		                    			'<a style="color:#4F4F4F;" href=\"eat_detail.jsp?detailIdx='+list[idx].dealIdx+'\">'+
		                                    '<div class=\"EatDealItem__BGPicture\" style=\"background-image: url(Images/EAT딜메인/'+list[idx].main_theme+');\">'+
		                    					'<div class=\"pic_shadow\"></div></div>'+
		                                    '<div style=\"height: 70px; width: 766px; position: absolute; box-sizing: border-box; bottom: 0px; \">'+
		                                        '<div style=\"height: 56px; width: 57px;\">'+
		                                            '<img style=\"height: 24px; width: 57px; margin-bottom: 8px; display : '+display1+';'+
		                                            '\" src=\"Images/new.png\" alt=\"\">'+
		                                            '<div style=\"width: 32px; height: 24px; padding-left: 15px; padding-right: 8px;background-color: #14CBB2;'+
		                                            'border-top-right-radius: 4px; border-bottom-right-radius: 4px; font-size: 15px; line-height: 20px; letter-spacing: 0;'+
		                                             'color: #FFFFFF;\">'+list[idx].discount+'%</div>'+
		                                        '</div>'+
		                                        '<div style=\"width: 81px; height: 47px; margin-bottom: 10px;'+
		                                                     'position: absolute; right: 15px; bottom: 0; z-index: 2; margin-bottom: 15px; \">'+
		                                            '<div class=\"origin_pri\" style=\"margin-left: auto; height: 18px; width: 48px;  \">\\'+list[idx].price+'</div>'+
		                                            '<div style=\"height: 27px; width: auto; text-align : right; \"><span class=\"next_pri\">\\'+list[idx].discounted+'</span></div>'+
		                                        '</div>'+
		                                    '</div>'+
		                                '</div>'+
		                                    '<div style=\"position: static; margin: 0 auto; padding: 15px 15px 33px 15px; height: auto; width: 736px;background-color: white; \">'+
		                                        '<div class=\"Eat_name\" style=\"height: 24px; width: 736px;  margin-bottom: 10px;\">['+list[idx].area+'] '+list[idx].name+' </div>'+
		                                        '<div class=\"Eat_menu\" style=\"height: 20px; width: 736px;  \">'+list[idx].menu+' </div>'+
		                                        '<div class=\"Eat_ment\" style=\"height: auto; width: 716px; padding: 10px; margin-top: 8px ; display : '+display2+'\">'+
		                                        	list[idx].info+
		                                        '</div>'+
		                                '</a>'+
		                        '</div>'
		                    			
		                    	);
    							
    						});
		                    	
    						
    					
    					},
    					error: function(r,s,e){
    						alert("에러!");
    					}
    				}); 	
                } 
            }); 
        });
   



    });
    // $(function(){
    //     $('.area_select_buttons').click(function(){
    //         $(this).attr('class', 'area_select_buttons2');
    //         $(this).children().attr('class', 'area_select_button2');
    //     });

    //     $('.area_select_buttons2').click(function(){
    //         $(this).attr('class', 'area_select_buttons');
    //         $(this).children().attr('class', 'area_select_button');
    //     });
    // });
    // $('nav ul li button').index();
    // $('#area_list').index();








    </script>
    
    <style>
        
      #div_header {   /* 망고 헤더부분 로고,검색기능 등등... */
         position: fixed;
         border-bottom: 1px solid #DBDBDB;
          box-shadow: 0 4px 11px rgb(0 0 0 / 10%);
          background-color: #FFFFFF;
         box-sizing: border-box;
         width: 100%;
         height: 61px;
         top: 0;
         left: 0;
         /* padding: 14px; */
         margin-left: 0;
         z-index: 1000;
      }
      #img_logo {      /* (1)헤더 망고플레이트 로고 */
          margin-left: 23px;
          margin-top: 13px;
          width: 100px;
          height: 33px;
         }
      #img_search {   /* (2)헤더 서치아이콘 로고 */
         margin-left: 40px;
          margin-top: 11px;
          height: 37px;
          margin-right: 5px;
          background-size: auto;
      }
      body > #div_header > div.fr {   /* (헤더 오른쪽 기능) fr 클래스에 왼쪽 선 추가*/
         padding: 0;
         margin: 0;
         position: relative;
         font-size: 16px;
         color: #888888;
          height: 100%;
          border-left: 1px solid #dbdbdb;   /* 왼쪽 선 추가 */
      }
      body > #div_header > div:nth-child(2) > label {      /* (2)헤더 왼쪽 서치아이콘 */
         margin-top: -27px;
         display: block;
         margin-left: 95px;
      }
      body > #div_header > div:nth-child(2) > label > input[type='text'] {   /* 헤더 검색 기능 안에 들어올 text */
         height: 27px;
         border-color: transparent;
         outline: none;
         font-size: 16px;
         margin-left: -10px;
         margin-top: -5px;
      } 
      body > #div_header > div:nth-child(2) > label > input[type='text']::placeholder {   /* 헤더 검색 기능 placeholder의 스타일적용 */
         color: #7f7f7f;
         font-weight: 400;
      }
      body > #div_header > div:nth-child(3) {   /* (3)헤더 오른쪽 유저아이콘 */
         line-height: 16px;
         width: 85px;
            text-align: center;
      }
      body > #div_header > div:nth-child(3) > img {   /* 유저아이콘 이미지 */
         width: 59px;
         margin-top: 6px;
      }
      body > #div_header > div:nth-child(4) { /* (4)헤더 오른쪽 망고스토리 아이콘 */
         width: 129px;
         text-align: center;
      }
      body > #div_header > div:nth-child(4) > span { /* 망고 스토리 글씨*/
         display: block;
         margin-top: 22px;
         line-height: 16px;
      }
      body > #div_header > div:nth-child(5) { /* (5)헤더 오른쪽 맛집 리스트 아이콘 */
         line-height: 16px;
         width: 129px;
         text-align: center;
      }
      body > #div_header > div:nth-child(5) > span { /* 맛집 리스트 글씨*/
         display: block;
         margin-top: 22px;
         line-height: 16px;
      }
      body > #div_header > div:nth-child(6) { /* (6)헤더 오른쪽 EAT딜 아이콘 */
         width: 129px;
         text-align: center;
      }
      .header_right_new::after {
          content: '';
          position: absolute;
          top: 11px;
          right: 32px;
          display: block;
          width: 15px;
          height: 15px;
          background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/web/resources/uo3o88vopcmdsket.png);
          background-size: cover;
      }
      body > #div_header > div:nth-child(6) > span { /* 망고 스토리 글씨 */
         display: block;
         margin-top: 22px;
         line-height: 16px;
      }
      .fl { 
            float:left;
        }
        .fr { 
            float:right;
        }
        /* 인기검색어 팝업창 시작*/
        .input_search_keyword_open {
           display: block;
        }
        .input_search_keyword:not(.open) {
           display: none;
        }
        .input_search_backgroundDark {
           display : block;
           /* display: none;  input_search_open이 되면 none으로 바뀜.*/
          position: fixed;
          top: 0;
          left: 0;
          z-index: 890;
          width: 100%;
          height: 100%;
          background-color: rgba(0,0,0,0.8);
        }
        .input_search_content {
            position: fixed;
            top: 61px;
          left: 214px;
          z-index: 1100;
          width: 660px;
          border: 1px solid #DBDBDB;
          border-top: 0;
          border-radius: 0 0 3px 3px;
          box-sizing: border-box;
          background-color: #FFFFFF;
        }
        .input_search_content_inner {
           padding: 0 24px;
        }
        .input_search_content_list {
           display: flex;
          flex-wrap: nowrap;
          justify-content: space-around;
          align-items: center;
           height: 50px;
            position: relative;
          width: 100%;
          border-bottom: 1px solid #DBDBDB;
           font-size: 16px;
          color: #7F7F7F;
        }
        .input_search_content_keywordList {
           display: flex;
          padding: 0px 5px;
          height: 60px;
          align-items: center;
           border-bottom: 1px solid #DBDBDB;
           cursor: pointer;
        }
        .keywordList_item_img {
              background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/web/resources/2018022864551sprites_desktop.png);
              background-position: -974px -752px;
             width: 30px;
             height: 23px;
             margin: 0 12px 0 7px;
         }
        .input_search_keywordList_item {
           font-size: 14px;
          color: #7F7F7F;
          height: 18px;
        }
      .keywordListWrap_inner {
         height: 250px;
          overflow-y: scroll;
             width: 100%;
           padding: 0px 25px 0px 0px;
      } 
      .keywordListWrap_inner::-webkit-scrollbar-track {
         background-color: #fff;
        }
        .keywordListWrap_inner::-webkit-scrollbar {
         width: 7px;
         background-color: #f5f5f5;
        }
        .keywordListWrap_inner::-webkit-scrollbar-thumb {
         border-radius: 7px;
         background-color: #808080;
        }
      .inputSearchItem_tapButton-selected:after {
          content: '';
          position: absolute;
          bottom: -1px;
          left: 0;
          width: 100%;
          height: 3px;
          background-color: #ff7100;
      }
      .input_search_item_inner {
          display: flex;
          justify-content: center;
          width: 100%;
          height: 100%;
             align-items: center;
      }
      .input_search_item {
          display: flex;
          position: relative;
          justify-content: center;
          align-items: center;
          width: 100%;
          height: 100%;
      }
      .input_search_keywordList_item_none {
         display: flex;
          justify-content: center;
          height: 77px;
          width: 100%;
          align-items: center;
      }
      .Triangle {
    position: absolute;
    top: -10px;
    right: 20px;
    width: 0;
    border-width: 0 16px 16px;
    border-color: #FFFFFF transparent;
    border-style: solid;
}

.bener_box {
    position: fixed;
    top: 72px;
    right: 10px;
    border-radius: 0 0 3px 3px;
    background-color: #FFFFFF;
    height: 532px;
    width: 320px;
    z-index: 1100;
    position: fixed;
}

.Two_button {
    border-bottom: 0;
    box-shadow: inset 0 -3px #ff792a;
    color: #ff792a;
    height: 50px;
    width: 156px;
    font-size: 16px;
}

button {
    appearance: none;
    cursor: pointer;
    border: 0px;
    border-radius: 0;
    background-color: transparent;
}

.button_font {
    width: 100%;
    border-bottom: 1px solid #DBDBDB;
    box-sizing: border-box;
    font-size: 16px;
    text-align: center;
    color: #9b9b9b;
    height: 50px;
    width: 156px;
}

.AllClear_Button {
    margin-left: auto;
    font-size: 11px;
    line-height: 19px;
    color: #dbdbdb;
    margin-left: 233px;
    display: inline-block;
}

.Res_Name {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    word-wrap: normal;
    font-size: 16px;
    color: #000000;
    font-weight: normal;
    margin-top: 0px;
    width: 92px;
    float: left;
    margin: 0;
}

ol,
ul,
ul li {
    list-style: none;
}

.Score {
    margin-left: 5px;
    font-size: 16px;
    color: #ff792a;
}

.Res_Pic {
    width: 70px;
    height: 70px;
    margin-right: 16px;
    background-size: cover;
    background-position: 50% 50%;
    background-color: #E6E6E6;
    background-position: 50%;
    display: inline-block;
}

.Black-out {
    position: fixed;
    top: 0;
    left: 0;
    z-index: 1000;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.6);
}

.Login_Button {
    display: none;
    width: 100%;
    height: 50px;
    border: 2px solid #ff792a;
    border-radius: 50px;
    font-size: 16px;
    color: #FF7100;
}

.My_Info {
    /* display: none; */
    margin-left: auto;
    font-size: 15px;
    font-weight: normal;
    font-stretch: normal;
    font-style: normal;
    line-height: normal;
    letter-spacing: normal;
    color: #7f7f7f;
}
a{
            text-decoration: none;
        }
        .Eat_name{
            overflow: hidden;;
            white-space: nowrap;
            text-overflow: ellipsis
            word-wrap: normal;
            margin-right: 10px;
            font-size: 16px;
            line-height: 24px;
            letter-spacing: 0;
            font-weight: bold;
            color: #4F4F4F;
        }
        .Eat_menu{
            font-size: 14px;
            line-height: 20px;
            letter-spacing: 0;
            color: #7F7F7F;
        }
        .Eat_ment{
            margin-top: 8px;
            padding: 10px;
            border-radius: 6px;
            font-size: 12px;
            line-height: 20px;
            word-break: break-all;
            color: #7F7F7F;
            background-color: #F3F3F3;
        }
        .origin_pri{
            font-size: 12px;
            line-height: 1.5;
            letter-spacing: 0;
            text-decoration: line-through;
            color: white;
            text-align: right;
        }
        .next_pri{
            font-size: 20px;
            line-height: 1.45;
            letter-spacing: 0;
            font-weight: bold;
            color: white;
        }
        .EatDealItem__BGPicture {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
            background-size: cover;
            background-position: 50% 50%;
            background-color: #F3F3F3;
        }
        .select_area{
            padding: 6px 12px 8px;
            margin: 10px 0 10px 15px;
            border: 1px solid #ff792a;
            border-radius: 50px;
            background-color: #FFFFFF;
        }
        a{
            text-decoration: none;
        }
        .select_area_text {
        margin-right: 6px;
        font-size: 14px;
        line-height: 16px;
        color: #ff792a;
        }
        .select_area_box{
        top: 61px;
        left: 50%;
        max-width: 768px;
        height: calc(100% - 61px);
        width: 100%;
        z-index: 1000;
        background-color: #FFFFFF;
        }
        .X_button{
        position : absolute;
        top: 14px;
        right: 0;
        width: 45px;
        height: 45px;
        background-image: url("https://mp-seoul-image-production-s3.mangoplate.com/web/resources/ic-closed.svg");
        background-size: cover;
        }
        .orange_bar{
        position: absolute;
        top: 0;
        left: 0;
        height: 2px;
        background-color: #ff792a;
        width: 93px;
        }
        .area_filter{
        display: inline-block;
        padding: 16px 20px 18px;
        cursor: pointer;
        }
        .area_filter_on{
        display: inline-block;
        padding: 16px 20px 18px;
        cursor: pointer;
        border-top: 3px solid #ff792a;
        }
        .area_filter_detail{
        position: relative;
        overflow: visible;
        font-size: 13px;
        line-height: 16px;
        color: #7F7F7F;
        }
        .area_filter_detail2{
        position: relative;
        overflow: visible;
        font-size: 13px;
        line-height: 16px;
        color: #ff792a;
        }
        ol, ul, ul li {
        list-style: none;
        }
        .area_select_buttons{
        position: relative;
        margin-right: 10px;
        float: left;
        display: block;
        width: 340px;
        height: 50px;
        border: 1px solid #CBCBCB;
        border-radius: 50px;
        margin-bottom: 10px;
        box-sizing: border-box;
        cursor: pointer;
        }
        .area_select_buttons2{
        position: relative;
        margin-right: 10px;
        float: left;
        display: block;
        width: 340px;
        height: 50px;
        border: 1px solid #ff792a;
        border-radius: 50px;
        margin-bottom: 10px;
        box-sizing: border-box;
        cursor: pointer;
        }
        .area_select_buttons2::after{
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        display: block;
        width: 16px;
        height: 15px;
        background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/web/resources/mobile-web-filter-check.svg);
        background-size: cover;
        }
        
        .area_select_button{
        padding: 0 16px;
        font-size: 13px;
        line-height: 18px;
        text-align: center;
        color: #7F7F7F;
        appearance: none;
        cursor: pointer;
        border: 0px;
        border-radius: 0;
        background-color: transparent;
        margin-top: 15px;
        }
        .area_select_button2{
        padding: 0 16px;
        font-size: 13px;
        line-height: 18px;
        text-align: center;
        color: #ff792a;
        appearance: none;
        cursor: pointer;
        border: 0px;
        border-radius: 0;
        background-color: transparent;
        margin-top: 15px;
        }
        button{
        appearance: none;
        cursor: pointer;
        border: 0px;
        padding: 0px;
        }
        .pic_shadow{
        position: absolute;
	    left: 0;
	    bottom: 0;
	    z-index: 1;
	    width: 100%;
	    height: 70px;
	    box-sizing: border-box;
	    background-image: linear-gradient(to bottom, transparent, rgba(0,0,0,0.4));
	    }
        

        </style>
</head>
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
      <div class="fr header_right" onclick="light_off()"><!-- (3)헤더 오른쪽 유저아이콘 -->
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
   
   <div id="black" style="display: none;">

            <!-- 암전 -->
            <div class="Black-out" onclick="light_off()"></div>



            <!-- 비 로그인 시 -->
            <div class="bener_box logout" style="display: none;">
                <i class="Triangle"></i>
                <div style="height: 50px;width: 320px;  margin: 0 auto;">
                    <ul style="margin: 0; padding: 0;">
                        <li style="width: 50%; display: inline;" onclick="">
                            <button class="Two_button" style="height: 50px; width: 156px; font-size: 16px;">최근 본 맛집</button>
                        </li>
                        <li style="width: 50%; display: none;" onclick="">
                            <button class="button_font" style="height: 50px; width: 156px;">최근 본 맛집</button>
                        </li>
                        <li style="width: 50%; display: none;" onclick="">
                            <button class="Two_button"
                                style="height: 50px; width: 156px; font-size: 16px;">가고싶다</button>
                        </li>
                        <li style="width: 50%; display: inline;" onclick="">
                            <button class="button_font" style="height: 50px; width: 156px;">가고싶다</button>
                        </li>
                    </ul>
                </div>

                <div style="height: 413px;  display: inline ;">

                    <div style="height: 413px; display: inline-block;">
                        <div style="height: 85px; width: 288px; margin: 130px 16px 0; text-align: center; display: inline-block;">
                            <span style="display: block; margin-bottom: 10px; font-size: 22px; line-height: 25px; color: #4F4F4F;">
                                	거기가 어디였지?
                            </span>
                            <p style="margin: 0 20px; font-size: 14px; line-height: 25px; color: #ff792a;">
                                	내가 둘러 본 식당이 이 곳에 순서대로 기록됩니다.
                            </p>
                        </div>
                    </div>
                </div>
                <footer style="height: 50px; width: 288px; padding: 10px 16px; border-top: 1px solid #dbdbdb; text-align: right; display: inline-block;">
                    <a href="login.jsp">
	                    <button class="Login_Button">
	                        	로그인
	                    </button>
	                </a>
                    <button class="My_Info">
                        	내정보
                    </button>
                </footer>
            </div>



            <!-- 로그인 시 -->

            <div class="bener_box login" style="height: 507px; width: 320px; display: inline;">
                <i class="Triangle"></i>
                <div style="height: 50px;width: 320px;  margin: 0 auto;">
                    <ul style="margin: 0; padding: 0;">
                        <li id="button1" style="width: 50%; display: inline;">
                            <button class="Two_button">최근 본 맛집</button>
                        </li>
                        <li id="button2" style="width: 50%; display: none;" onclick="change()">
                            <button class="button_font">최근 본 맛집</button>
                        </li>
                        <li id="button3" style="width: 50%; display: none;">
                            <button class="Two_button">가고싶다</button>
                        </li>
                        <li id="button4" style="width: 50%; display: inline;" onclick="change()">
                            <button class="button_font">가고싶다</button>
                        </li>
                    </ul>
                </div>





                <!-- 최근 본 맛집 -->
                <div style="height: 413px; overflow-y: auto; display: inline-block ;">
                    <div id="lately" style="height: 413px; overflow-y: auto; display: inline ;">
                        <button class="AllClear_Button" style="margin-left: 233px; display: inline-block;">
                            x clear all
                        </button>




                        <ul style="height: 1004px; width: 277.2px; margin: 16px 10px 0px 16px; padding: 0; display: inline-block;">
                            <li style="height: 86px; width: 277px; margin-bottom: 16px;">
                                <div style="height: 86px; margin-bottom: 16px;  position: relative;">
                                    <div class="Res_Pic"
                                        style="background-image: url(Images/nongmin.jpg); background-position: 50%; height: 70px; width: 70px; display: inline-block; margin-right: 16px;">
                                    </div>
                                    <div style="position: absolute; height: 86px; width: 121.625px; margin-right: 41.5px; display: inline-block;">
                                        <div style="height: 22px; width: 121px;  ">
                                            <h3 class="Res_Name">농민백암왕순대</h3>
                                            <span class="Score">4.6</span>
                                            <span style="font-size: 12px; color: #6a6a6a;">강남역-한식</span>
                                        </div>
                                    </div>
                                    <div style="background-image: url(Images/star.png); height: 28px; width: 28px; display: inline-block; left: 155px; top: -45px; position: relative;">
                                    </div>
                                </div>
                            </li>


                            
                        </ul>
                    </div>


                    <!-- 가고싶다 -->
                    <div id="wish" style="height: 413px; overflow-y: auto; display: none;">
                        <!-- <div style="height: 413px; overflow-y: auto; display: inline;"> -->

                        <ul style="height: 1004px; width: 277.2px; margin: 16px 10px 0px 16px; padding: 0;">
                            <li style="height: 86px; width: 277px; margin-bottom: 16px;">
                                <div style="height: 86px; margin-bottom: 16px;  position: relative;">
                                    <div class="Res_Pic" style="background-image: url(Images/nongmin.jpg);">
                                    </div>
                                    <div style="position: absolute; height: 86px; width: 121.625px; margin-right: 41.5px; display: inline-block;">
                                        <div style="height: 22px; width: 121px;  ">
                                            <h3 class="Res_Name">농민백암왕순대</h3>
                                            <span class="Score">4.6</span>
                                            <span style="font-size: 12px; color: #6a6a6a;">강남역 - 한식</span>
                                        </div>
                                    </div>
                                    <div style="background-image: url(Images/Star_On.png); height: 28px; width: 28px; display: inline-block; left: 155px; top: -45px; position: relative;">
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>


                <footer style="height: 22.4px; width: 288px; padding: 10px 16px; border-top: 1px solid #dbdbdb; text-align: right;">
	                <a href="login.jsp">
	                    <button class="Login_Button">
	                        	로그인
	                    </button>
	                </a>
                    <a href="mypage.jsp">
                        <button class="My_Info">
                            	내정보
                        </button>
                    </a>
                </footer>

            </div>

</div>
          
        

        
        <main>
        <header>
            <div style=" z-index: 3; position: fixed; height: 50px; width: 768px; margin-left: 560px; background-color: rgba(255,255,255,0.8);">
                <button class="select_area" style="height: 30px;">
                    <span class="select_area_text" onclick="box_on()">지역 선택</span>
                    <img style="position: absolute; top: 23px;" src="https://mp-seoul-image-production-s3.mangoplate.com/web/resources/eat_deals_filter_arrow.svg" alt="">
                </button>
            </div>
        </header>
        
        
<%
	Eat_deal_mainDAO eDAO = new Eat_deal_mainDAO();
	ArrayList<Eat_deal_mainDTO> listE = eDAO.getAllEatdealList();
%>
        <div style=" margin-top: 61px; background-color: #F7F7F7">
        <%
			for(Eat_deal_mainDTO eatlist : listE) { 
		%>
            <div style="position: relative; margin: 0 auto; height: 383px; width: 766px; display: block;">
                
                <a href="eat_detail.jsp?detailIdx=<%=eatlist.getDealIdx()%>" >

                    <div class="EatDealItem__BGPicture" style="background-image: url(Images/EAT딜메인/<%=eatlist.getMain_theme()%>);">
    					<div class="pic_shadow">
    					
    					</div>
                    </div>
    
                    <div style="height: 70px; width: 766px; position: absolute; box-sizing: border-box; bottom: 0px; ">
                        <div style="height: 56px; width: 57px;">
                            <img style="height: 24px; width: 57px; margin-bottom: 8px; display : <%
                            if(eatlist.getNeww()==1){
                            	out.println("inline-block");
                            }else{
                            	out.println("none");
                            }
                            %>" src="Images/new.png" alt="">
                            <div style="width: 32px; height: 24px; padding-left: 15px; padding-right: 8px;background-color: #14CBB2; 
                            border-top-right-radius: 4px; border-bottom-right-radius: 4px; font-size: 15px; line-height: 20px; letter-spacing: 0;
                             color: #FFFFFF;"><%=eatlist.getDiscount()%>%</div>
                        </div>
                        <div style="width: 81px; height: 47px; margin-bottom: 10px;
                                     position: absolute; right: 15px; bottom: 0; z-index: 2; margin-bottom: 15px; ">
                            <div class="origin_pri" style="margin-left: auto; height: 18px; width: 48px;  ">\<%=eatlist.getPrice()%></div>
                            <div style="height: 27px; width: auto; text-align : right; "><span class="next_pri">\<%=eatlist.getDiscounted()%></span></div>
                        </div>
                    </div>
                </div>
               
                    <div  style="position: static; margin: 0 auto; padding: 15px 15px 33px 15px; height: auto; width: 736px;background-color: white; ">
                        <div class="Eat_name" style="height: 24px; width: 736px;  margin-bottom: 10px;">[<%=eatlist.getArea()%>] <%=eatlist.getName()%> </div>
                        <div class="Eat_menu" style="height: 20px; width: 736px;  "><%=eatlist.getMenu()%> </div>
                        <div class="Eat_ment" style="height: auto; width: 716px; padding: 10px; margin-top: 8px ; display : <%
                            if(eatlist.getInfo()!=null){
                            	out.println("inline-block");
                            }else{
                            	out.println("none");
                            }
                            %> ">
                        	<%=eatlist.getInfo()%>
                        </div>
                </a>
            
                    
        </div>
        <div class="endDiv"></div>
        <%
			}
        %>
        </div>

        
    </main>
    <div id="select_area_box" class="select_area_box" style="position: fixed; left: 567px; display: none;  width: 768px; height: 95%;">
        <div style="height: 100%;">
            <header style="position: relative; height: 60px; top: -14px;">
                <h2 style="font-size: 17px; color: #7f7f7f; text-align: center; padding-top: 24px;">지역 선택</h2>
                <button class="X_button" onclick="box_off()"></button>
            </header>
            <nav style="overflow-x: auto; box-shadow: 0 2px 0 #e9e9e9 inset; white-space: nowrap;">
                <ul style="margin: 0;  padding: 0px; display: flex;">
                    <!--<li class="orange_bar" style="top: 74px; transform: translateX(0px); display: none;"></li>-->
                    <!-- <li style="display: inline-block; padding: 16px 20px 18px; cursor: pointer;"></li> -->
                    <li class="area_filter_on" style="margin: 0;">
                        <button class="area_filter_detail2">서울-강남</button>
                    </li>
                    <li class="area_filter" style="margin: 0;">
                        <button  class="area_filter_detail">서울-강북</button>
                    </li>
                    <li class="area_filter">
                        <button class="area_filter_detail">경기도</button>
                    </li>
                    <li class="area_filter">
                        <button class="area_filter_detail">인천</button>
                    </li>
                    <li class="area_filter">
                        <button class="area_filter_detail">부산</button>
                    </li>
                    <li class="area_filter">
                        <button class="area_filter_detail">제주</button>
                    </li>
                    <li class="area_filter">
                        <button class="area_filter_detail">대전</button>
                    </li>
                    <li class="area_filter">
                        <button class="area_filter_detail">강원도</button>
                    </li>
                    <li class="area_filter">
                        <button class="area_filter_detail">전라남도</button>
                    </li>
                    <li class="area_filter">
                        <button class="area_filter_detail">전라북도</button>
                    </li>
                    <li class="area_filter">
                        <button class="area_filter_detail">울산</button>
                    </li>
                </ul>
            </nav>
            <div style="overflow-y: auto; overflow-x: hidden; height: 75%;">
                <ul class="area_list" style="padding: 20px; display: inline-block; margin: 0; height: 500px;
                 text-align: center;">
                    <li class="area_select_buttons" id="all_button" style="margin-right: 10px;">
                        <button class="area_select_button">전체</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">가로수길</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">강남역</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">관악구</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">금천구</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">논현동</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">대치동</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">동작/사당</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">등촌/강서</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">방배/반포/잠원</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">방이동</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">송파/가락</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">신사/압구정</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">신천/잠실</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">역삼/선릉</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">영등포구</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">청담동</button>
                    </li>
                    <div style="clear: both;"></div>
                </ul>


                <ul class="area_list" style="padding: 20px; display: none; margin: 0; height: 500px;
                 text-align: center;">
                    <li class="area_select_buttons" id="all_button" style="margin-right: 10px;">
                        <button class="area_select_button">전체</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">건대/군자/광진</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">광화문</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">대학로/혜화</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">동대문구</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">마포/공덕</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">상암/성산</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">서대문구</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">수유/도봉/강북</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">신촌/이대</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">연남동</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">왕십리/성동</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">용산/숙대</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">이태원/한남동</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">종로</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">중구</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">합정/망원</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">홍대</button>
                    </li>
                    <div style="clear: both;"></div>
                   
                </ul>

                <ul class="area_list" style="padding: 20px; display: none; margin: 0; height: 500px;
                 text-align: center;">
                    <li class="area_select_buttons" id="all_button" style="margin-right: 10px;">
                        <button class="area_select_button">전체</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">고양시</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">부천시</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">성남시</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">수원시</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">이천시</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">파주시</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">화성시</button>
                    </li>
                   
                    <div style="clear: both;"></div>
                   
                </ul>

                <ul class="area_list" style="padding: 20px; display: none; margin: 0; height: 500px;
                 text-align: center;">
                    <li class="area_select_buttons" id="all_button" style="margin-right: 10px;">
                        <button class="area_select_button">전체</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">인천 남동구</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">인천 연수구</button>
                    </li>
                    
                    <div style="clear: both;"></div>
                   
                </ul>

                <ul class="area_list" style="padding: 20px; display: none; margin: 0; height: 500px;
                 text-align: center;">
                    <li class="area_select_buttons" id="all_button" style="margin-right: 10px;">
                        <button class="area_select_button">전체</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">부산 금정구</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">부산 수영구</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">부산 해운대구</button>
                    </li>
                    
                    <div style="clear: both;"></div>
                   
                </ul>

                <ul class="area_list" style="padding: 20px; display: none; margin: 0; height: 500px;
                 text-align: center;">
                    <li class="area_select_buttons" id="all_button" style="margin-right: 10px;">
                        <button class="area_select_button">전체</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">제주 모슬포/화순</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">제주 서귀포시내</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">제주 제주시내</button>
                    </li>
                    
                    <div style="clear: both;"></div>
                   
                </ul>

                <ul class="area_list" style="padding: 20px; display: none; margin: 0; height: 500px;
                 text-align: center;">
                    <li class="area_select_buttons" id="all_button" style="margin-right: 10px;">
                        <button class="area_select_button">전체</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">대전 유성구</button>
                    </li>
                    
                    <div style="clear: both;"></div>
                   
                </ul>

                <ul class="area_list" style="padding: 20px; display: none; margin: 0; height: 500px;
                 text-align: center;">
                    <li class="area_select_buttons" id="all_button" style="margin-right: 10px;">
                        <button class="area_select_button">전체</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">강원 강릉시</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">강원 삼척시</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">강원 속초시</button>
                    </li>
                    
                    <div style="clear: both;"></div>
                   
                </ul>

                <ul class="area_list" style="padding: 20px; display: none; margin: 0; height: 500px;
                 text-align: center;">
                    <li class="area_select_buttons" id="all_button" style="margin-right: 10px;">
                        <button class="area_select_button">전체</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">전남 여수시</button>
                    </li>
                    
                    <div style="clear: both;"></div>
                   
                </ul>

                <ul class="area_list" style="padding: 20px; display: none; margin: 0; height: 500px;
                 text-align: center;">
                    <li class="area_select_buttons" id="all_button" style="margin-right: 10px;">
                        <button class="area_select_button">전체</button>
                    </li>
                    <li class="area_select_buttons" style=0"margin-right: 10px;">
                        <button class="area_select_button">전북 전주시</button>
                    </li>
                    
                    <div style="clear: both;"></div>
                   
                </ul>

                <ul class="area_list" style="padding: 20px; display: none; margin: 0; height: 500px;
                 text-align: center;">
                    <li class="area_select_buttons" id="all_button" style="margin-right: 10px;">
                        <button class="area_select_button">전체</button>
                    </li>
                    <li class="area_select_buttons" style="margin-right: 10px;">
                        <button class="area_select_button">울산 울주군</button>
                    </li>
                    
                    <div style="clear: both;"></div>
                   
                </ul>
            </div>
            <footer style="position: relative; height: 40px; padding: 10px 0;">
                <button style="left: 350px; position: absolute; height: 40px; min-width: 80px; padding: 0 20px; border-radius: 50px; font-size: 14px; color: #FFFFFF; background-color: #ff792a;">적용</button>
                <button style=" color: #CBCBCB; position: absolute;top: 0; right: 0; height: 100%; padding-right: 20px; font-size: 12px;">지우기</button>
            </footer>
        </div>
    </div>
    <script>
        function box_off(){
            $('#select_area_box').css('display', 'none');
        };
        function box_on(){
            $('#select_area_box').css('display', 'inline-block');
        };
        
        

    </script>



</body>
</html>