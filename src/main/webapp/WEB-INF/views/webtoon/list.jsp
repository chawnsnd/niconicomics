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
var currentPage = 1;
var totalPageCount = 1;
$(function(){
	$.ajaxSettings.traditional = true;
	getWebtoonList(1);
	initRecommandHashtag();
})
function getWebtoonList(currentPage){
	if(currentPage < 1 || currentPage > totalPageCount) return;
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
			$(data.webtoonList).each(function(idx ,webtoon){
				webtoon.hashtags = splitHashtag(webtoon.hashtag);
			})
			bindTemplate($("#webtoonListTemplate"), data.webtoonList);
			$("#navi").remove();
			bindTemplate($("#naviTemplate"), data.navi);
			currentPage = (data.navi.currentPage == 0) ? 1 : data.navi.currentPage;
			totalPageCount = (data.navi.totalPageCount == 0) ? 1 : data.navi.totalPageCount;
		}
	})
}
function initRecommandHashtag(){
	$("input[name='checkHashtag']").on("click", function(){
		var value = $(this).val();
		var idx = searchOption.hashtags.indexOf(value); 
		if (idx > -1) searchOption.hashtags.splice(idx, 1);
		else searchOption.hashtags.push(value);
		$("#searchOption").remove();
		bindTemplate($("#searchOptionTemplate"), searchOption);
		getWebtoonList(1);
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
	getWebtoonList(1);
}
function removeSearchOption(key, value){
	if(key == "hashtag"){
		var idx = searchOption.hashtags.indexOf(value); 
		if (idx > -1) searchOption.hashtags.splice(idx, 1);
	}else{
		searchOption[key] = null;
	}
	$("#searchOption").remove();
	bindTemplate($("#searchOptionTemplate"), searchOption);
	getWebtoonList(1);
}
function splitHashtag(hashtags){
	var hashtagArr = hashtags.split("#");
	hashtagArr.shift();
	return hashtagArr;
}
function enterSearch(e){
	e = e || window.event;
	if(e.keyCode == 13){
		$("#searchButton").trigger("click");
	}
}
</script>
</head>
<style>
.keyword{
	display: inline-block;
	padding: 5px 10px;
	background-color: #25a4cd;
	color: white;
	font-weight: bold;
	border-radius: 30px;
	cursor: pointer;
}
.image_container{
	width: 150px;
	height: 120px;
	background-size: cover;
	background-position: center;
}
.webtoon{
	display: inline-block;
	cursor: pointer;
	margin-left: 6.5px;
	margin-right: 6.5px;
	margin-top: 15px;
	width: 150px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
.webtoon:hover{
    box-shadow: 0.5px 0.5px 3px 0px black;
}
.image_container{
	width: 150px;
	height: 120px;
}
.title{
	font-weight: bold;
	font-size: 16px;
	padding: 5px;
	padding-bottom: 0px;
}
.author{
	padding-left: 5px;
	padding-bottom: 5px;
}
</style>
<body>
<%@ include file="../layout/header.jsp"%>
<main>
<div class="card p-3">
	<div class="h3">Search</div>
	<div class="input-group">
		<div class="input-group-prepend">
			<select class="custom-select" id="searchKey">
				<option value="title">Title</option>
				<option value="author">Author</option>
				<option value="hashtag">Hashtag</option>
			</select>
		</div>
		<input type="text" id="searchValue" class="form-control" onkeydown="enterSearch()">
		<div class="input-group-append">
			<button id="searchButton" class="btn btn-primary btn-sm" onclick="addSearchOption()">Add & Search</button>
		</div>
	</div>
	<div class="mt-3">
		<h5>Recommand Hashtag</h5>
		<div>
		</div>
		<div>
			<div class="form-check form-check-inline"">
				<label><input type="checkbox" class="form-check-input" name="checkHashtag" value="episode"># episode</label>
			</div>
			<div class="form-check form-check-inline"">
				<label><input type="checkbox" class="form-check-input" name="checkHashtag" value="omnibus"># omnibus</label>
			</div>
			<div class="form-check form-check-inline"">
				<label><input type="checkbox" class="form-check-input" name="checkHashtag" value="story"># story</label>
			</div>
			<div class="form-check form-check-inline"">
				<label><input type="checkbox" class="form-check-input" name="checkHashtag" value="life"># life</label>
			</div>
			<div class="form-check form-check-inline"">
				<label><input type="checkbox" class="form-check-input" name="checkHashtag" value="gag"># gag</label>
			</div>
			<div class="form-check form-check-inline"">
				<label><input type="checkbox" class="form-check-input" name="checkHashtag" value="fantasy"># fantasy</label>
			</div>
			<div class="form-check form-check-inline"">
				<label><input type="checkbox" class="form-check-input" name="checkHashtag" value="action"># action</label>
			</div>
			<div class="form-check form-check-inline"">
				<label><input type="checkbox" class="form-check-input" name="checkHashtag" value="drama"># drama</label>
			</div>
			<div class="form-check form-check-inline"">
				<label><input type="checkbox" class="form-check-input" name="checkHashtag" value="romance"># romance</label>
			</div>
			<div class="form-check form-check-inline"">
				<label><input type="checkbox" class="form-check-input" name="checkHashtag" value="sensitivity"># sensitivity</label>
			</div>
			<div class="form-check form-check-inline"">
				<label><input type="checkbox" class="form-check-input" name="checkHashtag" value="thriller"># thriller</label>
			</div>
			<div class="form-check form-check-inline"">
				<label><input type="checkbox" class="form-check-input" name="checkHashtag" value="costume"># costume</label>
			</div>
			<div class="form-check form-check-inline"">
				<label><input type="checkbox" class="form-check-input" name="checkHashtag" value="sport"># sport</label>
			</div>
		</div>
	</div>
</div>
<div>
<script id="searchOptionTemplate" type="text/x-handlebars-template">
<div id="searchOption" class="mt-3">
	{{#each hashtags}}
	<div class="badge badge-pill badge-info p-2" onclick="removeSearchOption('hashtag', '{{this}}')"># <span>{{this}}</span> <i class='far fa-times-circle'></i></div>
	{{/each}}
	{{#if title}}
	<div class="badge badge-pill badge-info p-2" onclick="removeSearchOption('title', '{{title}}')">Title : {{title}} <i class='far fa-times-circle'></i></div>
 	{{/if}}
	{{#if author}}
	<div class="badge badge-pill badge-info p-2" onclick="removeSearchOption('author', '{{author}}')">Author : {{author}} <i class='far fa-times-circle'></i></div>
	{{/if}}
</div>
</script>
<script id="naviTemplate" type="text/x-handlebars-template">
<div class="row">
<div class="col">
<div id="navi" class="mt-3 float-right input-group" style="width: 150px;">
	<div class="input-group-prepend" id="idx"><span class="input-group-text">{{currentPage}} / {{totalPageCount}}</span></div>
	<div class="input-group-append">
		<button class="btn btn-secondary btn-sm" onclick="getWebtoonList({{currentPage}}-1)">prev</button>
		<button class="btn btn-secondary btn-sm" onclick="getWebtoonList({{currentPage}}+1)">next</button>
	</div>
</div>
</div>
</div>
</script>
</div>
<script id="webtoonListTemplate" type="text/x-handlebars-template">
<div id="webtoonList" class="cards">
{{#each .}}
<div class="card webtoon" onclick="location.href = '<c:url value='/webtoons/'/>{{webtoonId}}'">
	<div class="image_container" style="background-image: url({{thumbnail}})"></div>
	<div class="title">{{title}}</div>
	<div class="author">{{authorNickname}}</div>
	{{#each hashtags}}
	<div class="badge badge-pill badge-info"># {{this}}</div>
	{{/each}}
</div>
{{/each}}
</div>
</script>

</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>