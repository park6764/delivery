<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./include/top.jsp" %>
<!DOCTYPE html>
<html>
<style>
.pTag{
	margin: 0; 
	padding: 0;
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
					<th>메뉴 설명</th>
				</tr>
				<c:forEach var="user" items="${ users }">
					<tr class=signupTr align="center">
						<td>${ user.userId }</td>
						<td>${ user.userName }</td>
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
	<section style="min-height: 40vh;"></section>
</body>
<%@ include file="./include/footer2.jsp" %>
</html>