<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>KAKAO 지도 생성하기</title>
</head>
<body>
<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:500px;height:450px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=86f91aa96af4888885f6160a58c85762"></script>
<script>
var container = document.getElementById('map'), // 지도를 표시할 div 
    options = { 
        center: new kakao.maps.LatLng(36.349276, 127.377678), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(container, options); 
</script>
</body>
</html>