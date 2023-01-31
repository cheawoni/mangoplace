<%@page import="java.text.SimpleDateFormat"%>
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
		<%
		String detailIdx = request.getParameter("detailIdx");
		DetailDAO dDAO = new DetailDAO();
		ArrayList<DetailDTO> listD = dDAO.getDetail(detailIdx);
		%>
<head>
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
	function getParameterByName(name) {
		  name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
		  var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
		  results = regex.exec(location.search);
		  return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
		}
	let menu = getParameterByName('menu');
	</script>
    <link rel="stylesheet" href="mango_bener.css">
    <link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-kr.css' rel='stylesheet' type='text/css'>
    <script src="https://code.jquery.com/jquery-3.6.1.js"
    
        integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
    <!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eat_detail</title>
    <link rel="icon" href="img/mango_favicon.png">
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
        
        *{
            font-family: 'Spoqa Han Sans', 'Spoqa Han Sans JP', 'Sans-serif';
        }

        .In_Main_Pic {
            /* position: absolute; */
            bottom: 14px;
            left: 15px;
            right: 15px;
            height: 23px;
            width: 738px;
            margin-top: 540px;
            margin-left: 0px;
        }

        .In_Main_Pic_Ment {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            word-wrap: normal;
            height: 23px;
            margin-right: 15px;
            padding: 0 8px;
            border-radius: 2px;
            font-size: 12px;
            letter-spacing: -0.3px;
            line-height: 23px;
            word-break: break-all;
            color: #fff;
            background-color: rgba(0, 0, 0, 0.2);
        }


        .EatDeal_Info {
            font-size: 18px;
            line-height: 26px;
            letter-spacing: 0;
            color: #4F4F4F;
        }

        .EatDeal_ReInfo {
            margin-bottom: 8px;
            font-size: 15px;
            line-height: 22px;
            letter-spacing: 0;
            font-weight: bold;
            color: #4F4F4F;
        }

        .EatDeal_ReInfo2 {
            font-size: 15px;
            line-height: 22px;
            letter-spacing: 0;
            word-break: break-all;
            color: #7F7F7F;
        }

        li,
        ol,
        ol li {
            list-style: none;
        }

        .EatDealAdditionalInfo__Item:before {
            content: '';
            display: inline-block;
            width: 11px;
            height: 6px;
            background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/web/resources/ic-list-dot.svg);
        }

        .EatDealInfo__Name {
            font-size: 20px;
            letter-spacing: 0;
            line-height: 1.45;
            font-weight: bold;
            color: #4f4f4f;
            margin: 0px;
        }

        .EatDealDetailPage__InfoIcon {
            width: 12px;
            height: 12px;
            margin-right: 4px;
            background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/web/resources/eat_deal_restaurant-info-v2.svg);
            background-size: cover;
        }

        .EatDealDetailPage__GoDetail {
            margin-top: 8px;
            line-height: 2px;
            padding: 3px 9px 3px 5px;
            border-radius: 50px;
            font-size: 12px;
            letter-spacing: 0;
            color: #7F7F7F;
            background-color: #F3F3F3;
        }

        .EatDealDetailPage__Arrow {
            width: 6px;
            height: 10px;
            margin-top: 2px;
            margin-left: 4px;
            background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/web/resources/eat_deal_review_button_arrow.svg);
            background-size: cover;
            background-repeat: no-repeat;
        }

        .EatDealInfo__Title {
            margin-top: 24px;
            margin-bottom: 6px;
            font-size: 18px;
            line-height: 24px;
            letter-spacing: 0;
            color: #7F7F7F;
        }

        .EatDealInfo__Date {
            display: block;
            font-size: 14px;
            letter-spacing: 0;
            font-weight: bold;
            color: #4F4F4F;
        }

        .EatDealInfo__OriPrice {
            font-size: 12px;
            text-align: right;
            letter-spacing: 0;
            text-decoration: line-through;
            color: #CBCBCB;
        }

        .EatDealInfo__Dis {
            font-size: 24px;
            line-height: 1;
            font-weight: bold;
            letter-spacing: -0.6px;
            color: #1fceb6;
        }

        .EatDealInfo__Sale {
            font-size: 24px;
            line-height: 1;
            font-weight: bold;
            letter-spacing: 0;
            color: #4f4f4f;
        }

        .Main_Pic {
            display: inline-block;
            width: 100%;
            height: 100%;
            max-height: 576px;
            background-size: cover;
            background-position: 50% 50%;
        }

        .buy_button {
            position: fixed;
            bottom: 0;
            left: 30%;
            z-index: 1;
            width: 100%;
            max-width: 768px;
            height: 60px;
        }

        .button_last {
            display: block;
            max-width: 768px;
            height: 100%;
            text-align: center;
            background-color: #ff7100;
        }

        .button_font2 {
            font-size: 16px;
            letter-spacing: 0;
            line-height: 21px;
            color: #fff;
        }
    </style>
</head>

<body style="margin: 0 auto;">
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


		<%
			for(DetailDTO detaill : listD) { 
				String menu = detaill.getMenu(); 
				String info = detaill.getInfo(); 
				
				if(detaill.getMenu()==null){
					menu="";
				}
				if(detaill.getInfo()==null){
					info="";
				}
				
		%>


    <main style="position: relative; margin-top: 61px; height: 1900px; background-color: #fff;">
        <div style="margin: 0 auto; height: 1768px; width: 768px;">
            <div class="Main_Pic"
                style="display: inline-block; width: 768px; height: 576px; margin-bottom: 30px; background-image: url(Images/EAT딜메인/<%=detaill.getMenuImg()%>);">
                <div class="In_Main_Pic">
                    <span class="In_Main_Pic_Ment"><%=menu%> <%=detaill.getDiscount()%>% 할인</span>
                </div>
            </div>
            <div style="height: 198px; width: 738; padding: 0px 15px 0px 15px ; margin-bottom: 16px; display: inline-block;
    ">
                <h1 class="EatDealInfo__Name">[<%=detaill.getArea()%>] <%=detaill.getName()%></h1>
                <div class="EatDealDetailPage__GoDetail"
                    style="height: 16px; width: 110px; padding: 3px 5px 3px 5px; margin-top: 8px;">
                    <img class="EatDealDetailPage__InfoIcon" style="margin: 0px 0px 0px 0px;" src="" alt="">
                    식당 정보 보기
                    <img class="EatDealDetailPage__Arrow" style="margin-left: 0px;" src="" alt="">
                </div>
                <div style="height: 24px; width: 738px; margin: 24px 0 6px 0;">
                    <p class="EatDealInfo__Title"><%=menu%></p>
                </div>
                <span class="EatDealInfo__Date">
                    <span>사용 기간 : </span>
                    93일
                    <%
                    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
            		Calendar cal = Calendar.getInstance();
            		String sysdate1 = fmt.format(cal.getTime());
            		int mm = cal.get(Calendar.DATE);
            		cal.set(Calendar.DATE, + 93);
            		String sysdate = fmt.format(cal.getTime());
 					%>
                    <span style="font-weight: normal;">(<%=sysdate1 %> ~ <%=sysdate %>)</span>
                </span>
                <div style="height: 45px; width: 738px; margin-top: 24px; text-align: right;">
                    <span class="EatDealInfo__OriPrice">₩<%=detaill.getPrice()%></span>
                    <div style="height: 29px; width: 738px;  text-align: right;">
                        <span class="EatDealInfo__Dis"><%=detaill.getDiscount()%>%</span>
                        <span class="EatDealInfo__Sale">₩<%=detaill.getDiscounted()%></span>
                    </div>
                </div>


            </div>
            <div style="height: 1px; width: 738px; margin: 32px 15px; background-color: #e9e9e9;">
            </div>
            <div style="height: 43px; width: 738px; margin: 0px 15px 32px 15px;">
                <div
                    style="height: 13px; width: 20px; background-image: url(https://mp-seoul-image-production-s3.mangoplate.com/web/resources/eat_deal_comment_dot.svg);">
                </div>
                <div class="EatDeal_Info" style="height: 26px; width: 738px; ">
                    <%=info%>
                </div>
            </div>
            <div style="margin: 0 auto; height: 840px; width: 738px; padding: 0 15 0 15;">
                <div style="height: 52px; width: 738px; margin-bottom: 20px; display: inline-block;">
                    <div style="height: 22px; width: 738px; margin-bottom: 8px; margin-top: 0;">
                        <h3 class="EatDeal_ReInfo" style="margin:  0;">식당소개</h3>
                    </div>
                    <div style="height: 22px; width: 738px; margin-bottom: 4px;">
                        <ul style="margin:  0; padding-left: 0px;">
                            <li class="EatDeal_ReInfo2">
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    <%=detaill.getRsInfo()%>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div style="height: 78px; width: 738px; margin-bottom: 20px;">
                    <div style="height: 22px; width: 738px; margin-bottom: 8px; margin-top: 0;">
                        <h3 class="EatDeal_ReInfo" style="margin:  0;">메뉴소개</h3>
                    </div>
                    <div style="height: 22px; width: 738px; margin-bottom: 4px;">
                        <ul style="margin:  0; padding-left: 0px;">
                            <li class="EatDeal_ReInfo2" style="line-height: 22px;">
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    <%=detaill.getMenu()%>
                                </div>
                                <!-- <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    시오라멘 / 쇼유라멘 / 블랙쇼유라멘 中 택1
                                </div> -->
                            </li>
                        </ul>
                    </div>
                </div>
                 <%
					}
        		%>
                <div style="height: 234px; width: 738px; margin-bottom: 20px;">
                    <div style="height: 22px; width: 738px; margin-bottom: 8px; margin-top: 0;">
                        <h3 class="EatDeal_ReInfo" style="margin:  0;">※ 유의사항 (꼭! 확인해주세요)</h3>
                    </div>
                    <div style="height: 22px; width: 738px; margin-bottom: 4px;">
                        <ul style="margin:  0; padding-left: 0px;">
                            <li class="EatDeal_ReInfo2" style="line-height: 22px;">
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    사용 기간: 구매 시점으로부터 93일
                                </div>
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    본 EAT딜 상품은 방문 포장이 불가합니다.
                                </div>
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    구매 전 전용 지점을 꼭 확인해주세요.
                                </div>
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    양도 및 재판매 불가합니다.
                                </div>
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    방문 전 영업시간 및 휴무일 확인을 부탁드립니다.
                                </div>
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    옵션 당 1인 1매만 구매 가능합니다.
                                </div>
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    테이블 당 1매만 사용 가능합니다.
                                </div>
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    EAT딜 외에 다른 쿠폰 및 딜과 중복 사용 불가합니다.
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div style="height: 130px; width: 738px; margin-bottom: 20px;">
                    <div style="height: 22px; width: 738px; margin-bottom: 8px; margin-top: 0;">
                        <h3 class="EatDeal_ReInfo" style="margin:  0;">※ 사용 방법</h3>
                    </div>
                    <div style="height: 22px; width: 738px; margin-bottom: 4px;">
                        <ul style="margin:  0; padding-left: 0px;">
                            <li class="EatDeal_ReInfo2" style="line-height: 22px;">
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    구매하신 EAT딜은 최신 버전 앱에서만 사용 가능합니다.
                                </div>
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    결제 시 망고플레이트 앱 > 내정보 > 구매한 EAT딜을 선택하여 매장에 비치된 QR코드를 스캔합니다.
                                </div>
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    QR코드 스캔이 불가능할 시 매장 직원에게 화면 하단 12자리 숫자 코드를 보여주세요.
                                </div>
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    사용 처리가 완료된 EAT딜은 재사용 및 환불 불가합니다.
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div style="height: 178px; width: 738px; margin-bottom: 20px;">
                    <div style="height: 22px; width: 738px; margin-bottom: 8px; margin-top: 0;">
                        <h3 class="EatDeal_ReInfo" style="margin:  0;">※ 환불 규정</h3>
                    </div>
                    <div style="height: 22px; width: 738px; margin-bottom: 4px;">
                        <ul style="margin:  0; padding-left: 0px;">
                            <li class="EatDeal_ReInfo2" style="line-height: 22px;">
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    상품 사용 기간 내 환불 요청에 한해 구매 금액 전액 환불, 상품 사용 기간 이후 환불 요청 건은 수수료 10%를 제외한 금액환불을 원칙으로
                                    합니다.
                                </div>
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    환불 기간 연장은 불가합니다.
                                </div>
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    구매 후 93일 이내 환불 요청: 100% 환불
                                </div>
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    구매 후 93일 이후 환불 요청: 90% 환불
                                </div>
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    환불은 구매 시 사용하였던 결제수단으로 환불됩니다.
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div style="height: 52px; width: 738px; margin-bottom: 20px;">
                    <div style="height: 22px; width: 738px; margin-bottom: 8px; margin-top: 0;">
                        <h3 class="EatDeal_ReInfo" style="margin:  0;">문의</h3>
                    </div>
                    <div style="height: 22px; width: 738px; margin-bottom: 4px;">
                        <ul style="margin:  0; padding-left: 0px;">
                            <li class="EatDeal_ReInfo2" style="line-height: 22px;">
                                <div>
                                    <img class="EatDealAdditionalInfo__Item" style="margin-top: 0px;" src="" alt="">
                                    망고플레이트 앱 > 내정보 > 설정 > 고객센터 로 문의주세요.
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="buy_button">
            <button class="button_last" style="height: 60px; width: 768px; border: 0px;">
                <span class="button_font2">구매하기</span>
            </button>
        </div>





    </main>








</body>

</html>