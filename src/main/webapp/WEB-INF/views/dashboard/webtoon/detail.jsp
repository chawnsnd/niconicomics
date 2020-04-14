<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<script>
var episodes = [];

$(document).ready(function() {
	$('#insert').on('click', insertEpisode);
	getWebtoon();
	getEpisodes();
});

function getWebtoon(){
	$.ajax({
		url: "<c:url value='/api/webtoons/${webtoonId}'/>", // core/webtoons
		type: "GET",
		data:{
			authorId : "${sessionScope.loginUser.userId}"
		},
		success: function(data){
			console.log(data)
			data["hashtags"] = splitHashtag(data.hastag);
			console.log(data)
			bindTemplate($('#webtoonTemplate'), data);
			imageContainer();
		},
		error: function(err){
			console.log(err);
		}
	})
}

function insertEpisode(){
	console.log(episodes);
	var maxNo;
	if (episodes.length == 0) maxNo = 0;
	else{
		var maxNo = episodes.reduce(function(prev, curr){
			return prev.no > curr.no ? prev : curr;
		}).no;
	}
	location.href="<c:url value='/dashboard/webtoons/${webtoonId}/episodes/"+(maxNo+1)+"/insert'/>"
}

function deleteEpisode(episodeNo){
	$.ajax({
		url : "<c:url value='/api/webtoons/${webtoonId}/episodes/'/>"+episodeNo,
		method : "delete",
		success : function(){
			location.reload();
		},
		error : function(err){
			console.log(err)
		}
	})
}

function updateEpisode(episodeNo){
	location.href = "<c:url value='/dashboard/webtoons/${webtoonId}/episodes/"+episodeNo+"/update'/>"
}

function getEpisodes(){
	$.ajax({
		url: "<c:url value='/api/webtoons/${webtoonId}/episodes'/>",
		type: "GET",
		async: false,
		success: function(data){
			var template = $('#myEpisodeListTemplate');
			bindTemplate(template, data);
			episodes = data;
		},
		error: function(err){
			console.log(err);
		}
	})
}
function splitHashtag(hashtags){
	var hashtagArr = hashtags.split("#");
	$(hashtagArr).each(function(idx, hashtag){
		hashtag = "#"+hashtag;
	})
	return hashtag
}
</script>
<style>
#webtoon_thumbnail{
	width: 150px;
	height: 150px;
}
</style>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/nav.jsp"%>
<main>
<h2>Webtoon</h2><hr>
<div class="card">
<!-- 	<script id="webtoonTemplate" type="text/x-handlebars-template"> -->
	<div class="row">
		<div class="col-md-auto">
			<div id="webtoon_thumbnail" class="image_container col-md-auto">
				<img src="{{thumbnail}}">
			</div>
		</div>
		<div class="col">
			<div class="card-body">
				<h5 class="card-title">{{title}}</h5>
				<p class="card-text">{{summary}}</p>
				
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<div class="card-footer text-right">
				<button class="btn btn-warning btn-sm">EDIT</button>
				<button class="btn btn-danger btn-sm">DELETE</button>
			</div>
		</div>
	</div>
<!-- 	</script> -->
</div>
<input type = "button" class="btn btn-primary" id = "insert" value ="회차등록">
<table>
	<tr>
		<th>
			Thumbnail
		</th>
		<th>
			No
		</th>
		<th>
			Title
		</th>
		<th>
			Hits
		</th>
		<th>
			Reg Date
		</th>
		<th>
			Delete
		</th>
		<th>
			Update
		</th>
	</tr>
	<script id="myEpisodeListTemplate" type="text/x-handlebars-template">
	{{#each .}}
	<tr>
		<td onclick = "location.href = '<c:url value='/webtoons/${webtoonId}/episodes/'/>{{no}}'">
			<img src = "{{thumbnail}}" width = "100px">
		</td>
		<td onclick = "location.href = '<c:url value='/webtoons/${webtoonId}/episodes/'/>{{no}}'">
			{{no}}
		</td>
		<td onclick = "location.href = '<c:url value='/webtoons/${webtoonId}/episodes/'/>{{no}}'">
			{{title}}
		</td>
		<td onclick = "location.href = '<c:url value='/webtoons/${webtoonId}/episodes/'/>{{no}}'">
			{{Hits}}
		</td>
		<td onclick = "location.href = '<c:url value='/webtoons/${webtoonId}/episodes/'/>{{no}}'">
			{{regDate}}
		</td>
		<td>
			<input type = "button" value = "삭제" id = "deleteEpisode" onclick="deleteEpisode({{no}})">
		</td>
		<td>
			<input type = "button" value = "수정" id = "updateEpisode" onclick="updateEpisode({{no}})">
		</td>
	</tr>
	{{/each}}
	</script>
</table>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>