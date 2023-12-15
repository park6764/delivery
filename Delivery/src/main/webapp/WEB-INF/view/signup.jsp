<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/top.jsp" %>
<!DOCTYPE html>
<html>
<style>
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
	<div align="center">
		<form action="/signup.do" method="post" enctype="multipart/form-data" onsubmit="return checkInfo()">
			<table class=signupTable>
				<tr class=signupTr>
					<td colspan="2"><span class=title>회원가입</span></td>
					<td></td>
				</tr>
				<tr class=signupTr>
					<th>* 아이디</th>
					<td>
						<input type="email" name=userId id=userId onchange="userinfo()" maxlength="30" placeholder="email@naver.com" value=@naver.com>
						&emsp;
						<input type="button" class="btn btn-outline-dark" id=idCk value="중복확인" onclick="idCK()">
					</td>
				</tr>
				<tr class=signupTr>
					<th>* 비밀번호</th>
					<td>
						<input type="password" name=pw id=pw onchange="userinfo()" maxlength="15" value=12345678>
						<span style="padding-left: 10px; color: red;" id=pwLen>8자리 비밀번호를 입력해주세요.</span>
					</td>
				</tr>
				<tr class=signupTr>
					<th>* 비밀번호 확인</th>
					<td>
						<input type="password" name=pwCk id=pwCk onchange="userinfo()"  maxlength="15" value=12345678>
						<span style="padding-left: 10px; color: red;" id=pwCkText>비밀번호 불일지</span>
					</td>
				</tr>
				<tr class=signupTr>
					<th>* 이름</th>
					<td>
						<input type="text" name=userName id=userName onchange="userinfo()" maxlength="10">
					</td>
				</tr>
				<tr class=signupTr>
					<th>* 닉네임</th>
					<td>
						<input type="text" name=nick id=nick onchange="userinfo()" maxlength="10">
					</td>
				</tr>
				<tr class=signupTr>
					<th>* 전화번호</th>
					<td>
						<input type="tel" class=tel name=tel id=tel onchange="userinfo()" maxlength="13" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" value=010-1234-1234>
					</td>
				</tr>
				<tr class=signupTr>
					<th>그룹</th>
					<td>
						<input type="text" name=group id=group disabled="disabled" placeholder="회원">
					</td>
				</tr>
				<tr class=signupTr>
					<th>* 주소</th>
					<td>
						<input type="text" id="sample6_postcode" disabled="disabled" maxlength="10">
						&emsp;
						<input type="button" class="btn btn-outline-dark" onclick="sample6_execDaumPostcode()" value="우편번호 검색"><br>
						<input type="text" id="sample6_address" disabled="disabled" maxlength="30"><br>
						<input type="hidden" id=addr name=addr value="">
					</td>
				</tr>
				<tr class=signupTr>
					<th>프로필</th>
					<td>
						<input type="file" name=profileImg id=profileImg onchange="userinfo()">
					</td>
				</tr>
				<tr class=signupTr>
					<th>* 2차 비밀번호</th>
					<td>
						<input type="password" name=acornPw id=acornPw onchange="userinfo()" maxlength="15" value=12345678>
						<span style="padding-left: 10px; color: red;" id=acornPwLen>8자리 비밀번호를 입력해주세요.</span>
					</td>
				</tr>
				<tr class=signupTr>
					<th>* 2차 비밀번호 확인</th>
					<td>
						<input type="password" name=acornPwCk id=acornPwCk onchange="userinfo()" maxlength="15" value=12345678>
						<span style="padding-left: 5px; color: red;" id=acornPwCkText>2차 비밀번호 불일지</span>
					</td>
				</tr>
			</table>
			<!-- <button class="btn btn-danger" style="margin: 20px; width: 150px; height: 50px;" onclick="signup()">회원가입</button> -->
			<input type="submit" class="btn btn-danger" style="margin: 20px; width: 150px; height: 50px;" value="회원가입">
		</form>
	</div>
</body>
<section style="min-height: 30vh;"></section>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	jQuery.ajaxSetup({cache:false})	
	
	var idChecked = false;
	
	// 아이디를 입력할 때마다 중복체크 false :: 중복체크를 했을 때만 결과에 따라 true return;
	$(document).ready(function() {
	    $('#userId').on('input', function() {
	        idChecked = false;
	    });
	});
	
	function idCK() {
		var userId = document.getElementById('userId').value;
		
		if("" == userId) {
			alert("아이디를 입력해주세요.")
			document.getElementById('userId').focus();
			return;
		}
		
		var path = getContextPath();
		var data = {};
		
        data.userId = userId ;
        
          $.ajax({
              type: "POST"
              , url :  path + "/idCk.do"
              , data : data
              , success: function (data){
            	  if("T" == data) {
            		  alert("사용가능한 아이디입니다.");
            		  idChecked = true;
            	  } else {
            		  alert("중복된 아이디입니다.");
            		  idChecked = false;
            	  }
           }  
		})
	}
	
	$(document).ready(function() {
	    $('#tel').on('blur', function() {
	        var inputValue = $(this).val();
	        var phoneNumberRegex = /^[0-9]{3}-[0-9]{4}-[0-9]{4}$/;

	        if (!phoneNumberRegex.test(inputValue)) {
	            $(this).val(""); // 입력값 초기화
	        }
	    });
	});
	
	// form null 체크
	function checkInfo() {
	    var userId = document.getElementById('userId').value;
	    var pw = document.getElementById('pw').value;
	    var pwCk = document.getElementById('pwCk').value;
	    var userName = document.getElementById('userName').value;
	    var nick = document.getElementById('nick').value;
	    var tel = document.getElementById('tel').value;
	    var sample6_postcode = document.getElementById('sample6_postcode').value;
	    var acornPw = document.getElementById('acornPw').value;
	    var acornPwCk = document.getElementById('acornPwCk').value;
	
	    if (userId == "") {
	        alert("아이디를 입력해주세요.");
	        document.getElementById('userId').focus();
	        return false;
	    } else if (!idChecked) {
	        alert("아이디 중복확인을 완료해주세요.");
	        return false;
	    } else if (userName == "") {
	        alert("이름을 입력해주세요.");
	        document.getElementById('userName').focus();
	        return false;
	    } else if (nick == "") {
	        alert("닉네임을 입력해주세요.");
	        document.getElementById('nick').focus();
	        return false;
	    } else if (tel == "") {
	        alert("전화번호를 입력해주세요.");
	        document.getElementById('tel').focus();
	        return false;
	    } else if (sample6_postcode == "") {
	        alert("주소를 입력해주세요.");
	        document.getElementById('sample6_postcode').focus();
	        return false;
	    } else if (pw != pwCk) {
	        alert("비밀번호를 확인해주세요.")
	        document.getElementById('pw').focus();
	        return false;
	    } else if (acornPw != acornPwCk) {
	        alert("2차 비밀번호를 확인해주세요.")
	        document.getElementById('acornPw').focus();
	        return false;
	    }
	
	    return true;
}

	 // 회원 정보 객체에 할당
	function userinfo() {
		var postcode = document.getElementById('sample6_postcode').value;
		var address = document.getElementById('sample6_address').value;
		var addr = postcode + "_" + address;
		
		document.getElementById("addr").value = addr;
	}

	function sample6_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            var addr = ''; // 주소 변수
	
	            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('sample6_postcode').value = data.zonecode;
	            document.getElementById("sample6_address").value = addr;
	        }
	    }).open();
	}
	
	// 이메일 패턴 체크
	$(document).ready(function() {
        $("#userId").on("blur", function() {
            var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
            var inputValue = $(this).val();

            if (!emailPattern.test(inputValue)) {
                // 이메일 패턴에 맞지 않으면 입력값을 초기화합니다.
                $(this).val("");
            }
        });
    });
	
	// 이름에 한글만 입력가능
	$(function(){
	    $("#userName").keyup(function (event) {
	         regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g; 
	         v = $(this).val();
	         if (regexp.test(v)) {
	             $(this).val(v.replace(regexp, ''));
	         }
	     });
	});
	
	// 아이디 입력 시 영어만 입력
	$(function(){
	    $("#userId").on("input", function() {
	        var inputValue = $(this).val();
	        var sanitizedValue = inputValue.replace(/[ㄱ-ㅎㅏ-ㅣ가-힣]/g, '');
	
	        $(this).val(sanitizedValue);
	    });
	});

	$("#pwCkText").hide();
	
	// 비밀번호와 비밀번호 확인이 다를 때 메시지 띄우기
	$('#pwCk').keyup(function() {
		var pw = document.getElementById('pw').value;
	    var pwCk = document.getElementById('pwCk').value;
		
		if(pwCk != "" && pw !== pwCk) {
			$("#pwCk").css({
                "background-color": "ivory",
                "border": "none",
                "outline": "2px solid red",
                "border-radius": "5px"
            });
			$("#pwCkText").show();
		} else {
			$("#pwCk").css({
                "background-color": "",
                "border": "",
                "outline": "",
                "border-radius": ""
            });
			$("#pwCkText").hide();
		}
	});
	
	$("#pwLen").hide();
	// 비밀번호의 길이가 8보다 작을 때 메시지 띄우기
	$('#pw').keyup(function() {
		var pw = document.getElementById('pw').value;
		
		if(pw.length < 8) {
			$("#pw").css({
                "background-color": "ivory",
                "border": "none",
                "outline": "2px solid red",
                "border-radius": "5px"
            });
			$("#pwLen").show();
		} else {
			$("#pw").css({
                "background-color": "",
                "border": "",
                "outline": "",
                "border-radius": ""
            });
			$("#pwLen").hide();
		}
	});
	
	$("#acornPwCkText").hide();
	
	// 2차 비밀번호와 비밀번호 확인이 다를 때 메시지 띄우기
	$('#acornPwCk').keyup(function() {
		var acornPw = document.getElementById('acornPw').value;
	    var acornPwCk = document.getElementById('acornPwCk').value;
		
		if(acornPwCk != "" && acornPw !== acornPwCk) {
			$("#acornPwCk").css({
                "background-color": "ivory",
                "border": "none",
                "outline": "2px solid red",
                "border-radius": "5px"
            });
			$("#acornPwCkText").show();
		} else {
			$("#acornPwCk").css({
                "background-color": "",
                "border": "",
                "outline": "",
                "border-radius": ""
            });
			$("#acornPwCkText").hide();
		}
	});
	
	$("#acornPwLen").hide();
	// 비밀번호의 길이가 8보다 작을 때 메시지 띄우기
	$('#acornPw').keyup(function() {
		var acornPw = document.getElementById('acornPw').value;
		
		if(acornPw.length < 8) {
			$("#acornPw").css({
                "background-color": "ivory",
                "border": "none",
                "outline": "2px solid red",
                "border-radius": "5px"
            });
			$("#acornPwLen").show();
		} else {
			$("#acornPw").css({
                "background-color": "",
                "border": "",
                "outline": "",
                "border-radius": ""
            });
			$("#acornPwLen").hide();
		}
	});

</script>
<%@ include file="./include/footer2.jsp" %>
</html>