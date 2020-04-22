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
$(function(){
	getMe();
})
function getMe(){
	$.ajax({
		url: "<c:url value='/api/users/${sessionScope.loginUser.userId}'/>",
		type: "get",
		success: function(data){
			bindTemplate($("#userTemplate"), data);
			$("#submit").on("click", function(){
				editUser();
			});
		},
		error: function(err){
			console.log(err)
		}
	})
}

function editUser(){
	$.ajax({
		url: "<c:url value='/api/users/${sessionScope.loginUser.userId}'/>",
		type: "patch",
		contentType: "application/json",
		data: JSON.stringify({
			nickname : $("#nickname").val()
		}),
		success: function(){
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
	<h2>Edit Profile</h2><hr>
<script id="userTemplate" type="text/x-handlebars-template">
	<div class="box">
		<div class="item">
			<div class="title">Email</div>
			<div class="value">{{email}}</div>
		</div>
		<div class="item">
			<div class="title">Nickname</div>
			<div class="value"><input type="text" id="nickname" name="nickname" value={{nickname}}></div>
		</div>
		<div class="item">
			<button id="submit" class="btn btn-primary btn-block">edit</button>
		</div>
</script>
	</section>
</div>
</main>
<%@ include file="../../layout/footer.jsp"%>
</body>
</html>