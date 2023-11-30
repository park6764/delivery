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
					<c:forEach var="user" items="${ users }">
						<tr class=signupTr align="center">
							<td><input type="checkbox"></td>
							<td>${ user.userId }</td>
							<td>${ user.userName }</td>
							<td>
								<select id=groupName name=groupName>
									<option align=center selected="selected" value="${ user.group }">${ user.group }</option>
									<c:forEach var="role" items="${ groups }">
								        <c:if test="${ user.group ne role }">
								            <option value="${ role }">${ role }</option>
								        </c:if>
								    </c:forEach>
								</select>
							</td>
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
					<div class=modalTap style="padding-top: 2.8px;">
						<span style="color:white; font-weight: bold; font-size: 16px;">레스토랑 추가</span>
						<span id="modalCloseButton"><b style="color:white; font-size:28px; padding-left: 385px;" >&times;</b></span>
					</div>
					<div style="margin: 30px;">
						<span style="font-weight: bold;">레스토랑 명</span><input type="text" class=inp id=restaurantName size=30>
					</div>
					<div>
						<span style="font-weight: bold;">오너 아이디</span><input type="text" class=inp id=ownerId size=30>
					</div>
					<div style="margin: 20px;">
						<span style="font-weight: bold; padding-left: 67px;">레스토랑 이미지</span><input type="file" class=inp id=restaurantImg>
					</div>
					<div style="margin: 35px;">
						<span>
							<button class="btn btn-outline-danger" onclick="addRes()">저장</button>
						</span>
					</div>
	  			</div>
			</div>
			
		</div>
	<section style="min-height: 40vh;"></section>
<script type="text/javascript">
	
	const modalOpenButton = document.getElementById('modalOpenButton');
	const modalCloseButton = document.getElementById('modalCloseButton');
	const modal = document.getElementById('modalContainer');
	
	modalOpenButton.addEventListener('click', () => {
		modal.classList.remove('hidden');
	});
	
	modalCloseButton.addEventListener('click', () => {
		modal.classList.add('hidden');
	});
	
	//체크박스 선택 여부
	function checkB() {
	    var checkboxes = document.querySelectorAll('table input[type="checkbox"]');
	    const anyChecked = Array.prototype.some.call(checkboxes, (checkbox) => checkbox.checked);
	    return anyChecked;
	}
	
	// 레스토랑 추가
	function addRes() {
		var path = getContextPath();
		var ownerId = document.getElementById('ownerId').value;;
		var restaurantName = document.getElementById('restaurantName').value;;
		var restaurantImg = document.getElementById('restaurantImg').value;;
		
		var info = {};
		
		info.ownerId = ownerId;
		info.restaurantName = restaurantName;
		info.restaurantImg = restaurantImg;
		
		$.ajax({
			type : "POST"
			, url : path + "/addRes.do"
			, contentType : "application/json"
			, data : JSON.stringify(info)
			, success : function(data) {
				if ("T" != data) {
					alert("레스토랑 추가를 실패하였습니다.");
				} else {
					window.location.href = path + '/admin_restaurant.do';
				}
			}
			
		})
	}
</script>
</body>
<%@ include file="./include/footer2.jsp" %>
</html>