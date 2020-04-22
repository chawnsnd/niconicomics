<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	changeType();
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
function changeType(){
	if(me.type === "AUTHOR"){
		alert("already author");
		location.href="<c:url value='/users/mypage/profile'/>";
		return;
	}
	$.ajax({
		url: "<c:url value='/api/users/'/>"+me.userId,
		type: "patch",
		contentType: "application/json",
		data: JSON.stringify({
			type: "AUTHOR"
		}),
		success: function(){
			location.href="<c:url value='/users/mypage/profile'/>";
		},
		error: function(err){
			console.log(err)
		}
	})
}

</script>

<body>
<%@ include file="../../layout/header.jsp"%>
<main>
<%@ include file="./layout/style.jsp"%>

</main>

</body>
</html>