<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<script>
var maxNo = 0;
var currentPage = 1;
var totalPageCount = 1;
$(document).ready(function() {
	$('#insert').on('click', insertEpisode);
	getWebtoon();
	getEpisodes(1);
});

function getWebtoon(){
	$.ajax({
		url: "<c:url value='/api/webtoons/${webtoonId}'/>", // core/webtoons
		type: "GET",
		data:{
			authorId : "${sessionScope.loginUser.userId}"
		},
		success: function(data){
			maxNo = data.maxNo;
			data["hashtags"] = data.hashtag.split("#").slice(1);
			bindTemplate($('#webtoonTemplate'), data);
		},
		error: function(err){
			console.log(err);
		}
	})
}

function insertEpisode(){
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

function deleteWebtoon(webtoonId){
	$.ajax({
		url : "<c:url value='/api/webtoons/'/>"+webtoonId,
		method : "delete",
		success : function(){
			location.href="<c:url value='/dashboard/webtoons'/>"
		},
		error : function(err){
			console.log(err)
		}
	})
}

function updateWebtoon(webtoonId){
	location.href = "<c:url value='/dashboard/webtoons/"+webtoonId+"/update'/>"
}


function updateEpisode(episodeNo){
	location.href = "<c:url value='/dashboard/webtoons/${webtoonId}/episodes/"+episodeNo+"/update'/>"
}

function getEpisodes(currentPage){
	$.ajax({
		url: "<c:url value='/api/webtoons/${webtoonId}/episodes'/>",
		type: "GET",
		data:{
			currentPage: currentPage,
			countPerPage: 10
		},
		async: false,
		success: function(data){
			$("#myEpisodeList").remove();
			$("#navi").remove();
			bindTemplate($('#naviTemplate'), data.navi);
			bindTemplate($('#myEpisodeListTemplate'), data.episodeList);
			currentPage = (data.navi.currentPage == 0) ? 1 : data.navi.currentPage;
			totalPageCount = (data.navi.totalPageCount == 0) ? 1 : data.navi.totalPageCount;
		},
		error: function(err){
			console.log(err);
		}
	})
}
</script>
<style>
#webtoon_thumbnail{
	width: 150px;
	height: 150px;
}
#episode_thumbnail{
	width: 80px;
	height: 50px;
}
.image_container{
	background-size: cover;
	background-position: center;
}
</style>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/nav.jsp"%>
<main>
<h2>Webtoon</h2><hr>
<div class="card">
	<script id="webtoonTemplate" type="text/x-handlebars-template">
	<div class="row">
		<div class="col-md-auto">
			<div id="webtoon_thumbnail" class="image_container" style="background-image: url({{thumbnail}})"></div>
		</div>
		<div class="col">
			<div class="card-body">
				<h5 class="card-title">{{title}}</h5>
				<p class="card-text">{{summary}}</p>
				<div id="hashtags">
					{{#each hashtags}}
					<span class="badge badge-pill badge-info"># {{this}}</span>
					{{/each}}
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col">
			<div class="card-footer text-right">
				<button class="btn btn-warning btn-sm" onclick="updateWebtoon({{webtoonId}})">EDIT</button>
				<button class="btn btn-danger btn-sm" onclick="deleteWebtoon({{webtoonId}})">DELETE</button>
			</div>
		</div>
	</div>
 	</script>
</div>
<div class="card mt-3">
	<div class="card-body">
		<p class="card-title float-left">
			<input type = "button" class="btn btn-primary" id = "insert" value ="Post Episode" onclick="insertEpisode()">
		</p>
		<script id="naviTemplate" type="text/x-handlebars-template">
		<div id="navi" class="float-right">
			<div class="input-group" style="width: 150px;">
				<div class="input-group-prepend" id="idx"><span class="input-group-text">{{currentPage}} / {{totalPageCount}}</span></div>
				<div class="input-group-append">
					<button class="btn btn-secondary btn-sm" onclick="getEpisodes({{currentPage}}-1)">prev</button>
					<button class="btn btn-secondary btn-sm" onclick="getEpisodes({{currentPage}}+1)">next</button>
				</div>
			</div>
		</div>
		</script>
		<script id="myEpisodeListTemplate" type="text/x-handlebars-template">
		<table id="myEpisodeList" class="table">
			<tr>
				<th>
					No
				</th>
				<th>
					Thumbnail
				</th>
				<th width="50%">
					Title
				</th>
				<th>
					Hits
				</th>
				<th>
					Reg Date
				</th>
				<th>
					Edit
				</th>
			</tr>
			{{#each .}}
			<tr>
				<td onclick = "location.href = '<c:url value='/webtoons/${webtoonId}/episodes/'/>{{no}}'">
					{{no}}
				</td>
				<td onclick = "location.href = '<c:url value='/webtoons/${webtoonId}/episodes/'/>{{no}}'">
					<div id="episode_thumbnail" class="image_container" style="background-image: url({{thumbnail}})"></div>
				</td>
				<td onclick = "location.href = '<c:url value='/webtoons/${webtoonId}/episodes/'/>{{no}}'">
					{{title}}
				</td>
				<td onclick = "location.href = '<c:url value='/webtoons/${webtoonId}/episodes/'/>{{no}}'">
					{{hits}}
				</td>
				<td onclick = "location.href = '<c:url value='/webtoons/${webtoonId}/episodes/'/>{{no}}'">
					{{regdate}}
				</td>
				<td>
					<button class="btn btn-warning btn-sm" id="updateEpisode" onclick="updateEpisode({{no}})">Edit</button>
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