<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./include/top.jsp" %>
<!DOCTYPE html>
<html>
<style>
.modalTap {
	height: 60px;
	background-color: #d9534f;
}
.inp {
	margin: 12px;
}
#modalOpenButton, #modalCloseButton {
  cursor: pointer;
}
#modalContainer {
  width: 100%;
  height: 100%;
  position: fixed;
  top: 0;
  left: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  background: rgba(0, 0, 0, 0.5);
}
#modalContent {
  position: absolute;
  background-color: #ffffff;
  width: 550px;
  height: 400px;
  text-align: center;
}
#modalContainer.hidden {
  display: none;
}
/*  */
.Th{
	padding-right: 60px;
}
th {
	background-color: #f2f2f2; 
	text-align: center;
}
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<br>
		<div>
			<div align=center>
				<table style="width: 95%;">
					<tr>
						<td>
							<span style="font-weight: bold; font-size: 30px;">레스토랑</span>
						</td>
					</tr>
					<tr style="border-bottom: 3px solid #999; height: 20px;"></tr>
					<tr style="height: 50px; padding-right: 100px;" class=signupTr>
						<th class=Th>선택</th>
						<th class=Th>레스토랑 명</th>
						<th class=Th>오너 아이디</th>
						<th class=Th>오너 이름</th>
					</tr>
					<c:forEach var="res" items="${ restaurants }">
						<tr class=signupTr align="center">
							<td class=Th><input type="checkbox"></td>
							<td class=Th>${ res.restaurantName }</td>
							<td class=Th>${ res.ownerId }</td>
							<td class=Th>${ res.ownerName }</td>
						</tr>
					</c:forEach>
				</table>
				<br>
				<span style="padding-left: 80%;">
					<button class="btn btn-outline-secondary" style="margin: 8px; width: 60px;" onclick="">삭제</button>
					<button class="btn btn-outline-secondary" style="margin: 8px; width: 60px;" onclick="">수정</button>
					<button class="btn btn-outline-secondary" style="margin: 8px; width: 60px;" id="modalOpenButton">추가</button>
				</span>                                          
			</div>
			
			<div class=hidden id="modalContainer">
				<div id="modalContent">
					<form action="/addRes.do" method="post" enctype="multipart/form-data" onsubmit="return check()">
						<div class=modalTap style="padding-top: 2.8px;">
							<span style="color:white; font-weight: bold; font-size: 16px;">레스토랑 추가</span>
							<span id="modalCloseButton"><b style="color:white; font-size:28px; padding-left: 385px;" >&times;</b></span>
						</div>
						<div style="margin: 30px;">
							<span style="font-weight: bold;">레스토랑 명</span><input type="text" class=inp id=restaurantName name=restaurantName size=30>
						</div>
						<div>
							<span style="font-weight: bold;">오너 아이디</span><input type="text" class=inp id=ownerId name=ownerId size=30>
						</div>
						<div style="margin: 20px;">
							<span style="font-weight: bold; padding-left: 67px;">레스토랑 이미지</span><input type="file" class=inp id=restaurantImg name=restaurantImg>
							<input type="hidden" name="role" value="${ userInfo.group }">
						</div>
						<div style="margin: 35px;">
							<span>
								<input type="submit" class="btn btn-outline-danger" value="저장">
							</span>
						</div>
					</form>
	  			</div>
			</div>
		</div>
	<section style="min-height: 50vh;"></section>
<script type="text/javascript">
	
	// modalOpenButton
	const modalOpenButton = document.getElementById('modalOpenButton');
	// modalCloseButton
	const modalCloseButton = document.getElementById('modalCloseButton');
	// modal
	const modal = document.getElementById('modalContainer');
	// 모달 출력
	modalOpenButton.addEventListener('click', () => {
		modal.classList.remove('hidden');
	});
	// 모달 숨김
	modalCloseButton.addEventListener('click', () => {
		modal.classList.add('hidden');
		document.getElementById('restaurantName').value = "";
		document.getElementById('ownerId').value = "";
	});
	
	// 폼 유효성 검사
	function check() {
	    const restaurantName = document.getElementById('restaurantName').value;
	    const ownerId = document.getElementById('ownerId').value;
	    const restaurantImg = document.getElementById('restaurantImg').value;

	    if (restaurantName == "") {
	        alert("레스토랑 명을 입력해주세요.");
	        document.getElementById('restaurantName').focus();
	        return false;
	    } else if (ownerId == "") {
	        alert("오너 아이디를 입력해주세요.");
	        document.getElementById('ownerId').focus();
	        return false;
	    } else if (restaurantImg == "") {
	        alert("레스토랑 이미지를 선택해주세요.");
	        return false;
	    }

	    var path = getContextPath();

	    var info = {};
	    info.userId = ownerId;

	    // 데이터베이스에 존재하는 아이디 인지 검증
	    var isIdValid = false;

	    $.ajax({
	        type: "POST"
	        , url: path + "/idCk.do"
	        , contentType: "application/json"
	        , data: JSON.stringify(info)
	        , async: false // 동기 설정
	        , success: function (data) {
	            if (data == "T") {
	                alert("존재하지 않는 오너 아이디입니다.");
	            } else {
	                isIdValid = true;
	            }
	        }
	    });

	    return isIdValid;
	}


	
	//체크박스 선택 여부
	function checkB() {
	    var checkboxes = document.querySelectorAll('table input[type="checkbox"]');
	    const anyChecked = Array.prototype.some.call(checkboxes, (checkbox) => checkbox.checked);
	    return anyChecked;
	}
	
</script>
</body>
<%@ include file="./include/footer2.jsp" %>
</html>