<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../../layout/global.jsp"%>
</head>
<script>
var me;
$(function(){
	getMe();
	$("#submit").on("click", function(){
		if($("#password").val()==""){
			alert("enter your password");
			$("#password").focus();
			return false;
		}
		if(!confirmPassword()) return;
		if(!checkPassword()) return;
		editUser();
	});
})
function getMe(){
	$.ajax({
		url: "<c:url value='/api/users/me'/>",
		method: "get",
		async: false,
		success: function(data){
			me = data;
		},
		error: function(err){
			console.log(err);
		}
	})
}
function confirmPassword(){
	if($('#newPassword').val() != $('#newPassword2').val()){
		alert('please check new password');
		return false;
	}
	return true;
}

function checkPassword(){
	var result;
	$.ajax({
		url: "<c:url value='/api/users/check-password'/>",
		type: "post",
		async: false,
		data: {
			userId : ${sessionScope.loginUser.userId},
			password : $("#password").val()
		},
		success: function(result){
			if(!result) alert("please try again");
			return result;
		},
		error: function(err){
			console.log(err);
			result = false;
		}
	})
	return result;
}

function editUser(){
	console.log("asdf");
	$.ajax({
		url: "<c:url value='/api/users/'/>"+me.userId,
		type: "patch",
		contentType: "application/json",
		data: JSON.stringify({
			password : $("#newPassword").val()
		}),
		success: function(data){
			location.href="<c:url value='/users/mypage/profile'/>";
		},
		error: function(err){
			console.log(err);
		}
	})
}
</script>

<body>
<%@ include file="../../layout/header.jsp"%>
<main>
<%@ include file="./layout/style.jsp"%>
<div id = "contentsWrap">
	<section>
	<h2>Edit Password</h2><hr>
	<div class="box">
		<div class="item">
			<div class="title">Enter old password</div> 
			<div class="value"><input type="password" id="password" name="password"></div>
		</div>
		<div class="item">
			<div class="title">Enter new password</div>
			<div class="value"><input type="password" id="newPassword" name="newPassword"></div>
		</div>
		<div class="item">
			<div class="title">Re-enter new password</div>
			<div class="value"><input type="password" id="newPassword2" name="newPassword"></div>
		</div>
		<div class="item">
			<button class="btn btn-primary btn-block" id="submit">edit</button>
		</div>
	</div>
	</section>
</div>
</main>
<%@ include file="../../layout/footer.jsp"%>
</body>
</html>