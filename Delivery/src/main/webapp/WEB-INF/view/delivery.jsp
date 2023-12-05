<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./include/top.jsp" %>
<!DOCTYPE html>
<html>
<style>
.img{
	width: 100px;
    height: 100px;
    border-radius: 50%;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5);
}
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<br><br>
	<div>
		<table style="width: 100%;">
			<c:forEach var="res" items="${ restaurants }">
				<tr align="center">
					<td>
						<a href="/restaurant.do?restaurantId=${ res.restaurantId }">
							<img src="/img/${ res.restaurantImgName }" class=img>
						</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<section style="min-height: 20vh;"></section>
</body>
<%@ include file="./include/footer.jsp" %>
</html>