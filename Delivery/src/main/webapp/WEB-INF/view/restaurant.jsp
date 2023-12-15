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
	width: 380px;
	height: 300px;
	top: 360px;
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
	/* background: #f2f2f2; */
}

.menuImg {
	transition: filter 0.3s ease; /* 효과에 대한 전환 효과 추가 */
}

.menuImg:hover {
	filter: brightness(80%); /* 마우스 오버 시 이미지 어둡게 표현 */
}

.basket-item {
	margin-bottom: 10px;
}

.menu-name {
	margin-right: 10px;
}

.quantity-controls {
	display: flex;
	align-items: center;
}

.quantity {
	width: 30px; /* 조절할 수량 input의 너비 조절 */
	text-align: center;
}

.quantity-controls button {
	width: 28px; /* +, - 버튼의 너비 조절 */
	height: 30px; /* +, - 버튼의 높이 조절 */
	border-radius: 50%; /* 동그랗게 만들기 */
	cursor: pointer;
	background-color: #f2f2f2; /* 배경색 설정 */
	border: none;
	margin: 0 5px;
}

.btn-order {
	width: 150px; /* 버튼 너비 조절 */
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <p style="margin: 60px;"></p>
    <div class="divCenter">
        <table>
            <c:forEach var="res" items="${ restaurant }" varStatus="loop">
                <tr>
                    <td width="400px;">
                    	<br><br>
                        <span style="font-weight: bold; font-size: 20px;">${ res.menuName }</span>
                    </td>
                    <td rowspan="3">
                    	<span style="padding-left: 30px;"></span>
                        <input type="hidden" id="menuPrice_${loop.index}" value="${ res.menuPrice }">
                        <img class=menuImg src="/img/${ res.menuImgName }" width="150" height="180" style="padding-bottom: 10px;" 
                        	onclick="basket('${ res.menuName }', 'menuPrice_${loop.index}')">
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
				<span style="padding-left: 220px;"></span>
				&times;
			</span>
		</p>
		<ul class="menuNameList" id="menuNameList"></ul>
		<br>
		<div style=" bottom: 10px; right: 10px;">
			<span>
				주문금액: 
				&nbsp;
				<img src="/img/도토리.png" width="20" height="30" style="padding-bottom: 10px;">
			</span>
			<span id=totalPrice style="padding-right: 10px;"></span>
			<button class="btn btn-outline-secondary btn-order" onclick="insertOrder()">주문하기</button>
		</div>
	</div>
	<section style="min-height: 40vh;"></section>
</body>
<script type="text/javascript">
	
	// 주문하기
	function insertOrder() {
		// root path
		const path = getContextPath();
		const userInfo = "${ userInfo }";
		// 로그인 여부 체크
		if(userInfo == "") {
			const answer = confirm("로그인이 필요한 서비스입니다. \n로그인 화면으로 이동하시겠습니까?");
			// if true ? 로그인화면으로 이동 : 메소드 종료;
			if(answer) {
				window.location.href = path + '/login.do';
			} 
			return;
		} 
		
		// 주문서 정보 가져오기
		const orderData = orderInfo(); 
		// 유저 보유 도토리
		const userAcorn = Number("${ userInfo.acornCoin }");
		// 주문 도토리(금액)
		const orderAcorn = orderData.totalAcorn;
		// 주문금액 > 보유금액 ? retrun;
		if(orderAcorn > userAcorn) {
			alert("잔액이 부족합니다.");
			return;
		}
		// 주문하기
		$.ajax({
			type : "POST"
			, url : path + "/insertOrder.do"
			, contentType : "application/json"
			, data : JSON.stringify(orderData)
			, success : function(data) {
				if ("T" != data) {
					alert("그룹수정을 실패하였습니다.");
				} else {
					alert("주문이 완료되었습니다. \n주문 수락 대기중~");
					// 마이페이지/주문내역 페이지로 이동
					window.location.href = path + '/myPage/orderHistory.do';
				}
			}
			
		})
	}
	
	// 장바구니 닫기
	function closeBanner() {
	    document.getElementById('sideBanner').style.display = 'none';
	    // 장바구니 초기화
	    $("#menuNameList").empty();
	    // 주문금액 초기화
	    price = 0;
	}

	$(".sideBanner").hide();
	
	// 장바구니 출력
	function basket(menuName, price_id) {
	    // 이미 장바구니에 메뉴가 있는지 확인
	    const existingItem = $(".basket-item:contains('" + menuName + "')");
	    
	    if (existingItem.length > 0) {
	       	// 이미 존재하는 경우 수량 증가
	        imgQuantity(price_id);
	    } else {
	        // 존재하지 않는 경우 새로운 아이템 추가
	        addBasket(price_id, menuName);
	    }
	    $(".sideBanner").show();
	}
	
	// 장바구니에 메뉴 추가
	function addBasket(price_id, menuName) {
		// 주문 리스트 추가
		$("#menuNameList").append('<li class="basket-item" data-price-id="' + price_id + '">' +
            '<span class="menu-name">' + menuName + '</span>' +
            '<input type="hidden" id="priceId" value="' + price_id + '">' +
            '<div class="quantity-controls">' +
            '<button class="decrement-quantity" onclick="decrementQuantity(this)">-</button>' +
            '<span class="quantity">1</span>' + 
            '<button class="increment-quantity" onclick="incrementQuantity(this)">+</button>' + // this를 안쓰려 했으나 써야 모든 값을 가져올 수 있음..
            '</div>' +
            '</li>'
        );
        // 가격 아이디
		const addPrice = $("#" + price_id).val();
		// 수량 / 가격 업데이트
	    updateTotalPrice(addPrice, 1); 
	}
	
	// 메뉴 이름 누적
    var menuNames = "";
	// 메뉴 수량 누적
    var menuCount = "";
	// 메뉴 가격 누적
    var menuPrice = "";
	
	// 주문서 정보
	function orderInfo() {
		// 현재 URL에서 "restaurantId" 값 가져오기
	    const url = new URLSearchParams(window.location.search);
		// 레스토랑 아이디
	    const restaurantId = url.get('restaurantId');
		// 메뉴이름 누적
	    const menuNames = [];
        $(".basket-item").each(function() {
            const itemName = $(this).find('.menu-name').text();
            menuNames.push(itemName);
        });
		
		
	    // 메뉴수량 누적
		const menuCounts = [];
        $(".basket-item").each(function() {
            const itemCount = $(this).find('.quantity').text();
            menuCounts.push(itemCount);
        });
	    
	    // 메뉴각겨 누적
	    const menuPrices = [];
        $(".basket-item").each(function() {
            const priceId = $(this).data('price-id');
            const itemPrice = $("#" + priceId).val();
            menuPrices.push(strToInt(itemPrice));
        });
        // 콤마 제거
        const tot = Number(strToInt($("#totalPrice").text()));
     	// 주문서 정보
        const order = {
			// 레스토랑 아이디
            restaurantId: restaurantId
		    // 유저 아이디
            , userId: "${userInfo.userId}"
		    // 주문한 메뉴들
            , menus: menuNames.join("_") // 배열을 문자열로 변환하여 구분자로 연결
		    // 메뉴 별 주문 수
            , menuCount: menuCounts.join("_")  
		    // 메뉴 별 가격
            , menuPrice: menuPrices.join("_")  
		    // 총 금액
            , totalAcorn: tot
        };
     
	    return order;
	}
	
	// 이미지 클릭 시 수량 추가
	function imgQuantity(price_id) {
	    // 가격 아이디에 따른 메뉴의 수량
	    const quantityElement = $(".basket-item[data-price-id='" + price_id + "']").find('.quantity');
		// int 파싱
	    const currentValue = parseInt(quantityElement.text());
		// 수량은 최대 10까지만 추가 가능
	    if (currentValue < 10) {
	    	// 수량 + 1
	        quantityElement.text(currentValue + 1);
	    	// 메뉴의 가격
	        const addPrice = $("#" + price_id).val();
	    	// 수량, 총 주문금액 업데이트
	        updateTotalPrice(addPrice, 1);
	    }
	}

	// + 버튼 클릭 시 수량 증가
	function incrementQuantity(button) {
	    // 장바구니에 추가된 메뉴의 수량
	    const quantityElement = $(button).siblings('.quantity');
		// int로 파싱
	    const currentValue = parseInt(quantityElement.text());
		// 메뉴의 수량은 10까지만 추가가능
	    if (currentValue < 10) {
	    	// 수량표시 업데이트
	        quantityElement.text(currentValue + 1);
	        // 현재 버튼의 부모 요소인 div에서 hiddenValue 가져오기
	        const hiddenValue = $(button).closest('.basket-item').find('#priceId').val();
			const addPrice = $("#" + hiddenValue).val();
			// 수량 / 가격 업데이트
			updateTotalPrice(addPrice, 1); 
	    }
	} 

	// - 버튼 클릭 시 수량 감소
	function decrementQuantity(button) {
		// 장바구니 
		const listItem = $(button).closest('.basket-item');
	    // 장바구니에 추가된 메뉴의 수량
	    const quantityElement = listItem.find('.quantity');
	    // int로 파싱
	    const currentValue = parseInt(quantityElement.text());
	 	// 가격 ID
	    const priceId = listItem.data('price-id'); 
	 	// 메뉴 가격
	    const addPrice = $("#" + priceId).val();
		// 메뉴의 수량이 2이상이면 수량 감소
	    if (currentValue > 1) {
	    	// 수량 -1
	        quantityElement.text(currentValue - 1);
	    	// 변경내용 업데이트
	        updateTotalPrice(addPrice, -1);
	    // 메뉴의 수량이 2보다 작으면 메뉴 삭제
	    } else {
	    	// 변경내용 업데이트
	        updateTotalPrice(addPrice, -1);
	    	// 장바구니에서 제거
	        listItem.remove();
			// 장바구니가 비어있으면 장바구니 숨김
	        if ($("#menuNameList").children().length === 0) {
	            price = 0;
	            $(".sideBanner").hide();
	        }
	    }
	}

	// 총 금액 누적
	var price = 0;
	
	// 총 주문금액 계산
	function updateTotalPrice(menuPrice, quantityChange) {
		// 콤마 제거 및 숫자로 파싱
		const menu_price = strToInt(menuPrice);
		// 값 누적
	    price += quantityChange * Number(menu_price);
		// 3자리마다 콤마
	    const totalPrice = price.toLocaleString();
		// 값 적용
	    $("#totalPrice").text(totalPrice);
	}

	// 콤마 제거 및 숫자로 파싱
	function strToInt(str) {
		// 콤마를 제거한 후 정수로 변환
	    const intVal = Number(str.replace(/,/g, ''));
		return intVal;
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
