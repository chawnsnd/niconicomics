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
function getMe(){
	$.ajax({
		url: "/api/users/me",
		method: "get",
		success: function(user){
			//data -> 나라는 사람의 유저정보
			user
		},
		error: function(err){
			console.log(err);
		}
	})
}
function getUser(){
	$.ajax({
		url: "/api/users/"+${sessionScope.loginUser.userId},
		method: "get",
		success: function(user){
			//data -> 나라는 사람의 유저정보
			user
		},
		error: function(err){
			console.log(err);
		}
	})
}
/*
$(function(){
	getUser();
})
function getUser(){
	$.ajax({
		url: "../me/profile",
		type: "get",
		success: function(data){
			console.log(data);
		},
		error: function(err){
			console.log(err);
		}
	})	
}
*/
</script>
<style>
.box{
	border: 1px solid #a3a3a3;
	display: inline-block;
	box-shadow: 3px 3px 5px 0px #6c757d;
	padding: 10px;
	width: 420px;
	position: relative;
}
.title{
	width: 120px;
	font-weight: bold;
}
.item > div{
	display: inline-block;
}
</style>
</head>

<body>
<%@ include file="../../layout/header.jsp"%>

<main>
<%@ include file="./layout/style.jsp"%>

	<div id = "contentsWrap">
	<section>
		<div class="box">
			<div class="item">
				<div class="title">User Email</div>			
				<div class="value">${sessionScope.loginUser.email}</div>
			</div>
			<div class="item">		
				<div class="title">User Nickname</div>			
				<div class="value">${sessionScope.loginUser.nickname}</div>
			</div>
			<div class="item">
				<div class="title">Birthday</div>
				<div class="value">${sessionScope.loginUser.birthdate}</div>
			</div>
		</div>
	</section>
	</div>
</main>
<%@ include file="../../layout/footer.jsp"%>
</body>
</html>