<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
</head>
<script>
var currentPage = 1;
var totalPageCount = 1;

$(function(){
	getWebtoon();
	getEpisodes(1);
})

function getWebtoon(){
	$.ajax({
		url: "<c:url value='/api/webtoons/${webtoonId}'/>",
		method: "get",
		success: function(data){
			bindTemplate($("#webtoonTemplate"), data);
			splitHashtag(data.hashtag);
		}
	})
}

function splitHashtag(hashtags){
	var hashtagArr = hashtags.split("#");
	$(hashtagArr).each(function(idx, hashtag){
		if(hashtag != ""){
			var html = "<div class='hashtag'>#"+hashtag+"</div>";
			$("#hashtags").append(html);
		}
	})
}

function getEpisodes(currentPage){
	if(currentPage < 1 || currentPage > totalPageCount) return;
	$.ajax({
		url: "<c:url value='/api/webtoons/${webtoonId}/episodes'/>",
		method: "get",
		data:{
			currentPage: currentPage
		},
		success: function(data){
			$("#episodeList").remove();
			$("#navi").remove();
			bindTemplate($("#episodeListTemplate"), data.episodeList);
			bindTemplate($("#naviTemplate"), data.navi);
			currentPage = (data.navi.currentPage == 0) ? 1 : data.navi.currentPage;
			totalPageCount = (data.navi.totalPageCount == 0) ? 1 : data.navi.totalPageCount;
		}
	})
}
</script>
<style>
.info{
	line-height: 20px;
}
.image_container{
	width: 200px;
	height: 200px;
	display: inline-block;
	background-size: cover;
	background-position: center;
}
.webtoon_info{
	margin: 10px;
	display: inline-block;
	vertical-align: top;
}
.webtoon_title{
	font-weight: bold;
	font-size: 20px;
	margin-bottom: 5px;
}
.author{
	margin-bottom: 20px;
}
.episode-table{
	width: 100%;
}
.episode-table * {
	text-align: center;
	margin: auto;
}
.table td{
	vertical-align: middle;
}
tr:active{
	border: 2px solid #fbc714;
}
.hashtags{
	margin-top: 20px;
}
.hashtag{
	display: inline-block;
	padding: 5px 10px;
	background-color: #25a4cd;
	color: white;
	font-weight: bold;
	border-radius: 30px;
	cursor: pointer;
	margin-right: 10px;
}
.episode_thumbnail{
	width: 80px;
	height: 50px;
}
</style>
<body>
<%@ include file="../layout/header.jsp"%>
<main>
<script id="webtoonTemplate" type="text/x-handlebars-template">
<div class="info">
	<div class="webtoon_thumbnail image_container" style="background-image: url({{thumbnail}})"></div>
	<div class="webtoon_info">	
		<div class="webtoon_title">{{title}}</div>
		<div class="author">{{authorNickname}}</div>
		{{summary}}
		<div id="hashtags" class="hashtags"></div>
	</div>
</div>
</script>
<script id="naviTemplate" type="text/x-handlebars-template">
<div id="navi" class="row">
<div class="col">
<div id="navi" class="mt-3 float-right input-group mb-3" style="width: 150px;">
	<div class="input-group-prepend" id="idx"><span class="input-group-text">{{currentPage}} / {{totalPageCount}}</span></div>
	<div class="input-group-append">
		<button class="btn btn-secondary btn-sm" onclick="getEpisodes({{currentPage}}-1)">prev</button>
		<button class="btn btn-secondary btn-sm" onclick="getEpisodes({{currentPage}}+1)">next</button>
	</div>
</div>
</div>
</div>
</script>
<script id="episodeListTemplate" type="text/x-handlebars-template">
<table id="episodeList" class="episode-table table">
	<tr>
		<th>No</th>
		<th>Image</th>
		<th class="text-left">Title</th>
		<th>Hits</th>
		<th>Reg Date</th>
	</tr>
	{{#each .}}
	<tr onclick="location.href = '<c:url value='/webtoons/${webtoonId}/episodes/{{no}}'/>'">
		<td>{{no}}</td>
		<td><div class="episode_thumbnail image_container" style="background-image: url({{thumbnail}})"></div></td>
		<td style="width: 50%;" class="text-left">{{title}}</td>
		<td>{{hits}}</td>
		<td>{{regdate}}</td>
	</tr>
	{{/each}}
</table>
</script>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>