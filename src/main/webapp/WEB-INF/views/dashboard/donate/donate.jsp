<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<script>
$(function(){
	getDonateList();
})
function getDonateList(){
	$.ajax({
		url: "<c:url value='/api/donates'/>",
		method: "get",
		data: {
			authorId : ${sessionScope.loginUser.userId},
		},
		success: function(data){
			console.log(data);
			bindTemplate($("#donateListTemplate"), data);
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
<h2>Donate</h2><hr>
<script id="donateListTemplate" type="text/x-handlebars-template">
<div id="donate" class="card">
	<table class="table">
		<tr>
			<th>Sponsor</th>
			<th>Nico</th>
			<th>Donate date</th>
		</tr>
		{{#each .}}
		<tr>
			<td>{{sponserNickname}}</td>
			<td>{{nico}} Nico</td>
			<td>{{donateDate}}</td>
		</tr>
		{{/each}}
	</table>
</div>
</script>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>