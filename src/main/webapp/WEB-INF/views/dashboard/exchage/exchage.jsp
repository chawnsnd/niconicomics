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
$(function(){
	$.ajax({
		url: "<c:url value='/users/api/users/me'/>",
		method: "get",
		success: function(data){
			console.log(data);
			bindTemplate($("#nicoTemplate"), data);
		},
		error: function(err){
			console.log(err);
		}
	})
})
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
			bindTemplate($("#nicoTemplate"), data);
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
<script id="nicoTemplate">
	<div class='nico'>
		<b>Charged Nico</b><span>{{nico}}</span>
	</div>
</script>
<div class="exchage">
<b>Exchage</b> <input type="number" id="exchageNico">
<button class="btn btn-primary" onclick="exchage()">exchange</button>
</div>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>