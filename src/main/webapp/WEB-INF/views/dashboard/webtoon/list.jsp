<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<script>
$(document).ready(function() {
	$('#insert').on('click', insertWebtoon);
	getWebtoons(1);
});

function insertWebtoon(){
	location.href="<c:url value='/dashboard/webtoons/insert'/>"
}

function deleteWebtoon(webtoonId){
	$.ajax({
		url : "<c:url value='/api/webtoons/'/>"+webtoonId,
		method : "delete",
		success : function(){
			location.reload();
		},
		error : function(err){
			console.log(err)
		}
	})
}

function updateWebtoon(webtoonId){
	location.href = "<c:url value='/dashboard/webtoons/"+webtoonId+"/update'/>"
}

function getWebtoons(curPage){
	$.ajax({
		url: "<c:url value='/api/webtoons'/>", // core/webtoons
		type: "GET",
		data:{
			authorId : "${sessionScope.loginUser.userId}"
		},
		success: function(data){
			console.log(data)
			bindTemplate($('#webtoonListTemplate'), data.webtoonList);
			imageContainer();
		},
		error: function(err){
			console.log(err);
		}
	})
}
</script>
<style>
.thumbnail{
	width: 80px;
	height: 50px;
}
</style>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/nav.jsp"%>
<main>
<h2>Webtoon</h2><hr>
<div class="card">
	<div class="card-body">
		<p class="card-title">
			<input type = "button" class="btn btn-primary" id = "insert" value ="Enroll Webtoon">
		</p>
		<script id="webtoonListTemplate" type="text/x-handlebars-template">
		<table class="table">
			<tr>
				<th>
					Thumbnail
				</th>
				<th width="70%">
					Title
				</th>
				<th>
					Reg Date
				</th>
			</tr>
			{{#each .}}
			<tr onclick = "location.href = '../dashboard/webtoons/{{webtoonId}}'">
				<td>
					<div class="thumbnail image_container">
						<img src = "{{thumbnail}}">
					</div>
				</td>
				<td>
					{{title}}
				</td>
				<td>
					{{regDate}}
				</td>
			</tr>
			{{/each}}
		</table>
		</script>
	</div>
</div>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>