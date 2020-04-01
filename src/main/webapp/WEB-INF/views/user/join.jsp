<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>sign up for uniconicomics</title>
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
	$.ajax({
		url: "./join1",
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
			console.log(data);
			if(data){
				location.href = "<c:url value='/users/join2'/>";
			}else{
				alert("Fail")
			}
		},
		error: function(error){console.log(error);
		}
	})
}

function fn_checkEmail(){
	$.ajax({
		url: "./check-email",
		type: "post",
		dataType: "text",
		data: {email : $("#userEmail").val()},
		success: function(data){
			if(data == 'yes'){
				$("#checkEmail").attr("value", "Y");
				alert("This Email is available.");
			}else{
				alert("Email already exists. Please choose another account.");
				$("#userEmail").val('');
				$("#userEmail").focus();
			}
		},
		error: function(error){console.log(error);}
	})
}
</script>

<body>
<%@ include file="../layout/header.jsp"%>
<main>
<h1>user</h1>
<hr>
	<h2>Sign up</h2>
	<h3>Using your current email address</h3>
		<div class="form-group">
			<input class="form-control" type="text" id="userEmail" name="userEmail" placeholder="Email Address"/>
			<button class="btn btn-default" type="button" id="checkEmail" onclick="fn_checkEmail();" value="N">check email</button>
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
			<button class="btn btn-primary" type="button" id="submit">Sign up</button>
			<button class="cancel btn btn-danger" type="button">Cancel</button>
		</div>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>