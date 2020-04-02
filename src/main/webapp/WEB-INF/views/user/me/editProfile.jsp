<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Information</title>
<%@ include file="../../layout/global.jsp"%>

</head>

<script>
$(function(){
	$("#submit").on("click", function(){
		if($("#password").val()==""){
			alert("enter your password");
			$("#password").focus();
			return false;
		}

		confirmPassword();
		checkPassword();

		editUser();
		});
})

function confirmPassword(){
	$('#newPassword2').blur(function(){
		if($('#newPassword').val() != $('#newPassword2').val()){
			if($('#newPassword2').val() != ''){
				alert('비밀번호가 일치하지 않습니다');
				$('#newPassword2').focus();
				}
			}
		})
}

function checkPassword(){
	$.ajax({
		url: "./check-password",
		type: "post",
		data: {
			userId : ${sessionScope.loginUser.userId}
			,password : $("#password").val()
		},
		success: function(data){
			if(data=='yes'){
				alert('비밀번호 확인 완료');
			}else{
				alert("please try again");
				$("#nickname").val("");
				$("#password").val("");
				$("#newPassword").val("");
				$("#checkNewPassword").val("");
			}
		},
		error: function(error){console.log(error);}
	})
}

function editUser(){
	$.ajax({
		url: "./edit-profile",
		type: "post",
		data: {
			userId : ${sessionScope.loginUser.userId}
			,nickname : $("#nickname").val()
			,password : $("#newPassword").val()
		},
		success: function(data){
			if(data=='yes'){
				location.href="<c:url value='/'/>";
				alert("회원정보 수정 완료");
			}else{
				alert("please try again");
			}
		},
		error: function(error){console.log(error);}
	})
}
</script>

<body>
<%@ include file="../../layout/header.jsp"%>
<main>
<%@ include file="./layout/style.jsp"%>

<div class="tempalte" id="formTemplate">
	<form id="editUserForm">
		email: <input type="text" id="email" name="email" value="${sessionScope.loginUser.email}" readonly="readonly"><br>
		nickname: <input type="text" id="nickname" name="nickname"><br>
		password: <input type="text" id="password" name="password" required="required"><br>
		enter new password: <input type="text" id="newPassword" name="newPassword"><br>
		re-enter new password: <input type="text" id="newPassword" name="newPassword2"><br>
	</form>
</div>
<button id="submit">submit</button>

</main>
<%@ include file="../../layout/footer.jsp"%>
</body>
</html>