<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../layout/global.jsp"%>
</head>

<script>
$(document).ready(function(){
	$("#login").on("click", function(){
		var email = $("#userEmail").val();
        var password = $("#userPassword").val();

        if (email == "") {
            alert("enter your email");
            $("#userEmail").focus();
            return;
        }
        if (password == "") {
            alert("enter your password");
            $("#userPassword").focus();
            return;
        }

		login();
	})
	$("#userPassword").on("keyup", function(e){
		if(e.keyCode == 13){
			$("#login").trigger("click");
		}
	})
})

function login(){
	$.ajax({
		url: "<c:url value='/api/users/login'/>",
		type: "post",
		data: {
			email : $("#userEmail").val(),
			password : $("#userPassword").val()
		},
		success: function(result){
			if(result){
				location.href="<c:url value='/'/>"
			}else{
				alert("please try again");
			}
		},
		error: function(err){
			console.log(err);
		}
	})
	
}

</script>
<style>
main{
	width: 500px;
}
</style>
<body>
<%@ include file="../layout/header.jsp"%>
<main>
	<h2>Sign in</h2>
	<form action="/users/login" method="post" id="loginForm">
		<div class="form-group">
			<input type="text" class="form-control" id="userEmail" placeholder="enter your Email">
		</div>
		<div class="form-group">
			<input type="password" class="form-control" id="userPassword" placeholder="enter your password">
		</div>
		<div class="form-group">
			<button type="button" class="btn btn-primary btn-block" id="login">sign in</button>
		</div>
	</form>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>