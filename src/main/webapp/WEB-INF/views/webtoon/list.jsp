<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<script>
var searchOption = {
	title: null,
	author: null,
	hashtags: []
}
var currentPage;
$(function(){
	getWebtoonList(1);
})
function getWebtoonList(currentPage){
	$.ajax({
		url: "<c:url value='/api/webtoons'/>",
		method: "get",
		data: {
			title: searchOption.title,
			author: searchOption.author,
			hashtags: searchOption.hashtags,
			currentPage: currentPage,
			countPerPage: 18
		},
		success: function(data){
			$("#webtoonList").remove();
			bindTemplate($("#webtoonListTemplate"), data.webtoonList);
			$("#navi").remove();
			bindTemplate($("#naviTemplate"), data.navi);
			currentPage = data.navi.currentPage;
		}
	})
}
function addSearchOption(){
	var searchKey = $("#searchKey").val();
	var searchValue = $("#searchValue").val();
	if(searchValue == null || searchValue == "") return;
	if(searchKey == "hashtag"){
		var idx = searchOption.hashtags.indexOf(searchValue); 
		if (idx > -1) return;
		searchOption.hashtags.push(searchValue);
	}else{
		searchOption[searchKey] = searchValue;
	}
	$("#searchOption").remove();
	bindTemplate($("#searchOptionTemplate"), searchOption);
	getWebtoonList(currentPage);
}
function removeSearchOption(key, value){
	if(key == "hashtag"){
		var idx = searchOption.hashtags.indexOf(value); 
		console.log(idx);
		if (idx > -1) searchOption.hashtags.splice(idx, 1);
	}else{
		searchOption[key] = null;
	}
	$("#searchOption").remove();
	bindTemplate($("#searchOptionTemplate"), searchOption);
	getWebtoonList(currentPage);
}
</script>
</head>
<style>
.card{
	display: inline-block;
	width: 150px;
	height: 100px;
	margin: 0px 6px;
	margin-bottom: 6px;
	cursor: pointer;
}
.searchbox{
	display: inline-block;
	border: 1px solid #aeaeae;
	width: 100%;
	height: 200px;
}
.line{
	margin: 20px 0;
}
.right{
	float: right;
}
.keyword{
	display: inline-block;
	padding: 5px 10px;
	background-color: #25a4cd;
	color: white;
	font-weight: bold;
	border-radius: 30px;
	cursor: pointer;
}
</style>
<body>
<%@ include file="../layout/header.jsp"%>
<main>
<div class="searchbox">
	<h3>Search</h3>
	<select id="searchKey">
		<option value="title">Title</option>
		<option value="author">Author</option>
		<option value="hashtag">HashTag</option>
	</select>
	<input type="text" id="searchValue">
	<button class="btn btn-primary btn-sm" onclick="addSearchOption()">Add & Search</button>
</div>
<div class="line">
	<script id="searchOptionTemplate" type="text/x-handlebars-template">
	<div id="searchOption">
		{{#each hashtags}}
 		<div class="keyword" onclick="removeSearchOption('hashtag', '{{this}}')">#<span>{{this}}</span> X</div>
		{{/each}}
		{{#if title}}
 		<div class="keyword" onclick="removeSearchOption('title', '{{title}}')">Title : {{title}} X</div>
 		{{/if}}
		{{#if author}}
		<div class="keyword" onclick="removeSearchOption('author', '{{author}}')">Author : {{author}} X</div>
		{{/if}}
	</div>
	</script>
	<script id="naviTemplate" type="text/x-handlebars-template">
	<div id="navi" class="right btn-group">
		<div>{{currentPage}} / {{totalPageCount}}</div>
		<button class="btn btn-light" onclick="getWebtoonList({{currentPage}}-1)">prev</button>
		<button class="btn btn-light" onclick="getWebtoonList({{currentPage}}+1)">next</button>
	</div>
	</script>
</div>
<script id="webtoonListTemplate" type="text/x-handlebars-template">
<div id="webtoonList" class="cards">
{{#each .}}
<div class="card" onclick="location.href ='<c:url value='/webtoons/{{webtoonId}}'/>'">
	<img src="{{thumbnail}}" width="150px;">
	<div>{{title}}</div>
	<div>{{hashtag}}</div>
</div>
{{/each}}
</div>
</script>

</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>