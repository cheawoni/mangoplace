<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.1.js"
            integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
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
	            			alert("서비스 페이지는 로그인 후 사용하실 수 있습니다.");
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
             height: 25px;
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

</style>
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
        <div>
            <!-- 암전 -->
            <div class="Black-out" onclick="light_off()"></div>

            <!-- 비 로그인 시 -->
            <div class="bener_box" style="display: none;">
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
                    <button class="Login_Button">로그인</button>
                    <button class="My_Info">내정보</button>
                </footer>
            </div>

            <!-- 로그인 시 -->

            <div class="bener_box" style="height: 507px; width: 320px; display: inline;">
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
                                    <div
                                        style="position: absolute; height: 86px; width: 121.625px; margin-right: 41.5px; display: inline-block;">
                                        <div style="height: 22px; width: 121px;  ">
                                            <h3 class="Res_Name">농민백암왕순대</h3>
                                            <span class="Score">4.6</span>
                                            <span style="font-size: 12px; color: #6a6a6a;">강남역-한식</span>
                                        </div>
                                    </div>
                                    <div
                                        style="background-image: url(Images/star.png); height: 28px; width: 28px; display: inline-block; left: 155px; top: -45px; position: relative;">
                                    </div>
                                </div>
                            </li>

                            <li style="height: 86px; width: 277px; margin-bottom: 16px;">
                                <div style="height: 86px; margin-bottom: 16px;  position: relative;">
                                    <div class="Res_Pic"
                                        style="background-image: url(Images/nongmin.jpg); background-position: 50%; height: 70px; width: 70px; display: inline-block; margin-right: 16px; border: 1px solid black;">
                                    </div>
                                    <div
                                        style="position: absolute; height: 86px; width: 121.625px; margin-right: 41.5px; display: inline-block;">
                                        <div style="height: 22px; width: 121px;  ">
                                            <h3 class="Res_Name">농민백암왕순대</h3>
                                            <span class="Score">4.6</span>
                                            <span style="font-size: 12px; color: #6a6a6a;">강남역 - 한식</span>
                                        </div>
                                    </div>
                                    <div
                                        style="background-image: url(Images/star.png); height: 28px; width: 28px; display: inline-block; left: 155px; top: -45px; position: relative;">
                                    </div>
                                </div>
                            </li>

                            <li style="height: 86px; width: 277px; margin-bottom: 16px;">
                                <div style="height: 86px; margin-bottom: 16px;  position: relative;">
                                    <div class="Res_Pic"
                                        style="background-image: url(Images/nongmin.jpg); background-position: 50%; height: 70px; width: 70px; display: inline-block; margin-right: 16px; border: 1px solid black;">
                                    </div>
                                    <div
                                        style="position: absolute; height: 86px; width: 121.625px; margin-right: 41.5px; display: inline-block;">
                                        <div style="height: 22px; width: 121px;  ">
                                            <h3 class="Res_Name">농민백암왕순대</h3>
                                            <span class="Score">4.6</span>
                                            <span style="font-size: 12px; color: #6a6a6a;">강남역 - 한식</span>
                                        </div>
                                    </div>
                                    <div
                                        style="background-image: url(Images/star.png); height: 28px; width: 28px; display: inline-block; left: 155px; top: -45px; position: relative;">
                                    </div>
                                </div>
                            </li>

                            <li style="height: 86px; width: 277px; margin-bottom: 16px;">
                                <div style="height: 86px; margin-bottom: 16px;  position: relative;">
                                    <div class="Res_Pic"
                                        style="background-image: url(Images/nongmin.jpg); background-position: 50%; height: 70px; width: 70px; display: inline-block; margin-right: 16px; border: 1px solid black;">
                                    </div>
                                    <div
                                        style="position: absolute; height: 86px; width: 121.625px; margin-right: 41.5px; display: inline-block;">
                                        <div style="height: 22px; width: 121px;  ">
                                            <h3 class="Res_Name">농민백암왕순대</h3>
                                            <span class="Score">4.6</span>
                                            <span style="font-size: 12px; color: #6a6a6a;">강남역 - 한식</span>
                                        </div>
                                    </div>
                                    <div
                                        style="background-image: url(Images/star.png); height: 28px; width: 28px; display: inline-block; left: 155px; top: -45px; position: relative;">
                                    </div>
                                </div>
                            </li>

                            <li style="height: 86px; width: 277px; margin-bottom: 16px;">
                                <div style="height: 86px; margin-bottom: 16px;  position: relative;">
                                    <div class="Res_Pic"
                                        style="background-image: url(Images/nongmin.jpg); background-position: 50%; height: 70px; width: 70px; display: inline-block; margin-right: 16px; border: 1px solid black;">
                                    </div>
                                    <div
                                        style="position: absolute; height: 86px; width: 121.625px; margin-right: 41.5px; display: inline-block;">
                                        <div style="height: 22px; width: 121px;  ">
                                            <h3 class="Res_Name">농민백암왕순대</h3>
                                            <span class="Score">4.6</span>
                                            <span style="font-size: 12px; color: #6a6a6a;">강남역 - 한식</span>
                                        </div>
                                    </div>
                                    <div
                                        style="background-image: url(Images/star.png); height: 28px; width: 28px; display: inline-block; left: 155px; top: -45px; position: relative;">
                                    </div>
                                </div>
                            </li>

                            <li style="height: 86px; width: 277px; margin-bottom: 16px;">
                                <div style="height: 86px; margin-bottom: 16px;  position: relative;">
                                    <div class="Res_Pic"
                                        style="background-image: url(Images/nongmin.jpg); background-position: 50%; height: 70px; width: 70px; display: inline-block; margin-right: 16px; border: 1px solid black;">
                                    </div>
                                    <div
                                        style="position: absolute; height: 86px; width: 121.625px; margin-right: 41.5px; display: inline-block;">
                                        <div style="height: 22px; width: 121px;  ">
                                            <h3 class="Res_Name">농민백암왕순대</h3>
                                            <span class="Score">4.6</span>
                                            <span style="font-size: 12px; color: #6a6a6a;">강남역 - 한식</span>
                                        </div>
                                    </div>
                                    <div
                                        style="background-image: url(Images/star.png); height: 28px; width: 28px; display: inline-block; left: 155px; top: -45px; position: relative;">
                                    </div>
                                </div>
                            </li>

                            <li style="height: 86px; width: 277px; margin-bottom: 16px;">
                                <div style="height: 86px; margin-bottom: 16px;  position: relative;">
                                    <div class="Res_Pic"
                                        style="background-image: url(Images/nongmin.jpg); background-position: 50%; height: 70px; width: 70px; display: inline-block; margin-right: 16px; border: 1px solid black;">
                                    </div>
                                    <div
                                        style="position: absolute; height: 86px; width: 121.625px; margin-right: 41.5px; display: inline-block;">
                                        <div style="height: 22px; width: 121px;  ">
                                            <h3 class="Res_Name">농민백암왕순대</h3>
                                            <span class="Score">4.6</span>
                                            <span style="font-size: 12px; color: #6a6a6a;">강남역 - 한식</span>
                                        </div>
                                    </div>
                                    <div
                                        style="background-image: url(Images/star.png); height: 28px; width: 28px; display: inline-block; left: 155px; top: -45px; position: relative;">
                                    </div>
                                </div>
                            </li>

                            <li style="height: 86px; width: 277px; margin-bottom: 16px;">
                                <div style="height: 86px; margin-bottom: 16px;  position: relative;">
                                    <div class="Res_Pic"
                                        style="background-image: url(Images/nongmin.jpg); background-position: 50%; height: 70px; width: 70px; display: inline-block; margin-right: 16px; border: 1px solid black;">
                                    </div>
                                    <div
                                        style="position: absolute; height: 86px; width: 121.625px; margin-right: 41.5px; display: inline-block;">
                                        <div style="height: 22px; width: 121px;  ">
                                            <h3 class="Res_Name">농민백암왕순대</h3>
                                            <span class="Score">4.6</span>
                                            <span style="font-size: 12px; color: #6a6a6a;">강남역 - 한식</span>
                                        </div>
                                    </div>
                                    <div
                                        style="background-image: url(Images/star.png); height: 28px; width: 28px; display: inline-block; left: 155px; top: -45px; position: relative;">
                                    </div>
                                </div>
                            </li>

                            <li style="height: 86px; width: 277px; margin-bottom: 16px;">
                                <div style="height: 86px; margin-bottom: 16px;  position: relative;">
                                    <div class="Res_Pic"
                                        style="background-image: url(Images/nongmin.jpg); background-position: 50%; height: 70px; width: 70px; display: inline-block; margin-right: 16px; border: 1px solid black;">
                                    </div>
                                    <div
                                        style="position: absolute; height: 86px; width: 121.625px; margin-right: 41.5px; display: inline-block;">
                                        <div style="height: 22px; width: 121px;  ">
                                            <h3 class="Res_Name">농민백암왕순대</h3>
                                            <span class="Score">4.6</span>
                                            <span style="font-size: 12px; color: #6a6a6a;">강남역 - 한식</span>
                                        </div>
                                    </div>
                                    <div
                                        style="background-image: url(Images/star.png); height: 28px; width: 28px; display: inline-block; left: 155px; top: -45px; position: relative;">
                                    </div>
                                </div>
                            </li>

                            <li style="height: 86px; width: 277px; margin-bottom: 16px;">
                                <div style="height: 86px; margin-bottom: 16px;  position: relative;">
                                    <div class="Res_Pic"
                                        style="background-image: url(Images/nongmin.jpg); background-position: 50%; height: 70px; width: 70px; display: inline-block; margin-right: 16px; border: 1px solid black;">
                                    </div>
                                    <div
                                        style="position: absolute; height: 86px; width: 121.625px; margin-right: 41.5px; display: inline-block;">
                                        <div style="height: 22px; width: 121px;  ">
                                            <h3 class="Res_Name">농민백암왕순대</h3>
                                            <span class="Score">4.6</span>
                                            <span style="font-size: 12px; color: #6a6a6a;">강남역 - 한식</span>
                                        </div>
                                    </div>
                                    <div
                                        style="background-image: url(Images/star.png); height: 28px; width: 28px; display: inline-block; left: 155px; top: -45px; position: relative;">
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
                                        <div style="height: 22px; width: 121px;">
                                            <h3 class="Res_Name">농민백암왕순대</h3>
                                            <span class="Score">4.6</span>
                                            <span style="font-size: 12px; color: #6a6a6a;">강남역 - 한식</span>
                                        </div>
                                    </div>
                                    <div
                                        style="background-image: url(Images/Star_On.png); height: 28px; width: 28px; display: inline-block; left: 155px; top: -45px; position: relative;">
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>

                <footer style="height: 22.4px; width: 288px; padding: 10px 16px; border-top: 1px solid #dbdbdb; text-align: right;">
                    <button class="Login_Button">
                        	로그인
                    </button>
                    <a href="mypage.jsp">
                        <button class="My_Info">
                           	 내정보
                        </button>
                    </a>
                </footer>
            </div>
        </div>

        <!-- 가고싶다 -->
        <div id="wish" style="height: 413px; overflow-y: auto; display: none;">
            <!-- <div style="height: 413px; overflow-y: auto; display: inline;"> -->

            <ul style="height: 1004px; width: 277.2px; margin: 16px 10px 0px 16px; padding: 0;">
                <li style="height: 86px; width: 277px; margin-bottom: 16px;">
                    <div style="height: 86px; margin-bottom: 16px;  position: relative;">
                        <div class="Res_Pic" style="background-image: url(Images/nongmin.jpg);">
                        </div>
                        <div
                            style="position: absolute; height: 86px; width: 121.625px; margin-right: 41.5px; display: inline-block;">
                            <div style="height: 22px; width: 121px;  ">
                                <h3 class="Res_Name">농민백암왕순대</h3>
                                <span class="Score">4.6</span>
                                <span style="font-size: 12px; color: #6a6a6a;">강남역 - 한식</span>
                            </div>
                        </div>
                        <div
                            style="background-image: url(Images/Star_On.png); height: 28px; width: 28px; display: inline-block; left: 155px; top: -45px; position: relative;">
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <footer style="height: 22.4px; width: 288px; padding: 10px 16px; border-top: 1px solid #dbdbdb; text-align: right;">
            <button class="Login_Button">
                	로그인
            </button>
            <a href="mypage.jsp">
                <button class="My_Info">
                    	내정보
                </button>
            </a>
        </footer>
    </div>
</body>
</html>