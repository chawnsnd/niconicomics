<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<%@ include file="../../layout/global.jsp"%>
</head>
<script>
$(function(){
	getMe();
	$("#submit").on("click", function(){
		editUser();
	});
})

function getMe(){
	$.ajax({
		url: "<c:url value='/api/users/${sessionScope.loginUser.userId}'/>",
		type: "get",
		success: function(data){
			bindTemplate($("#userTemplate"), data);
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

<script id="userTemplate" type="text/x-handlebars-template">
	<form id="editUserForm">
		email: {{email}}<br>
		nickname: <input type="text" id="nickname" name="nickname" value={{nickname}}><br>
	</form>
</script>
<button id="submit">submit</button>

</main>
<%@ include file="../../layout/footer.jsp"%>
</body>
</html>