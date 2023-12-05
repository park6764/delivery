<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./include/top2.jsp" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.divCenter {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	margin: 0;
}

.sideBanner {
	position: absolute;
	width: 300px;
	height: 200px;
	top: 450px;
	background-color: #ffffff;
	color: #fffffff;
	right: 50px;
	border-radius: 15px;
	overflow-y: auto;
	padding: 10px;
	border: 2px solid rgba(192, 192, 192, 0.7);
}

.menuNameList {
	list-style-type: none;
	padding: 0;
	margin: 0;
}

.menuNameList li {
	font-size: 16px;
	margin-bottom: 5px;
}

#close:hover, #close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

#close {
	padding-left: 10px;
	font-weight: bold;
	font-size: 20px;
	background: #f2f2f2;
}
.menuImg{
	transition: filter 0.3s ease; /* 효과에 대한 전환 효과 추가 */
}
.menuImg:hover {
   filter: brightness(80%); /* 마우스 오버 시 이미지 어둡게 표현 */
 }
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <p style="margin: 60px;"></p>
    <div class="divCenter">
        <table>
            <c:forEach var="res" items="${ restaurant }">
                <tr>
                    <td width="400px;">
                    	<br><br>
                        <span style="font-weight: bold; font-size: 20px;">${ res.menuName }</span>
                    </td>
                    <td rowspan="3">
                    	<span style="padding-left: 30px;"></span>
                        <img class=menuImg src="/img/${ res.menuImgName }" width="150" height="180" style="padding-bottom: 10px;" onclick="basket('${ res.menuName }')">
                        <br><br><br>
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="/img/도토리.png" width="30" height="30" style="padding-bottom: 10px; padding-right: 10px;">
                        ${ res.menuPrice }
                        <br>
                    </td>
                </tr>
                <tr class=signupTr>
                    <td>
                        <span style="color: #777777; display: block;">${ res.menuExplanation }</span>
                        <br><br><br><br>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>

	<div class="sideBanner" id="sideBanner">
		<p class="txt-label">
			<span id="close" onclick="closeBanner()">
				장바구니	
				<span style="padding-left: 145px;"></span>
				&times;
			</span>
		</p>
		<ul class="menuNameList" id="menuNameList"></ul>
	</div>

	<section style="min-height: 40vh;"></section>
</body>
<script type="text/javascript">
	

	function closeBanner() {
	    document.getElementById('sideBanner').style.display = 'none';
	    $("#menuNameList").empty();
	}

	$(".sideBanner").hide();

	function basket(menuName) {
		// 선택된 메뉴를 플로팅 배너에 추가
		$("#menuNameList").append("<li>" + menuName + "</li>");
		$(".sideBanner").show();
		// 플로팅 배너에 선택된 메뉴 표시
		//var selectedMenu = $("#selectedMenu");
		//selectedMenu.text(menuName);
		//selectedMenu.show();
	}

	var floatPosition = parseInt($(".sideBanner").css('top'))

	// scroll 인식
	$(window).scroll(function() {

		// 현재 스크롤 위치
		var currentTop = $(window).scrollTop();
		var bannerTop = currentTop + floatPosition + "px";

		//이동 애니메이션
		$(".sideBanner").stop().animate({
			"top" : bannerTop
		}, 500);

	}).scroll();
</script>
<%@ include file="./include/footer2.jsp" %>
</html>
