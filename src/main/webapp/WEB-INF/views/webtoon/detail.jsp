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
			bindTemplate($("#webtoonTemplate"), data);
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
.webtoon-thumbnail{
	width: 200px;
	height: 200px;
	overflow: hidden;
}
.episode-table{
	width: 100%;
}
.episode-table * {
	text-align: center;
	margin: auto;
}
tr:active{
	border: 2px solid #fbc714;
}
</style>
<body>
<%@ include file="../layout/header.jsp"%>
<main>
<script id="webtoonTemplate" type="text/x-handlebars-template">
<div>
	<div class="webtoon-thumbnail"><img src="{{thumbnail}}"></div>
	<b>{{title}}</b>
	<div>{{summary}}</div>
</div>
</script>
<br>
<script id="episodeListTemplate" type="text/x-handlebars-template">
<table class="episode-table table">
	<tr>
		<th>회차</th>
		<th>이미지</th>
		<th>제목</th>
		<th>등록일</th>
	</tr>
	{{#each .}}
	<tr onclick="location.href = '<c:url value='/webtoons/${webtoonId}/episodes/{{no}}'/>'">
		<td>{{no}}</td>
		<td><img src="{{thumbnail}}" width="100px"></td>
		<td>{{title}}</td>
		<td>{{regdate}}</td>
	</tr>
	{{/each}}
</table>
</script>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>