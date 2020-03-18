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

</script>

<body>
<h1>user</h1>
<hr>
	<h2>Sign up</h2>
	<h3>Using your current email address</h3>
	<form action="/users/join" method="post" id="joinForm">
		<div class="form-group">
			<input class="form-control" type="text" id="userEmail" name="userEmail" placeholder="Email Address"/>
			<button class="btn btn-default" type="button" id="emailCheck" value="N">check email</button>
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
			<input class="form-control" type="radio" value="M" id="userGender" name="userGender"/>Male
			<input class="form-control" type="radio" value="F" id="userGender" name="userGender"/>Female
			<input class="form-control" type="radio" value="none" id="userGender" name="userGender"/>I prefer not to answer
		</div>
		<div class="form-group">
			<button class="btn btn-primary" type="button" id="login">Sign up</button>
		</div>
		
	</form>
<hr>
	<h2>Sign in</h2>
	<h3>Using your niconicomics account!</h3>
	
</body>

</html>