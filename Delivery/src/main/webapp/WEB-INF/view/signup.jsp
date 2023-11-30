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
		<table class=signupTable>
			<tr class=signupTr>
				<td colspan="2"><span class=title>회원가입</span></td>
				<td></td>
			</tr>
			<tr class=signupTr>
				<th>* 아이디</th>
				<td>
					<input type="email" name=userId id=userId onchange="userinfo()" maxlength="30">
					&emsp;
					<input type="button" class="btn btn-outline-dark" id=idCk value="중복확인" onclick="idCK()">
				</td>
			</tr>
			<tr class=signupTr>
				<th>* 비밀번호</th>
				<td>
					<input type="password" name=pw id=pw onchange="userinfo()" maxlength="15">
					<span style="padding-left: 10px; color: red;" id=pwLen>8자리 비밀번호를 입력해주세요.</span>
				</td>
			</tr>
			<tr class=signupTr>
				<th>* 비밀번호 확인</th>
				<td>
					<input type="password" name=pwCk id=pwCk onchange="userinfo()"  maxlength="15">
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
					<input type="tel" class=tel name=tel id=tel onchange="userinfo()" maxlength="13" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}">
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
				</td>
			</tr>
			<tr class=signupTr>
				<th>프로필</th>
				<td>
					<input type="file" name=profilePicture id=profilePicture onchange="userinfo()">
				</td>
			</tr>
			<tr class=signupTr>
				<th>* 2차 비밀번호</th>
				<td>
					<input type="password" name=acornPw id=acornPw onchange="userinfo()" maxlength="15">
					<span style="padding-left: 10px; color: red;" id=acornPwLen>8자리 비밀번호를 입력해주세요.</span>
				</td>
			</tr>
			<tr class=signupTr>
				<th>* 2차 비밀번호 확인</th>
				<td>
					<input type="password" name=acornPwCk id=acornPwCk onchange="userinfo()" maxlength="15">
					<span style="padding-left: 5px; color: red;" id=acornPwCkText>2차 비밀번호 불일지</span>
				</td>
			</tr>
		</table>
		<button class="btn btn-danger" style="margin: 20px; width: 150px; height: 50px;" onclick="signup()">회원가입</button>
	</div>
</body>
<section style="min-height: 30vh;"></section>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	jQuery.ajaxSetup({cache:false})	
	
	var idChecked = false;
	
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
            	  }else{
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

	// 회원 정보 객체에 할당
	function userinfo() {
		var userId = document.getElementById('userId').value;
		var pw = document.getElementById('pw').value;
		var pwCk = document.getElementById('pwCk').value;
		var userName = document.getElementById('userName').value;
		var nick = document.getElementById('nick').value;
		var tel = document.getElementById('tel').value;
		var postcode = document.getElementById('sample6_postcode').value;
		var address = document.getElementById('sample6_address').value;
		var profilePicture = document.getElementById('profilePicture').value;
		var acornPw = document.getElementById('acornPw').value;
		var acornPwCk = document.getElementById('acornPwCk').value;
		
		var info = {};
		
		info.userId = userId;
		info.pw = pw;
		info.userName = userName;
		info.nick = nick;
		info.tel = tel;
		info.addr = postcode + "_" + address;
		info.profileImgName = profilePicture;
		info.profileImg = profilePicture;
		info.acornPw = acornPw;
		return info;
	}
	
	
	
	// 회원가입
	function signup() {
		var path = getContextPath();
		var userInfo = userinfo();
		
		var userId = document.getElementById('userId').value;
		
	    var pw = document.getElementById('pw').value;
	    var pwCk = document.getElementById('pwCk').value;
	    
	    var userName = document.getElementById('userName').value;
	    var nick = document.getElementById('nick').value;
	    var tel = document.getElementById('tel').value;
	    var group = document.getElementById('group').value;
	    var sample6_postcode = document.getElementById('sample6_postcode').value;
	    var sample6_address = document.getElementById('sample6_address').value;
	    var profilePicture = document.getElementById('profilePicture').value;
	    
	    var acornPw = document.getElementById('acornPw').value;
	    var acornPwCk = document.getElementById('acornPwCk').value;
		
		if (userId == "") {
	        alert("아이디를 입력해주세요.");
	        document.getElementById('userId').focus();
	        return;
	    } else if(!idChecked) {
	    	alert("아이디 중복확인을 완료해주세요.");
	    	return;
	    } else if (userName == "") {
	        alert("이름을 입력해주세요.");
	        document.getElementById('userName').focus();
	        return;
	    } else if (nick == "") {
	        alert("닉네임을 입력해주세요.");
	        document.getElementById('nick').focus();
	        return;
	    } else if (tel == "") {
	        alert("전화번호를 입력해주세요.");
	        document.getElementById('tel').focus();
	        return;
	    } else if (sample6_postcode == "") {
	        alert("주소를 입력해주세요.");
	        document.getElementById('sample6_postcode').focus();
	        return;
	    } else if(pw != pwCk) {
	    	alert("비밀번호를 확인해주세요.")
	        document.getElementById('pw').focus();
	    	return;
	    } else if(acornPw != acornPwCk) {
	    	alert("2차 비밀번호를 확인해주세요.")
	        document.getElementById('acornPw').focus();
	    	return;
	    }

		$.ajax({
			type : "POST"
			, url : path + "/signup.do"
			, contentType : "application/json"
			, data : JSON.stringify(userInfo)
			, success : function (data) {
				if ("T" != data) {
					alert("회원가입을 실패하였습니다. 다시 확인해주세요.");
				} else {
					var link = '/login.do';
					window.location.replace(link);
				}
			}
		})
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