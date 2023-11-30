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
		<div style="display: flex; text-align: center; justify-content: center;">
			<p class=pTag>
				<a href="#">	
					<img class=ap src="/img/기본프로필.png" width=270 height="270" style="margin: 50px;"><br>
				</a>
				<span>내 정보 수정</span>
			</p>
			<p class=pTag>
				<a href="#">	
					<img class=ap src="/img/주문서.png" width=270 height="270" style="margin: 50px;"><br>
				</a>
				주문내역
			</p>
			<p class=pTag>
				<a href="#">	
					<img class=ap src="/img/리뷰아이콘.png" width=270 height="270" style="margin: 50px;"><br>
				</a>
				리뷰관리
			</p>
		</div>
	<section style="min-height: 40vh;"></section>
</body>
<%@ include file="./include/footer2.jsp" %>
</html>