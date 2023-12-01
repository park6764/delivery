<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<br>
	<div align="center">
		<table class=loginT>
			<tr class=loginTr>
				<td><span class=title>주문접수</span></td>
			</tr>
			<tr>
				<td>
					<br>
					<span class=inputText>아이디</span><br>
					<input type="text" class=inputId id=userId name=userId value="owner@naver.com" onkeypress="checkEnter(event)">
				</td>
			</tr>
			<tr>
				<td>
					<br>
					<span class=inputText>비밀번호</span><br>
					<input type="password" class=inputPw id=pw name=pw value="12345678" onkeypress="checkEnter(event)">
				</td>
			</tr>
			<tr>
				<td align="center">
					<button class="btn btn-danger" style="margin-top: 40px; width: 100%; height: 50px;" onclick="login()">로그인</button>
				</td>
			</tr>
			<tr>
				<td align="right">
					<br>
					<button class="pill-button">아이디/비밀번호 찾기</button>
				</td>
			</tr>
		</table>
	</div>
	<section style="min-height: 40vh;"></section>
</body>
<script type="text/javascript">
	jQuery.ajaxSetup({cache:false})
	
	function login() {
		var path = getContextPath();
		var userId = document.getElementById('userId').value;
		var pw = document.getElementById('pw').value;
		
		if(userId == "") {
			alert('아이디를 입력해주세요.');
			document.getElementById('userId').focus();
			return;
		}
		
		if(pw == "") {
			alert('비밀번호를 입력해주세요.');
			document.getElementById('pw').focus();
			return;
		}

		var dataStr = {};
		dataStr.userId = userId
		dataStr.pw = pw
		/* console.log(dataStr);
		return; */
		$.ajax({
			type : "POST"
			, url : path + "/login.do"
			, contentType : "application/json"
			, data : JSON.stringify(dataStr)
			, success : function(data) {
				if (data == "T") {
					window.location.href = '/delivery.do';
				} else  {
					alert("아이디 또는 비밀번호를 확인하여 주십시오.")
					document.getElementById('userId').value = "";
					document.getElementById('pw').value = "";
					document.getElementById('userId').focus();
				}
			}
		})
	}
	
	// 엔터키 입력 시 버튼 클릭
	function checkEnter(event) {
		if (event.keyCode === 13) {
			login();
		}
	}
</script>
<%@ include file="./include/footer2.jsp" %>
</html>