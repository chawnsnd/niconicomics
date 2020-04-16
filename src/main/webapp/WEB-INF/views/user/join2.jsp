<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>send email for authorizing</title>
<%@ include file="../layout/global.jsp"%>

</head>

<script>

$(document).ready(function(){
	$("#checkRandom").on("click",function(){
		fn_sendEmail();
	})

})

function fn_sendEmail(){
	$.ajax({
		url : "<c:url value='/api/users/join2'/>",
		type: "post",
		data : {
			random: $("#random").val()
		},
		success : function(data){
			if(data){
				alert("회원가입이 완료되었습니다.");
				location.href = "<c:url value='/'/>";
			}else{
				alert("인증번호를 확인해주세요.")
			}
		}
		,
		error: function(data){
			alert("에러가 발생했습니다.");
			return false;
		}
	})
}

</script>

<body>
<%@ include file="../layout/header.jsp"%>
<main>
	
	<div>Please verify your email</div>
	<br>
	<div>
	You're almost there! We sent an email to ${sessionScope.loginUser.email}<br>
	Just click on the link in that email to complete your signup.<br>
	if you don't see it, you may need to check your spam folder.<br>
	Still, can't find the email?
	</div>
	<div class="form-group">
		<input type="text" id="random" />
		<button class="btn btn-primary" type="button" id="checkRandom">check</button>
	</div>
	

</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>