<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작가 대시보드</title>
<%@ include file="../layout/global.jsp"%>
<script>
var me;
$(function(){
	getMe();
})
function getMe(){
	$.ajax({
		url: "<c:url value='/api/users/me'/>",
		method: "get",
		async: false,
		success: function(data){
			me = data;
			$("#exchage").remove();
			bindTemplate($("#exchangeTemplate"), data);
		},
		error: function(err){
			console.log(err);
		}
	})	
}
function exchage(){
	$.ajax({
		url: "<c:url value='/api/nico/exchage'/>",
		method: "post",
		data: {
			userId : ${sessionScope.loginUser.userId},
			nico : $("#exchageNico").val()
		},
		success: function(data){
			console.log(data);
			getMe();
		},
		error: function(err){
			console.log(err);
		}
	})
}
</script>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/nav.jsp"%>
<main>
<h2>Exchage</h2><hr>
<script id="exchangeTemplate" type="text/x-handlebars-template">
<div id="exchage">
	<div class="box">
		<div class="item">
			<div class="title">Charged Nico</div>
			<div class="value">{{nico}} Nico</div>
		</div>
		<div class="item">
			<div class="title">Exchage</div>
			<div class="value"><input type="number" id="exchageNico"></div>
		</div>
		<div class="item">
			<button class="btn btn-primary btn-block" onclick="exchage()">exchange</button>		
		</div>
	</div>
</div>
</script>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>