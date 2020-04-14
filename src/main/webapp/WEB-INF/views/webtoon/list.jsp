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
	$.ajaxSettings.traditional = true;
	getWebtoonList(1);
	initRecommandHashtag();
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
			imageContainer();
			$("#navi").remove();
			bindTemplate($("#naviTemplate"), data.navi);
			currentPage = data.navi.currentPage;
		}
	})
}
function initRecommandHashtag(){
	$("input[name='typeHashtag']").on("change", function(){
		var value = $(this).val();
		var idx = searchOption.hashtags.indexOf(value); 
		if (idx > -1) return;
		var idx = searchOption.hashtags.indexOf("episode"); 
		if (idx > -1) searchOption.hashtags.splice(idx, 1);
		var idx = searchOption.hashtags.indexOf("omnibus"); 
		if (idx > -1) searchOption.hashtags.splice(idx, 1);
		var idx = searchOption.hashtags.indexOf("story"); 
		if (idx > -1) searchOption.hashtags.splice(idx, 1);
		searchOption.hashtags.push(value);
		$("#searchOption").remove();
		bindTemplate($("#searchOptionTemplate"), searchOption);
		getWebtoonList(currentPage);
	})
	$("input[name='checkHashtag']").on("click", function(){
		var value = $(this).val();
		var idx = searchOption.hashtags.indexOf(value); 
		if (idx > -1) searchOption.hashtags.splice(idx, 1);
		else searchOption.hashtags.push(value);
		$("#searchOption").remove();
		bindTemplate($("#searchOptionTemplate"), searchOption);
		getWebtoonList(currentPage);
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
.image_container{
	width: 150px;
	height: 120px;
}
.webtoon{
	display: inline-block;
	cursor: pointer;
	margin-right: 15px;
	margin-top: 15px;
}
.webtoon:hover{
    box-shadow: 0.5px 0.5px 3px 0px black;
}
.navibar{
	line-height: 30px;
}
.navibar *{
	float: right;
	vertical-align: middle;
}
</style>
<body>
<%@ include file="../layout/header.jsp"%>
<main>
<div class="searchbox box">
	<h3>Search</h3>
	<select id="searchKey">
		<option value="title">Title</option>
		<option value="author">Author</option>
		<option value="hashtag">HashTag</option>
	</select>
	<input type="text" id="searchValue">
	<button class="btn btn-primary btn-sm" onclick="addSearchOption()">Add & Search</button>
	<div>
		<h5>Recommand Hashtag</h5>
		<div>
			<label><input type="radio" name="typeHashtag" value="episode">#episode</label>
			<label><input type="radio" name="typeHashtag" value="omnibus">#omnibus</label>
			<label><input type="radio" name="typeHashtag" value="story">#story</label>
		</div>
		<div>
			<label><input type="checkbox" name="checkHashtag" value="life">#life</label>
			<label><input type="checkbox" name="checkHashtag" value="gag">#gag</label>
			<label><input type="checkbox" name="checkHashtag" value="fantasy">#fantasy</label>
			<label><input type="checkbox" name="checkHashtag" value="action">#action</label>
			<label><input type="checkbox" name="checkHashtag" value="drama">#drama</label>
			<label><input type="checkbox" name="checkHashtag" value="romance">#romance</label>
			<label><input type="checkbox" name="checkHashtag" value="sensitivity">#sensitivity</label>
			<label><input type="checkbox" name="checkHashtag" value="thriller">#thriller</label>
			<label><input type="checkbox" name="checkHashtag" value="costume">#costume</label>
			<label><input type="checkbox" name="checkHashtag" value="sport">#sport</label>
		</div>
	</div>
</div>
<div class="line">
	<script id="searchOptionTemplate" type="text/x-handlebars-template">
	<div id="searchOption">
		{{#each hashtags}}
 		<div class="keyword" onclick="removeSearchOption('hashtag', '{{this}}')">#<span>{{this}}</span> <i class='far fa-times-circle'></i></div>
		{{/each}}
		{{#if title}}
 		<div class="keyword" onclick="removeSearchOption('title', '{{title}}')">Title : {{title}} <i class='far fa-times-circle'></i></div>
 		{{/if}}
		{{#if author}}
		<div class="keyword" onclick="removeSearchOption('author', '{{author}}')">Author : {{author}} <i class='far fa-times-circle'></i></div>
		{{/if}}
	</div>
	</script>
	<script id="naviTemplate" type="text/x-handlebars-template">
	<div id="navi" class="row navi">
	<div id="idx">{{currentPage}} / {{totalPageCount}}</div>
	<div id="btn" class="right btn-group">
		<button class="btn btn-light btn-sm" onclick="getWebtoonList({{currentPage}}-1)">prev</button>
		<button class="btn btn-light btn-sm" onclick="getWebtoonList({{currentPage}}+1)">next</button>
	</div>
	</div>
	</script>
</div>
<script id="webtoonListTemplate" type="text/x-handlebars-template">
<div id="webtoonList" class="cards">
{{#each .}}
<div class="card webtoon" onclick="location.href ='<c:url value='/webtoons/{{webtoonId}}'/>'">
	<div class="image_container"><img src="{{thumbnail}}"></div>
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