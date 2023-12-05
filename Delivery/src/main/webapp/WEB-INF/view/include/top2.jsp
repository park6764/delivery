<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/css/boot/bootstrap.min.css">
<link rel="stylesheet" href="/css/top.css">
<script src="/js/jquery-3.6.0.js"></script>
<style>
.dropbtn {
	background-color: #4CAF50;
	color: white;
	padding: 12px;
	font-size: 10px;
	border: none;
	cursor: pointer;
}

.dropdown {
	display: inline-block;
	position: relative;
}

.dropdown-content {
	display: none;
	position: absolute;
	background-color: #f9f9f9;
	min-width: 160px;
	z-index: 1;
	top: 100%;
	left: -35%;
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
	text-align: center;
}

.dropdown-content a:hover {
	background-color: #f1f1f1;
}

.dropdown:hover .dropdown-content {
	display: block;
}

.dropdown:hover .dropbtn {
	background-color: #3e8e41;
}

.image-container {
	display: inline-block;
	position: relative;
}

.image-container img {
	max-width: 100%;
	height: auto;
}
.white-text-box {
    text-align: center;
    width: 40%;
    height: 200px;
    color: black;
    padding: 5px;
    margin: 0 auto; /* 수평 가운데 정렬을 위한 margin 설정 */
    box-sizing: border-box; /* border와 padding이 width에 포함되도록 box-sizing 설정 */
}

</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		
		<img class=ap src="/img/${ restaurantImgName }" width=100% height="500" style="padding-bottom: 10px;">
		<table class=topTable>
			<tr>
				<td style="vertical-align: top;">
					<p class=homeLeft style="font-weight: bold; font-size: 2.5em;">
						<a href="/delivery.do">
							<span class=logo>배</span>달 <span class=logo>민</span>족!
						</a>
					</p>
				</td>
				<td width="40%" style="border: 3px solid #ccc; text-align: center;">
				    <div class="white-text-box" style="display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%;">
				        <span style="font-weight: bold; font-size: 70px;">
				            ${ restaurantName }
				            <span style="font-weight: bold; font-size: 30px; display: block;">
				                <img class="ap" src="/img/별.jpg" width="50px" height="50px"> 
				                <span style="padding-top: 10px;">4.9(9,535)</span>
				            </span>
				        </span>
				    </div>
				</td>
				<td align="right" style="vertical-align: top;">
					<span>
						<c:if test="${ userInfo eq null }">
							<c:if test="${ signup ne 'signup' }">
								<span style="padding-left: 25px; padding-right: 35px;"></span>
								<a href="/signup.do">회원가입</a>
							</c:if>
							<span style="padding-left: 25px;">
								<button class="btn btn-outline-danger" onclick="login_()">로그인</button>
							</span>
							<span style="padding-left: 25px; padding-right: 100px;"></span>
						</c:if>
					</span>
					<c:if test="${ userInfo ne null }">
						<img class=ap src="/img/도토리.png" width=30 height="30" style="padding-bottom: 10px; padding-right: 10px;">
						<fmt:formatNumber value="${ userInfo.acornCoin }" pattern="#,###" />
						<span style="padding-right: 15px;"></span>
						<span style="font-weight: bold; font-size: 18px;">${ userInfo.nick }</span>&nbsp;님 환영합니다.
						<div class="dropdown image-container" style="padding-right: 50px; padding-left: 30px;">
							<img class=ap src="/img/설정탭.png" width=40 height="55" style="padding-bottom: 15px;">
							<div class="dropdown-content">
								<a href="/myPage.do">마이페이지</a>
					    		<a href="#">도토리 충전</a>
					    		<a href="#">인기 메뉴</a>
					    		<a href="/logout.do">로그아웃</a>
								<c:if test="${ userInfo.group eq '관리자' }">
									<a href="/admin_group.do">groups</a>
									<a href="/admin_restaurant.do">restaurants</a>
								</c:if>
								<c:if test="${ userInfo.group eq '오너' }">
									<a href="/">order</a>
									<a href="/">operating profit</a>
									<a href="/owner_menu.do">menu</a>
								</c:if>
					    		

					  		</div>
						</div>  
					</c:if>
				</td>
			</tr>
		</table>
	</div>
</body>
<script type="text/javascript">
	function login_() {
		var link = '/login.do';
		window.location.replace(link);
	}
	
	// root path
	function getContextPath() {
	    var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	    return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	};
</script>
</html>