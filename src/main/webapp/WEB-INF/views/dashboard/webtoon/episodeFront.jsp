<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<script>
$(document).ready(function() {
	$('#insert').on('click', insertEpisode);
	myEpisodeList();
	console.log(lastNo);
});
var lastNo;
var images = [];
var index = 1;
var imageTypes = [ 'image/png', 'image/gif', 'image/jpeg', 'image/bmp',
		'image/x-icon' ];
var thumbnailPath;
$(function() {
	$("#uploadInput").on("change", function() {
		uploadImage(this.files[0]);
	})
})
function myEpisodeList(){
	$.ajax({
		url: "<c:url value ='../../api/webtoons/${webtoonId}/episodes'/>", // core/webtoons
		type: "GET",
		async:false,
		success: function(data){
			output(data);
			lastNo = data.length;
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
	var template=$('#myEpisodeList');
	bindTemplates(template, data);
}

function insertEpisode(){
	console.log(lastNo)
	var url = "/core/api/webtoons/${webtoonId}/episodes/"+lastNo+"/insert";
	console.log("url: " + url);
	$.ajax({
		url: url, // core/webtoons
		type: "POST",
		data:{
			no : 0
			,title : "def"
			,webtoon_id : ${webtoonId}
			,thumbnail : "def"
		},
		success: function(data){
			console.log(data);
			location.href="<c:url value='/dashboard/webtoons/${webtoonId}/episodes/'/>"+lastNo+"/insert"
		},		
		error: function(data){
			console.log("err", data);
		},
		complete: function(){
			console.log("complete");
		}
	})
}
function deleteEpisode(no){
	$.ajax({
		url : "<c:url value ='../../../api/webtoons/${webtoonId}/episodes/'/>"+no,
		method : "delete",
		success : function(){
			location.href = "<c:url value='../../dashboard/webtoons/{webtoonId}/episodes'/>"
		},
		error : function(data){
			console.log("err", data)
		}
	})
	
}
function updateEpisode(webtoonId){
	location.href = "<c:url value='/dashboard/webtoons/"+webtoonId+"/update'/>"
}
</script>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/nav.jsp"%>
<main>
<input type = "button" class="btn btn-primary" id = "insert" value ="에피소드등록">
${webtoonId}
<div id = "episodeList">
</div>
<table>
	<tr>
		<th>
			NO
		</th>
		<th>
			Title
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
	<script id="myEpisodeList">
	<tr onclick = "location.href = '../dashboard/webtoons/{{webtoonId}}'">
		<td>
			{{no}}
		</td>
		<td>
			{{title}}
		</td>
		<td>
			<img src = "{{thumbnail}}" width = "100px">
		</td>
		<td>
			<input type = "button" value = "삭제" id = "deleteEpisode" onclick="deleteEpisode({{no}})">
		</td>
		<td>
			<input type = "button" value = "수정" id = "updateEpisode" onclick="updateEpisode({{no}})">
		</td>
	</tr>
	</script>
</table>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>