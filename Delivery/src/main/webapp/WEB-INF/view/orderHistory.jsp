<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./include/top.jsp"%>
<!DOCTYPE html>
<html>
<style>
#toggleContent {
	display: none;
}

.bright-gray-button {
	background-color: #f5f5f5; /* 밝은 그레이 색상 */
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
	width: 350px;
	font-size: 15px;
	font-weight: bold;
}

.bright-gray-box {
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 5px;
	width: 350px;
	height: auto;
	display: inline-block;
}

.container {
	width: 350px;
}

.left-span, .right-span {
	display: inline-block;
}

.left-span {
	float: left;
	width: 200px;
	text-align: left;
	padding-top: 13px;
	padding-left: 10px;
	font-weight: bold;
	font-size: 17px;
}

.right-span {
	float: right;
}

.day {
	width: 100px;
	padding-left: 10px;
	color: #bbb;
	font-size: 13px;
}

.spacer{
	height: 60%;
	margin-top: 50px;
	margin-bottom: 50px;
	padding-left: 10px;
}

#toggleContent {
	display: none;
	position: relative; /* 부모 요소를 기준으로 자식 요소의 위치 조정을 위해 추가 */
}
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<br>
	<div style="display: flex; justify-content: center;">
		<div style="text-align: center;">
			<a href="/myPage/orderHistory.do"> <img class=ap
				src="/img/주문서.png" width=250 height="200"><br>
			</a><br>
			 <span style="font-size: 20px; font-weight: bold; text-align: center;">주문내역</span>
		</div>
		<span style="margin: 50px;"></span>
		<div>
			<button class="bright-gray-button" onclick="toggle()">레스토랑 이름을 띄우고</button>
			<br>
			<br>
			<div id="toggleContent" class=highlighted-content>
				<div class="bright-gray-box container">
					<div class="left-span">스파이시 큐브 스테이크와퍼 세트</div>
					<div class="day">2023-12-14</div>
	    			<div class="right-span" style="margin-top: -65px; padding-right: 15px;"><img src="/img/주문서.png" width=100 height="100"></div>
	    			<div class="spacer">
	    				
	    			</div>
					<div align="center">
						<button class="btn btn-outline-dark" style="width: 335px;">리뷰작성</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<section style="min-height: 50vh;"></section>
</body>
<script type="text/javascript">
	function toggle() {
		var toggleContent = document.getElementById("toggleContent");

		// toggleContent의 display 속성을 변경하여 토글 동작 수행
		if (toggleContent.style.display === "none") {
			toggleContent.style.display = "block";
		} else {
			toggleContent.style.display = "none";
		}
	}
</script>
<%@ include file="./include/footer2.jsp"%>
</html>