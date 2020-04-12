<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<%@ include file="../../layout/global.jsp"%>
<script>

$(function(){
	getMe();
})
function getMe(){
	$.ajax({
		url: "<c:url value='/api/users/me'/>",
		type: "get",
		success: function(data){
			bindTemplate($("#userTemplate"), data);
		},
		error: function(err){
			console.log(err)
		}
	})
}
</script>
</head>
<body>
<%@ include file="../../layout/header.jsp"%>

<main>
<%@ include file="./layout/style.jsp"%>

	<div id = "contentsWrap">
	<section>
		<h2>Profile</h2><hr>
		<script id="userTemplate" type="text/x-handlebars-template">
		<div class="box">
			<div class="item">
				<div class="title">User Email</div>			
				<div class="value">{{email}}</div>
			</div>
			<div class="item">		
				<div class="title">User Nickname</div>			
				<div class="value">{{nickname}}</div>
			</div>
			<div class="item">
				<div class="title">Birthday</div>
				<div class="value">{{birthdate}}</div>
			</div>
			<div class="item">
				<div class="title">Type</div>
				<div class="value">{{type}}</div>
			</div>
			<div class="item">
				<div class="title">Dotple Setting</div>
				<div class="value">{{showDotple}}</div>
			</div>
			<div class="item">
				<div class="title">Chat Setting</div>
				<div class="value">{{showChat}}</div>
			</div>
			<div class="item">
				<div class="title">Nico</div>
				<div class="value">{{nico}} Nico</div>
			</div>
		</div>
		</script>
	</section>
	</div>
</main>
<%@ include file="../../layout/footer.jsp"%>
</body>
</html>