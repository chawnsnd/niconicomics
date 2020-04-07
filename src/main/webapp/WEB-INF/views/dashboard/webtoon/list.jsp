<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<script>
$(document).ready(function() {
	$('#insert').on('click', insertWebtoons);
	myWebtoons();
});
function insertWebtoons(){
	$.ajax({
		url: "../api/webtoons", // core/webtoons
		type: "POST",
		data:{
			title : "def"
			,summary : "def"
			,hashtag : "def"
			,mgrHashtag : "def"
			,thumbnail : "def"
		},
		success: function(){
			location.href="<c:url value='/dashboard/webtoons/insert'/>"
		},
		error: function(data){
			console.log("err", data);
		}
// 		,complete: function(){
// 			console.log("complete");
// 		}
	})
}
function deleteWebtoons(webtoonId){
	$.ajax({
		url : "../api/webtoons/"+webtoonId,
		method : "delete",
		success : function(){
			location.href = "<c:url value='../dashboard/webtoons'/>"
		},
		error : function(data){
			console.log("err", data)
		}
	})
	
}
function updateWebtoons(webtoonId){
	location.href = "<c:url value='/dashboard/webtoons/"+webtoonId+"/update'/>"
}
function myWebtoons(){
	$.ajax({
		url: "../api/webtoons", // core/webtoons
		type: "GET",
		data:{
			authorId : "${sessionScope.loginUser.userId}" 
		},
		success: function(data){
			console.log(data);
			output(data);
		},
		error: function(data){
			console.log("err", data);
		},
		complete: function(){
			console.log("complete");
		}
	})
}
function output(data){
	var template = $('#myWebtoonList');
	bindTemplates(template, data)
}
</script>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/nav.jsp"%>
<main>
<input type = "button" class="btn btn-primary" id = "insert" value ="웹툰등록">
<div id = "webtoonList">
</div>
<table>
	<tr>
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
			Thumbnail
		</th>
		<th>
			Delete
		</th>
		<th>
			Update
		</th>
	</tr>
	<script id="myWebtoonList">
	<tr onclick = "location.href = '../dashboard/webtoons/{{webtoonId}}'">
		<td>
			{{title}}
		</td>
		<td>
			{{summary}}
		</td>
		<td>
			{{hashtag}}
		</td>
		<td>
			<img src = "{{thumbnail}}" width = "100px">
		</td>
		<td>
			<input type = "button" value = "삭제" id = "deleteWebtoon" onclick="deleteWebtoons({{webtoonId}})">
		</td>
		<td>
			<input type = "button" value = "수정" id = "updateWebtoon" onclick="updateWebtoons({{webtoonId}})">
		</td>
	</tr>
	</script>
</table>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>