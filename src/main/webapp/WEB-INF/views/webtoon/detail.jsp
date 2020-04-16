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
$(function(){
	getWebtoon();
	getEpisodes();
})

function getWebtoon(){
	$.ajax({
		url: "<c:url value='/api/webtoons/${webtoonId}'/>",
		method: "get",
		success: function(data){
			console.log(data);
			bindTemplate($("#webtoonTemplate"), data);
			imageContainer();
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

function getEpisodes(){
	$.ajax({
		url: "<c:url value='/api/webtoons/${webtoonId}/episodes'/>",
		method: "get",
		success: function(data){
			bindTemplate($("#episodeListTemplate"), data);
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
	<div class="webtoon-thumbnail image_container"><img src="{{thumbnail}}"></div>
	<div class="webtoon_info">	
		<div class="webtoon_title">{{title}}</div>
		<div class="author">{{authorNickname}}</div>
		{{summary}}
		<div id="hashtags" class="hashtags"></div>
	</div>
</div>
</script>
<br>
<script id="episodeListTemplate" type="text/x-handlebars-template">
<table class="episode-table table">
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
		<td><div class="image_container episode_thumbnail"><img src="{{thumbnail}}"></div></td>
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