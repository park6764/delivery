<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./include/top.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            overflow-x: hidden; /* 가로 스크롤 없애기 */
            overflow-y: auto; /* 세로 스크롤 유지하기 */
        }

        /* 이미지 이동 애니메이션 정의 */
        @keyframes moveBackground {
            0% {
                transform: translateX(100%);
            }
            100% {
                transform: translateX(-100%);
            }
        }

        /* 이미지를 담는 부모 컨테이너 스타일 */
        .img-div {
            white-space: nowrap; /* 자식 요소들이 줄 바꿈되지 않고 한 줄에 배치되도록 설정 */
            animation: moveBackground linear infinite 20s; /* 30초 동안 애니메이션 반복 */
            justify-content: flex-start; /* 자식 요소들을 왼쪽에서 오른쪽으로 정렬 */
            padding-top: 150px; /* 상단 여백 */
            padding-bottom: 20px; /* 하단 여백 */
            width: 1230px;
        }

        /* 각 이미지의 스타일 */
        .img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5);
            margin-top: -80px; /* 이미지가 약간 위로 올라가도록 설정 */
            transform: translateX(100%); /* 초기에 오른쪽으로 이동한 상태로 시작 */
        }
    </style>
</head>
<body>
    <div class="img-div" id="imgDiv">
        <c:forEach var="res" items="${restaurants}">
            <span style="padding-left: 100px;">
                <a href="/restaurant.do?restaurantId=${res.restaurantId}">
                    <img src="/img/${res.restaurantImgName}" class="img" onmouseover="stopAnimation()" onmouseout="startAnimation()">
                </a>
            </span>
        </c:forEach>
    </div>
    <section style="min-height: 25vh;"></section>
    <script type="text/javascript">
        var animationPaused = false;
        
        function stopAnimation() {
            animationPaused = true;
            document.querySelector('#imgDiv').style.animationPlayState = 'paused';
        }

        function startAnimation() {
            animationPaused = false;
            document.querySelector('#imgDiv').style.animationPlayState = 'running';
        }
        
        document.querySelector('#imgDiv span:first-child').style.paddingLeft = '210px';
			
	</script>
</body>
<%@ include file="./include/footer.jsp" %>
</html>
