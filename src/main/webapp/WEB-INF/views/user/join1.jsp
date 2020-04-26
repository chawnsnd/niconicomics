<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
</head>

<script>
$(document).ready(function(){

	$(".cancel").on("click", function(){
		location.href = "<c:url value='/users/join'/>";
	})

	$("#submit").on("click", function(){
		if($("#userEmail").val()==""){
			alert("enter your Email");
			$("#userEmail").focus();
			return false;
		}
		if($("#userPassword").val()==""){
			alert("enter your password");
			$("#userPassword").focus();
			return false;
		}
		if($("#userNickname").val()==""){
			alert("enter your nickname");
			$("#userNickname").focus();
			return false;
		}
		
		var emailCheckValue = $("#checkEmail").val();
		if(emailCheckValue == "N"){
			alert("press the email-check button");
		}else if(emailCheckValue == "Y"){
			join1();
		}

	});

})

function join1(){
	$("#submit").html('<div class="spinner-border" role="status">'+
	  		  '<span class="sr-only">Loading...</span>'+
	  			'</div>');
	$("#submit").attr("disabled", "disabled");
	$.ajax({
		url: "<c:url value='/api/users/join1'/>",
		type: "post",
		data: {
			email : $("#userEmail").val()
			, password : $("#userPassword").val()
			, nickname : $("#userNickname").val()
			, birthdate : $("#userBirthdate").val()
			, gender : $(".userGender:checked").val()
			, type : $(".userType:checked").val()
		},
		success: function(data){
			if(data){
				location.href = "<c:url value='/users/join2'/>";
			}else{
				alert("Fail");
				$("#submit").html('Submit');
				$("#submit").removeAttr("disabled", "disabled");
			}
		},
		error: function(error){
			console.log(error);
		}
	})
}

function checkEmail(){
	$.ajax({
		url: "<c:url value='/api/users/check-email'/>",
		type: "post",
		data: {email : $("#userEmail").val()},
		success: function(result){
			if(result){
				$("#checkEmail").attr("value", "Y");
				alert("This Email is available.");
			}else{
				alert("Email already exists. Please choose another account.");
				$("#userEmail").val('');
				$("#userEmail").focus();
			}
		},
		error: function(err){
			console.log(err);
		}
	})
}
function loginKakao(){
	location.href = 
	"https://kauth.kakao.com/oauth/authorize"+
	"?client_id=e8d019946e7e473b418a83659e5b38dc"+
	"&redirect_uri=http://203.233.199.118/users/kakao-login"+
	"&response_type=code";
}
function loginNaver(){
	location.href = 
	"https://nid.naver.com/oauth2.0/authorize"+
	"?response_type=code"+
	"&client_id=DAo5utEZEh2u7jRDH9lv"+
	"&redirect_uri=http://203.233.199.118/users/naver-login"+
	"&state=niconicomics"
}
</script>
<style>
main{
	width: 500px;
}
.btn-group{
	wdith: 100%;
}
</style>
<body>
<%@ include file="../layout/header.jsp"%>
<main>
	<h2>Sign up</h2>
		<div class="form-group">
		<div class="input-group-prepend">
			<input class="form-control" type="text" id="userEmail" name="userEmail" placeholder="Email Address"/>
			<button class="btn btn-default" type="button" id="checkEmail" onclick="checkEmail();" value="N">check</button>
		</div>
		</div>
		<div class="form-group">
			<input class="form-control" type="password" id="userPassword" name="usertPassword" placeholder="Password"/>
		</div>
		<div class="form-group">
			<input class="form-control" type="text" id="userNickname" name="userNickname" placeholder="Nickname"/>
		</div>
		<div class="form-group">
			<input class="form-control" type="date" id="userBirthdate" name="userBirthdate" placeholder="Birthday"/>
		</div>
		<div class="form-group">
			Gender<br>
			<input class="userGender" type="radio" value="MALE" name="userGender"/>Male
			<input class="userGender" type="radio" value="FEMALE" name="userGender"/>Female
			<input class="userGender" type="radio" value="NONE" name="userGender" checked="checked"/>I prefer not to answer
		</div>
		<div class="form-group">
			Type<br>
			<input class="userType" type="radio" value="GENERAL" name="userType" checked="checked"/>General
			<input class="userType" type="radio" value="AUTHOR" name="userType"/>Author
		</div>
		<div class="form-group">
			<button class="btn btn-primary btn-block" type="button" id="submit">Sign up</button>
		</div>
		<hr>
		<a onclick="loginKakao()"><img src="<c:url value='/resources/images/kakao_login_button.png'/>" style="width: 100%; height: 60px; cursor: pointer;"></a>
		<a onclick="loginNaver()"><img src="<c:url value='/resources/images/naver_login_button.png'/>" style="width: 100%; height: 60px; cursor: pointer;"></a>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>