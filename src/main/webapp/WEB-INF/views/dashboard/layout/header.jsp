<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
$(function(){
	getHeaderMe();
});
function getHeaderMe(){
	$.ajax({
		url: "<c:url value='/api/users/me'/>",
		method: "get",
		async: false,
		success: function(data){
			$("#user_id").html(data.nickname);
			console.log(data);
		},
		error: function(err){
			console.log(err);
		}
	})
}
function logout(){
	$.ajax({
		url: "<c:url value='/api/users/logout'/>",
		method: "get",
		success: function(){
			me = null;
			location.href = "<c:url value='/'/>"			
		},
		error: function(err){
			console.log(err);
		}
	})
}
</script>
<header>
<div class="header_wrap">
	<div class="header_title" onclick="location.href='<c:url value="/"/>'">ニコニコニコニコミクス</div>
	<div class="header_right"><span id="user_id" style="font-weight: bold;"></span> | <a onclick="logout()" href="#" style="color: white; text-decoration: none;"><i class="fas fa-sign-out-alt"></i> Sign Out</a></div>
</div>
</header>