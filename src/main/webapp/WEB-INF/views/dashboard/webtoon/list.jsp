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
			authorId : "${sessionScope.loginUser.userId}",
			currentPage : curPage,
			countPerPage : 10
		},
		success: function(data){
			console.log(data);
			var template = $('#myWebtoonListTemplate');
			bindTemplate(template, data.webtoonList);
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
<input type = "button" class="btn btn-primary" id = "insert" value ="웹툰등록">
<table>
	<tr>
		<th>
			Thumbnail
		</th>
		<th>
			Title
		</th>
		<th>
			Summary
		</th>
		<th>
			Hashtag
		</th>

		<th>
			Delete
		</th>
		<th>
			Update
		</th>
	</tr>
	<script id="myWebtoonListTemplate" type="text/x-handlebars-template">
	{{#each .}}
	<tr>
		<td onclick = "location.href = '../dashboard/webtoons/{{webtoonId}}'">
			<img src = "{{thumbnail}}" width = "100px">
		</td>
		<td onclick = "location.href = '../dashboard/webtoons/{{webtoonId}}'">
			{{title}}
		</td>
		<td onclick = "location.href = '../dashboard/webtoons/{{webtoonId}}'">
			{{summary}}
		</td>
		<td onclick = "location.href = '../dashboard/webtoons/{{webtoonId}}'">
			{{hashtag}}
		</td>
		<td>
			<input type = "button" value = "삭제" id = "deleteWebtoon" onclick="deleteWebtoon({{webtoonId}})">
		</td>
		<td>
			<input type = "button" value = "수정" id = "updateWebtoon" onclick="updateWebtoon({{webtoonId}})">
		</td>
	</tr>
	{{/each}}
	</script>
</table>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>