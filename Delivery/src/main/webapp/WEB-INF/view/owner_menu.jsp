<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./include/top.jsp" %>
<!DOCTYPE html>
<html>
<style>
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
    width: 50%;
    height: 550px;
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
  
  .menuSapn{
  	font-size: 16px;
    font-weight: bold;
    text-align: center;
    padding-right: 225px;
  }
  .menuInput{
  	text-align: center;
  }
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<br>
		<div align=center>
			<table style="width: 95%;">
				<tr style="border-bottom: 3px solid #999; height: 50px;"></tr>
				<tr style="height: 50px;" class=signupTr>
					<th>선택</th>
					<th>메뉴 이름</th>
					<th>메뉴 가격</th>
					<th>메뉴 이미지</th>
					<th style="width: 500px;">메뉴 설명</th>
				</tr>
				<c:forEach var="menu" items="${ menus }">
					<tr class=signupTr align="center">
						<td><input type="checkbox"></td>
						<td>${ menu.menuName }</td>
						<td>
							<img class=ap src="/img/도토리.png" width=30 height="30" style="padding-bottom: 10px; padding-right: 10px;">
							${ menu.menuPrice }
						</td>
						<td>
							<img src="/img/${ menu.menuImgName }" style="width: 50px; height: 50px;">
						</td>
						<td align="left">${ menu.menuExplanation }</td>
					</tr>
				</c:forEach>
			</table>
			<br>
			<span style="padding-left: 80%;">
				<button class="btn btn-outline-secondary" style="margin: 8px; width: 60px;" onclick="">삭제</button>
				<button class="btn btn-outline-secondary" style="margin: 8px; width: 60px;" onclick="">수정</button>
				<button class="btn btn-outline-secondary" style="margin: 8px; width: 60px;" id=openModalBtn>추가</button>
			</span> 
		</div>

		<!-- 모달 -->
		<div id="myModal" class="modal">
			<div class="modal-content">
				<span style="padding-left: 20px; font-size: 28px; font-weight: bold;">메뉴 추가<span class="close" id="closeModalBtn">&times;</span></span>
				<br>
				<form action="/addMenu.do" method="post" enctype="multipart/form-data" onsubmit="return check()">
					<input type="hidden" name=role value="${ userInfo.group }">
					<input type="hidden" name=restaurantId value="${ userInfo.restaurantId }">
					<div align="center">
						<p>
							<span class=menuSapn>메뉴 이름</span><br>
							<span class=menuInput>
								<input type="text" size="35px;" id=menuName name=menuName>
							</span>
						</p>
						<p>
							<span class=menuSapn>메뉴 가격</span><br>
							<span class=menuInput>
								<input type=text size="35px;" id=menuPrice name=menuPrice oninput="formatNumber(this)">
							</span>
						</p>
						<p>
							<span class=menuSapn>&emsp;메뉴 이미지</span><br>
							<span class=menuInput>
								<input type="file" id=menuImg name=menuImg>
							</span>
						</p>
						<p>
							<span class=menuSapn>메뉴 설명</span><br>
							<span class=menuInput>
								<textarea style="resize: none;" rows="4" cols="37" id=menuExplanation name=menuExplanation maxlength="50" placeholder="50자 이내 작성"></textarea>
							</span>
						</p>
						<p><br>
							<span>
								<button class="btn btn-danger" style="width: 295px; height: 40px;">추가</button>
							</span>
						</p>
					</div>
				</form>
			</div>
		</div>

	<section style="min-height: 40vh;"></section>
<script type="text/javascript">

	//모달 열기
	document.getElementById('openModalBtn').addEventListener('click', function() {
				document.getElementById('myModal').style.display = 'block';
			});

	// 모달 닫기
	document.getElementById('closeModalBtn').addEventListener('click', function() {
				document.getElementById('myModal').style.display = 'none';
			});

	// 모달 외부 클릭 시 닫기
	window.addEventListener('click', function(event) {
		var modal = document.getElementById('myModal');
		if (event.target == modal) {
			modal.style.display = 'none';
		}
	});
	
	// 숫자만 입력 +3자리마다 콤마 추가
	function formatNumber(input) {
      // 입력된 값에서 콤마 제거
      var value = input.value.replace(/,/g, '');

      // 숫자 이외의 문자 제거
      value = value.replace(/[^0-9]/g, '');

      // 콤마 추가
      var formattedValue = Number(value).toLocaleString();
      
      // 입력란에 포맷팅된 값 적용
      input.value = formattedValue;
    }
	
	// form null 체크
	function check() {
		const menuName = document.getElementById('menuName').value;
		const menuPrice = document.getElementById('menuPrice').value; // 수정된 부분
		const menuImg = document.getElementById('menuImg').value;
		const menuExplanation = document.getElementById('menuExplanation').value;

		if (menuName == "") {
			alert("메뉴의 이름을 입력해주세요.");
			document.getElementById('menuName').focus();
			return false;
		} else if (menuPrice == "") { // 수정된 부분
			alert("메뉴의 가격을 입력해주세요.");
			document.getElementById('menuPrice').focus();
			return false;
		} else if (menuImg == "") {
			alert("메뉴의 이미지를 선택해주세요.");
			return false;
		} else if (menuExplanation == "") {
			alert("메뉴의 설명을 입력해주세요.");
			document.getElementById('menuExplanation').focus();
			return false;
		}
	}
</script>
</body>
<%@ include file="./include/footer2.jsp" %>
</html>