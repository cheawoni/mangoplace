<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<%@ page import="java.util.*" %>    
<%@ page import="com.mango.details.dto.*" %>    
<%@ page import="com.mango.details.dao.*" %>    

<%
	int detailPk = Integer.parseInt(request.getParameter("detailPk"));
	String email = (String)session.getAttribute("loginEmail");
	mangoDetailsDAO mangoDAO = new mangoDetailsDAO();
	mangoDetailsDTO DetailList = mangoDAO.getBoardDetailByBno(detailPk);
%>    
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>망고 상세 리뷰 페이지</title>
	<link rel="stylesheet" href="CSS/mango_review.css">
	<link rel="icon" href="Images/profile/mango_favicon.png">
	<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
	<script>
		$(function(){
			$(".tastylike").click( function(){
				idx = $(".tastylike").index($(this));
				if(idx==0) $("#input_tastylike").val("5");
				else if(idx==1) $("#input_tastylike").val("3");
				else if(idx==2) $("#input_tastylike").val("1");
				
				$(".tastylike").each(function(tasty_like_idx,obj) {
					if(idx==tasty_like_idx) {
						$(this).addClass('active');
					} else {
						$(this).removeClass('active');
					}
				});
			});
			// 나중에 이어쓰기 변수
			var later_Btn = false;
			//텍스트 입력시 나중에 이어쓰기 active
			$(".review_content").on("keyup", function() { 
				//console.log($(this).val().length);
				// textarea 입력된 텍스트의 길이 : $(this).val().length
				var write_content = $(this).val().length;
				
	
				if( write_content >= 1 ){
					$(this).parents("#review_writingpage").find(".review_later_button_Deactive").addClass('review_later_button');
					$(this).parents("#review_writingpage").find(".review_later_button").removeClass('review_later_button_Deactive');
					$(this).parents("#review_writingpage").find(".review_submit_button").removeClass('review_submit_button_Deactive');
					later_Btn = true;
				} else if (write_content == 0){
					$(this).parents("#review_writingpage").find(".review_later_button").addClass('review_later_button_Deactive');
					$(this).parents("#review_writingpage").find(".review_later_button_Deactive").removeClass('review_later_button');
					$(this).parents("#review_writingpage").find(".review_submit_button").addClass('review_submit_button_Deactive');
				}
				//텍스트 길이count
				$("#review_text_length_count").text(write_content);
				//alert( $(".review_img > div").length-1 );
				// 등록한 이미지 개수 : $(".review_img > div").length-1
			});
			
			//텍스트 입력시 나중에 이어쓰기 active
			$(".review_content").on("keypress", function() { 
				var write_content = $(this).val().length;
			
			
				if( write_content >= 1 ){
					$(this).parents("#review_writingpage").find(".review_later_button_Deactive").addClass('review_later_button');
					$(this).parents("#review_writingpage").find(".reivew_later_button").removeClass('review_later_button_Deative');
					$(this).parents("#review_writingpage").find(".review_submit_button").removeClass('review_submit_button_Deactive');
					later_Btn = true;
				} else if (write_content == 0){
					$(this).parents("#review_writingpage").find(".review_later_button").addClass('review_later_button_Deactive');
					$(this).parents("#review_writingpage").find(".review_later_button_Deactive").removeClass('review_later_button');
					$(this).parents("#review_writingpage").find(".review_submit_button").addClass('review_submit_button_Deactive');
				}
				//텍스트 길이count
				$("#review_text_length_count").text(write_content);
					
			});
			
			$(".review_content").on("keydown", function() { 
				var write_content = $(this).val().length;
				$("#review_text_length_count").text(write_content);
				if( write_content == 0 ){
					later_Btn = false;
				}
			});
			
			// 리뷰 작성시 alert 창 띄우기, 미작성시 띄우지 않음
	/* 		window.onbeforeunload = function(e) {
				if (later_Btn == true){
				    var dialogText = 'Dialog text here';
				    e.returnValue = dialogText;
				    return "dialogText";
				}
			}; */
			//이미지 갯수 count			
			$("#review_img_count").text( $(".review_img > div").length-1 );
			//$(".review_content").val().length
			
			// 취소 버튼 클릭시 이벤트	
			$(".review_cancel_button").click( function(){
				$(".review_cancel_background_dark").css({ display:"block" });
			});
			$(".review_cancel_btn").click( function(){
				$(".review_cancel_background_dark").css({ display:"none" });
			});
			$(".review_cancel_btn").eq(1).click( function(){
				location.href= "mango_review_detail.jsp?detailPk=<%=DetailList.getId()%>";
			});
			
			//나중에 이어쓰기 클릭시 이벤트
			$(".review_later_button_Deactive").click( function(){
		 		if(later_Btn == true){
					$(".review_LaterWrite_background_dark").css({ display:"block" });
				} else {
					$(".review_LaterWrite_background_dark").css({ display:"none" });
				}
			});
			$(".review_LaterWrite_cancel_btn").click( function(){
				$(".review_LaterWrite_background_dark").css({ display:"none" });
			});
			$(".review_LaterWrite_cancel_btn").eq(1).click( function(){
				location.href= "mango_review_detail.jsp?detailPk=<%=DetailList.getId()%>";
			});
			
			//추가 사진 위에 밝기 조정
/* 			$(".review_img").mouseenter(function(){
				idx = $(".review_img").index($(this));
				$(".review_img").each(function(r_idx,obj) {
					if(idx==r_idx) {
						$(this).find(".dark").css({display:"block"});
					} else {
						$(this).find(".dark").css({display:"none"});
					}
				});
			}); */
			//$(".preview > img").mouseenter(function(){
			$(document).on("mouseenter", ".review_img_plus", function() {
				idx = $(".review_img_plus").index($(this));
				
				$(".review_img_plus").each(function(r_idx,obj) {
					if(idx==r_idx) {
						$(this).find(".dark").css({display:"block"});
					} else {
						$(this).find(".dark").css({display:"none"});
					}
				});
			});
			$(document).on("mouseleave", ".review_img_plus", function() {
			//$(".review_img_plus").mouseleave(function(){
				$(".dark").css({display:"none"});
			});
			//추가 사진 업데이트 시 확대버튼
			//$(".widely_icon").click(function(){
			$(document).on("click", ".widely_icon", function(){
				var url = $(this).parent().parent().css('background-image');
				$(".review_Update_Img").css('background-image', url);				
				$(".new_Review_Update_Img_Wrap").css({display:"block"});
				$(".black_screen").css({display:"block"});
			});
			$(document).on("click", ".close_button", function(){
				$(".new_Review_Update_Img_Wrap").css({display:"none"});
				$(".black_screen").css({display:"none"});
			});
			$(document).on("click", ".black_screen", function(){
				$(".new_Review_Update_Img_Wrap").css({display:"none"});
				$(".black_screen").css({display:"none"});
			});
/* 			if(alert('Alert For your User!')){}
			else    window.location.reload(); */ 
		});
		
		// 새로고침이나 새로운 페이지 이동시 alert창 띄우기 

	</script>
</head>
<body>
	<div id="header">
		<div class="logo_box">
			<a href="MangoMain.jsp"><div id="logo"></div></a>
		</div>
	</div>
	<div id="review_writingpage">
		<form action="ReviewWriteServlet" method="post">
			<input type="hidden" name="detailPk" value="<%=detailPk %>"/>
			<input type="hidden" id="input_tastylike" name="tastylike" value="5"/>
			<div class="review_writingpage_title">
				<strong class="fl review_writingpage_restaurant_name"><%=DetailList.getName() %></strong>
				<div class="fl review_writingpage_restaurant_submessagewrap">
					<span class="review_writingpage_restaurant_submessage">에 대한 솔직한 리뷰를 써주세요.</span>
				</div>
				<div style="clear:both;"></div>
			</div>
			<div class="review_writingpage_itemwrap">
				<div class="review_writingpage_content">
					<div>
						<div class="review_writingpage_contentwrap1">
							<div class="review_writingpage_contentwrap2">
								<div class="review_writingpage_contentwrap3">
									<div class="review_writingpage_tastylike">
										<div>
											<button type="button" class="tastylike active">
												<div class="fl tastylike_good"></div>
												<span class="fl tastylike_content">맛있다</span>
												<div style="clear:both;"></div>
											</button>
											<button type="button" class="tastylike">
												<div class="fl tastylike_notbad"></div>
												<span class="fl tastylike_content">괜찮다</span>
												<div style="clear:both;"></div>
											</button>
											<button type="button" class="tastylike">
												<div class="fl tastylike_bad"></div>
												<span class="fl tastylike_content">별로다</span>
												<div style="clear:both;"></div>
											</button>
										</div>
									</div>
									<textarea class="review_content" maxlength="10000" name="review" placeholder="망고소녀님, 주문하신 메뉴는 어떠셨나요? 식당의 분위기와 서비스도 궁금해요!"></textarea>
								</div>	<!-- review_writingpage_contentwrap3 out -->
								<div class="fr review_text_length">
									<div id="review_text_length_count" class="fl">0</div>
									<div class="fl">&nbsp/&nbsp10,000</div>
									<div style="clear:both;"></div>
								</div>
							    <div style="clear:both;"></div>
							</div>	<!-- review_writingpage_contentwrap2 out -->
		 				</div> <!-- review_writingpage_contentwrap1 out -->
					</div>
				</div>	<!-- review_writingpage_content out -->
				<div class="review_writingpage_imgwrap">
					<div id="review_imgwrap">
						<div class="fl review_img">
							<div class = "preview" style="display:inline-flex;">
								<input type="file" class="real-upload"  style="display:none;" accept="image/*" multiple/>  <!--required --> 
								<button type="button" class="review_img_button upload">
									<div class="review_img_plus_icon button"></div>
								</button>
								<input type='hidden' id='input_img_names' name='img_names'/>
							</div>
							<div class="review_img_countwrap">
								<div id="review_img_count"class="fl">0</div>
								<div class="fl">&nbsp/&nbsp30</div>
								<div style="clear:both;"></div>
							</div>
						</div>
						 <div style="clear:both;"></div>
						 <script>
						    function getImageFiles(e) {
						      const uploadFiles = [];
						      const files = e.currentTarget.files;
						      const imagePreview = document.querySelector('.review_img_plus');
						      const docFrag = new DocumentFragment();
						
						      if ([...files].length >= 7) {
						        alert('이미지는 최대 6개 까지 업로드가 가능합니다.');
						        return;
						      }
						
						      // 파일 타입 검사
						      [...files].forEach(file => {
						        if (!file.type.match("image/.*")) {
						          alert('이미지 파일만 업로드가 가능합니다.');
						          return
						        }
						
						        // 파일 갯수 검사
						        if ([...files].length < 7) {
						          uploadFiles.push(file);
						          const reader = new FileReader();
						          reader.onload = (e) => {
						            const preview = createElement(e, file);
						            imagePreview.appendChild(preview);
						          };
						          reader.readAsDataURL(file);
						        }
						      });
						    }
						
						    function createElement(e, file) {
						      const preview = document.querySelector('.preview');
						      const img = document.createElement('img');
						      
						      const div = document.createElement('div');
	 					      div.innerHTML += '<div class="dark">'
									+ '<div class="close_icon"></div>'
									+ '<div class="widely_icon"></div>'
									+ '</div>';
							  div.setAttribute('class', 'review_img_plus');
							  div.setAttribute('style', 'background-image: url("'+e.target.result+'")');
							  

						      preview.prepend(div);
							  
							  var img_names = $("#input_img_names").val();
							  img_names += "_____" + file.name;
							  if(img_names.startsWith('_____'))
								  img_names = img_names.substring(5);
							  $("#input_img_names").val(img_names);
						      return preview;
						    }
							
						    const realUpload = document.querySelector('.real-upload');
						    const upload = document.querySelector('.upload');
						
						    upload.addEventListener('click', () => realUpload.click());
						
						    realUpload.addEventListener('change', getImageFiles);
						 </script>
					</div>
				</div>	<!-- review_writingpage_imgwrap out -->
			</div>	<!-- review_writingpage_itemwrap out -->
			<div class="review_writingpage_buttons">
				<button type="button" class="review_later_button_Deactive">나중에 이어쓰기</button>
				<div class="review_writing_button_wrap">
					<button type="button" class="review_cancel_button">취소</button>
					<button class="review_submit_button review_submit_button_Deactive">리뷰 올리기</button>
				</div>
			</div>	<!-- review_writingpage_buttons out  -->
		</form>
	</div> <!-- review_writingpage out-->
<!-- 	<div class="background_darkwrap">	</div> -->
	<div class="img_background_dark">
		<div class="widely_imgwrap">
			<div class="widely_img_content">
				<div class="widely_img"></div>
				<button class="widely_img_arrow_button widely_img_arrow_next"></button>
				<!-- <button class="widely_img_arrow_button widely_img_arrow_prev"></button> -->
			</div>
			<div class="widely_small_contentwrap">
				<div class="widely_small_content">
					<div class="widely_small_imgwrap1">
						<div class="widely_small_imgwrap2">
							<div class="widely_small_img on" style="background-image: url(https://s3-ap-northeast-2.amazonaws.com/mp-seoul-image-production/sources/web/restaurants/87430/2386738_1670548731303);"></div>
							<div class="widely_small_img" style="background-image: url(https://s3-ap-northeast-2.amazonaws.com/mp-seoul-image-production/sources/web/restaurants/87430/2386738_1670548732616);"></div>
							<div class="widely_small_img" style="background-image: url(https://s3-ap-northeast-2.amazonaws.com/mp-seoul-image-production/sources/web/restaurants/87430/2386738_1670548733180);"></div>
						</div>
					</div>
				</div>
			</div>
			<button class="widely_img_close_buttonwrap">
				<div class="widely_img_close_button"></div>
			</button>
		</div>
	</div>
	<div class="new_Review_Update_Img_Wrap">
		<div class="new_Review_Update_Img">
			<div class="review_Update_Img_wrap">
				<div class="review_Update_Img" ></div>  <!--  style="background-image:url(https://s3-ap-northeast-2.amazonaws.com/mp-seoul-image-production/sources/web/restaurants/87430/2386738_1672794932261)" -->				
			</div>
			<div class="close_button"></div>
		</div>
	</div>
	<div class="black_screen"></div>
	<div class="review_cancel_background_dark">
		<div class="review_cancelWrap">
			<div class = "review_cancel_content"> 리뷰 쓰기를 취소하시겠습니까? <br/> 취소 시, 작성 중이던 리뷰는 삭제됩니다.</div>
			<div class = "review_cancel_items">
				<button class = "review_cancel_btn">리뷰 계속 쓰기</button>
				<button class = "review_cancel_btn">리뷰 쓰기 취소</button>
			</div>
		</div>
	</div>
	<div class="review_LaterWrite_background_dark">
		<div class="review_cancelWrap">
			<div class = "review_cancel_content"> PC웹과 모바일앱의 농민백암왕순대 페이지에서<br/>  리뷰쓰기를 누르면 리뷰를 이어쓸 수 있어요.</div>
			<div class = "review_cancel_items">
				<button class = "review_LaterWrite_cancel_btn">취소</button>
				<button class = "review_LaterWrite_cancel_btn">확인</button>
			</div>
		</div>
	</div>
</body>
</html>