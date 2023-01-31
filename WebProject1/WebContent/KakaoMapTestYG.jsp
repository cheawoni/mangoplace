<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>	
<head>
	<meta charset="UTF-8">
	<title>까까오지도테스트</title>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ed05170950c386674ae9f4fdd636dcf0"></script> <!-- Kakao Map API -->
</head>
<body>
	<div id="map" style="height:800px; width:1200px;"></div>
	
	<script>
		var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
	    var mapOption = { 
	        center: new kakao.maps.LatLng(37.4979052, 127.0275777), // 지도의 중심좌표
	        level: 4 // 지도의 확대 레벨
	    };
		
		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption); 
	</script>
	
</body>
</html>