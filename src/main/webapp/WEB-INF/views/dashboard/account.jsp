<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="./layout/global.jsp"%>
<script>
$(function(){
	getAccount();
})
function getAccount(){
	$.ajax({
		url: "../account/${sessionScope.loginUser.userId}",
		type: "get",
		success: function(data){
			console.log(data);
		},
		error: function(data){
		}
	})
}
</script>
</head>
<body>
<%@ include file="./layout/header.jsp"%>
<%@ include file="./layout/nav.jsp"%>
<main>
<div>
	<div>등록된 계좌정보가 없습니다.</div>
	<button class="btn btn-primary" onclick="location.href='enroll-account'">계좌정보 추가</button>
</div>
</main>
<%@ include file="./layout/footer.jsp"%>
</body>
</html>