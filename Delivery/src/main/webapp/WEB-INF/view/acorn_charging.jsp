<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./include/top.jsp" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html>
<head>
<style>
.center-div {
	display: flex;
	justify-content: center;
	/* align-items: center; */
}

.center-p {
	width: 55%;
	height: 400px;
	border: 3px solid #dddddd;
	text-align: center;
	/* line-height: 200px;*/
}

.ap {
	vertical-align: middle;
}

.price-container {
	white-space: nowrap; /* 줄 바꿈 방지 */
}

.price-item {
	display: inline-block; /* 인라인 블록 요소로 배치 */
	margin-right: 20px; /* 각 항목 간 간격 설정 */
}

.yellow-button {
	display: inline-block;
	padding: 10px 20px; /* 버튼 안의 여백 조절 */
	font-size: 16px;
	text-align: center;
	text-decoration: none;
	border: 2px solid yellow; /* 노란색 border 설정 */
	color: black; /* 텍스트 색상을 검은색으로 변경 */
	background-color: white; /* 배경색을 흰색으로 변경 */
	cursor: pointer;
	border-radius: 5px; /* 버튼 모서리를 둥글게 만듭니다. */
	width: 50%;
}

/* 호버 효과 */
.yellow-button:hover {
	background-color: rgba(245, 245, 245, 0.5);
}

/* Simple Keyboard의 스타일 */
.simple-keyboard {
  margin-top: 10px;
}

 /* 모달 스타일 */
  .modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgb(0,0,0);
    background-color: rgba(0,0,0,0.4);
  }

  .modal-content {
    background-color: #fefefe;
    margin: 6% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 30%;
    height: 300px;
  }

  .close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
    padding-right: 20px;
  }

  .close:hover,
  .close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
  }
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Simple Keyboard의 스타일 및 스크립트 추가 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-keyboard@latest/build/css/index.css">
<script src="https://cdn.jsdelivr.net/npm/simple-keyboard@latest/build/index.js"></script>
</head>
<body>
	<br><br>
	<div class="center-div">
		<div class="center-p">
			<p>
				<br><br>
				<span style="font-weight: bold; font-size: 30px; padding-right: 10px;">
					도토리 충전
				</span>
				<img class=ap src="/img/도토리.png" width=70 height="80" style="padding-bottom: 25px; padding-right: 10px;">
			</p><br>
			<div class="price-container">
				<%
					// 원화 기호
					String currencySymbol = "&#8361;";
                    
					// 가격 배열
                    int[] prices = { 10000, 50000, 100000, 150000, 200000, 500000 };
    
                    // 6번 루프 돌면서 출력
                    for (int i = 0; i < prices.length; i++) {
                        NumberFormat numberFormat = NumberFormat.getInstance();
                        String formattedPrice = numberFormat.format(prices[i]);
                %>
                    <span class="price-item">
                        <img class="ap" src="/img/도토리.png" width="40" height="40" style="padding-bottom: 10px; padding-right: 10px;"><br>
                        <input type="checkbox" name="prices" value="<%=prices[i]%>" onchange="acornChoice(event)">
                        <%=currencySymbol + formattedPrice%>
                    </span>
                <%
                    }
                %>
			</div>
			<br><br><br>
			<p>
				<button class="yellow-button" id=openModalBtn>도토리 충전</button>
			</p>
		</div>
	</div>
	
	
	<!-- 모달 -->
	<div id="myModal" class="modal">
		<div class="modal-content">
			<span style="padding-left: 20px; font-size: 28px; font-weight: bold;">
				2차 비밀번호
				<span class="close" id="closeModalBtn">&times;</span>
			</span>
			<br>
			<input type="hidden" name=role value="${ userInfo.group }">
			<input type="hidden" name=restaurantId value="${ userInfo.restaurantId }">
			<div align="center">
				<p><br><br>
					<span>
						<input type="password" size="35px;" id="acornPw" name="acornPw" class="input" maxlength="15" placeholder="2차 비밀번호 입력"/>
					</span>
				</p>
				<p><br>
					<span>
						<button class="btn btn-danger" style="width: 295px; height: 40px;" onclick="acornCharginn()">충전</button>
					</span>
				</p>
			</div>
		</div>
	</div>
	
	<section style="min-height: 30vh;"></section>
	<script>

		// 선택한 총 도토리
        var total = 0;
        
      
		//모달 열기
		document.getElementById('openModalBtn').addEventListener('click', function() {
				document.getElementById('myModal').style.display = 'block';
			});

		// 모달 닫기
		document.getElementById('closeModalBtn').addEventListener('click', function() {
				document.getElementById('acornPw').value = "";
				document.getElementById('myModal').style.display = 'none';
			});

		// 모달 외부 클릭 시 닫기
		window.addEventListener('click', function(event) {
			var modal = document.getElementById('myModal');
			var acornPw = document.getElementById('acornPw');
			
			if (event.target == modal) {
				modal.style.display = 'none';
				document.getElementById('acornPw').value = "";
			}
		});
		
		// 도토리 선택 여부
		var isChecked = false;
		
		// 도토리 누적
		function acornChoice(event) {
			isChecked = event.target.checked;
			
			var coin = Number(event.target.value);

			if (event.target.checked) {
				total += coin;
			} else {
				total -= coin;
			}

			return total;
		}

		// 도토리 추가
		function acornCharginn() {
			if(!isChecked) {
				alert("충전할 도토리를 선택해주세요.");
				var modal = document.getElementById('myModal');
				modal.style.display = 'none';
				return;
			}		
			
			// root
			var path = getContextPath();

			var fromUserId = "${ userInfo.userId }";
			var acornInfo = {};
			acornInfo.userId = fromUserId;
			acornInfo.acornPw = document.getElementById('acornPw').value;
			
			$.ajax({
				type : "POST",
				url : path + "/acornPwCk.do",
				contentType : "application/json",
				data : JSON.stringify(acornInfo),
				success : function(data) {
					if (data != "T") {
						alert("2차 비밀번호가 다릅니다.")
						document.getElementById('acornPw').value = "";
						document.getElementById('acornPw').focus();
						return;
					} 
				}
			})
			
			var inputAcorn = total;

			var data = {};

			data.fromUserId = fromUserId;
			data.inputAcorn = inputAcorn;

			$.ajax({
				type : "POST",
				url : path + "/acornCharging.do",
				contentType : "application/json",
				data : JSON.stringify(data),
				success : function(data) {
					if (data == "T") {
						var user = {};
						user.userId = fromUserId;

						$.ajax({
							type : "POST",
							url : path + "/updateAcorn.do",
							contentType : "application/json",
							data : JSON.stringify(user),
							success : function(data) {
								alert("도토리를 충전하였습니다.");
								window.location.href = '/acornCharging.do';
							}
						})
					} else {
						alert("충전을 실패했습니다.")
					}
				}
			})
		}
	</script>
</body>
<%@ include file="./include/footer2.jsp" %>
</html>
