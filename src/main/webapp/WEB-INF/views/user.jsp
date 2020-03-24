<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>user test</title>
</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
$(document).ready(function(){

	$(".cancel").on("click", function(){
		location.href = "./test";
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
			alert("enter your name");
			$("#userNickname").focus();
			return false;
		}
		/*
		var emailCheckValue = $("#emailCheck").val();
		if(emailCheckValue == "N"){
			alert("press the email-check button");
		}else if(emailCheckValue == "Y"){
			$("#regForm").submit();
		}
		*/
	});

})

function fn_checkEmail(){
	$.ajax({
		url: "./check-email",
		type: "post",
		dataType: "json",
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
		error: function(error){alert(error);
			console.log($("#userEmail").val());
		}
	})
}

</script>

<body>
<h1>user</h1>
<hr>
	<h2>Sign up</h2>
	<h3>Using your current email address</h3>
	<form action="/users/join" method="post" id="joinForm">
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
			<input class="form-control" type="text" id="userBirthdate" name="userBirthdate" placeholder="Birthday"/>
		</div>
		<div class="form-group">
			Gender<br>
			<input class="form-control" type="radio" value="M" name="userGender"/>Male
			<input class="form-control" type="radio" value="F" name="userGender"/>Female
			<input class="form-control" type="radio" value="none" name="userGender"/>I prefer not to answer
		</div>
		<div class="form-group">
			<button class="btn btn-primary" type="button" id="submit">Sign up</button>
			<button class="cancel btn btn-danger" type="button">Cancel</button>
		</div>
		
	</form>
<hr>
	<h2>Sign in</h2>
	<h3>Using your niconicomics account!</h3>
	<form action="/users/login" method="post" id="loginForm">
		<div class="form-group">
			<ul>
				<li class="active"><a data-toggle="tab" href="#logIn">Sign up</a>
			</ul>
			<div class="tab-content">
				<div id="logIn" class="tab-pane fade in active">
					<input type="text" class="form-control" id="email" placeholder="enter your Email">
				</div>
			</div>
		</div>
		<div class="form-group">
			<input type="password" class="form-control" id="password" placeholder="enter your password">
		</div>
		<div class="form-group">
			<button type="button" class="btn btn-pimary btn-block" id="login">sign up</button>
		</div>
	</form>
</body>

</html>