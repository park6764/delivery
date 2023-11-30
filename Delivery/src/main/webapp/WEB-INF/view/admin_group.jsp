<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./include/top.jsp" %>
<!DOCTYPE html>
<html>
<style>

div.serchDiv {
    text-align: left;
    width: 95%;
    background-color:  #eeeeee;
    margin: 20px auto; /* 위와 아래에 20px 여백을 주고 가운데 정렬합니다 */
    border-radius: 10px;
    padding: 20px; /* 내부 여백을 추가하여 요소들 사이의 간격을 늘립니다 */
    display: flex; /* 요소들을 가로로 정렬하기 위해 flexbox를 사용합니다 */
    align-items: center; /* 요소들을 수직으로 중앙 정렬합니다 */
}

select{
    width: 130px;
    border: 1px solid #C4C4C4;
    box-sizing: border-box;
    border-radius: 10px;
    padding: 5px 5px;
    font-family: 'Roboto';
    font-style: normal;
    font-weight: 400;
    font-size: 14px;
    line-height: 16px;
    text-align: center;
}

select:focus{
    box-sizing: border-box;
    border-radius: 10px;
    border-radius: 10px;
}
select:hover {
    background-color: #F0F0F0;
}
.serch{
	border: 1px solid #C4C4C4;
	border-radius: 10px;
	padding: 3px 3px;
	padding-left: 15px;
	width: 350px;
}
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<br>
		<div>
			<div class=serchDiv>
				<table style="width: 100%;">
					<tr>
						<td>
							<span style="padding: 20px 20px; font-weight: bold; font-size: 20px;">그룹</span>
							<select>
								<option>회원</option>
								<option>오너</option>
								<option>관리자</option>
							</select>
						</td>
						<td align="right">
							<form action="">
								<select>
									<option value="전체" selected="selected">전체</option>
									<option value=ID>ID</option>
									<option value=이름>이름</option>
								</select>
								<span style=" padding-left: 15px;"></span>
								<input type="text" class="serch" placeholder="검색어 입력">
								<span style=" padding-left: 15px;"></span>
								<input type="submit" class="btn btn-outline-dark" style="height: 35px; padding-bottom: 8px;" value="검 색">
								<span style=" padding-left: 15px;"></span>
							</form>
						</td>
					</tr>
				</table>
			</div>
			<div align=center>
				<table style="width: 95%;">
					<tr style="border-bottom: 3px solid #999; height: 50px;"></tr>
					<tr style="height: 50px;" class=signupTr>
						<th>선택</th>
						<th>사용자 ID</th>
						<th>사용자 이름</th>
						<th>그룹 선택</th>
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
				<span style="padding-left: 90%;">
					<button class="btn btn-danger" style="margin: 30px; width: 80px;" onclick="changeGroup()">저장</button>
				</span>
			</div>
		</div>
	<section style="min-height: 40vh;"></section>
<script type="text/javascript">

	//체크박스 선택 여부
	function checkB() {
	    var checkboxes = document.querySelectorAll('table input[type="checkbox"]');
	    const anyChecked = Array.prototype.some.call(checkboxes, (checkbox) => checkbox.checked);
	    return anyChecked;
	}
	
	// 그룹 변경
	function changeGroup() {
		var path = getContextPath();
		
		if(!checkB()) {
			alert("사용자를 선택해주세요.");
			return;
		} 
		
		var selectedChanges = [];

		$("table input[type='checkbox']:checked").each(function () {
            const userId = $(this).closest("tr").find("td:eq(1)").text();
            const group = $(this).closest("tr").find("select[name=groupName]").val();
            const role = "${userInfo.group}";
            selectedChanges.push({ userId, group, role });
        });
        
		var changeData = selectedChanges;
		
		$.ajax({
			type : "POST"
			, url : path + "/changeGroup.do"
			, contentType : "application/json"
			, data : JSON.stringify(changeData)
			, success : function(data) {
				if ("T" != data) {
					alert("그룹수정을 실패하였습니다.");
				} else {
					alert("그룹을 수정하였습니다.");
					window.location.href = path + '/admin_group.do';
				}
			}
			
		})
	}
</script>
</body>
<%@ include file="./include/footer2.jsp" %>
</html>