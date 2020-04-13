<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../layout/global.jsp"%>
<script>
var hashtags = [];
$(function() {
	initRecommandHashtag();
	$("#insertWebtoonForm").on("submit", function(e){
		e.preventDefault();
	});
	$("#insertWebtoonButton").on('click', insertWebtoon);
	$("#addHashtagButton").on('click', function(e){
		e.stopPropagation();
		e.preventDefault();
		addHashtag();
	});
	$("#thumbnailInput").on('change', thumbnailPreview);
})

function thumbnailPreview(){
	var reader = new FileReader();
	reader.onload = function (e) {
		$('#output').html("<img src='"+e.target.result+"' width='200px'>");
	}
	reader.readAsDataURL($("#thumbnailInput")[0].files[0]);
}

function insertWebtoon() {
	var strHashtags = "";
	$(hashtags).each(function(idx, hashtag){
		strHashtags += "#";
		strHashtags += hashtag;
	})
	$("#hashtag").val(strHashtags);
	var form = $('#insertWebtoonForm')[0];
	var formData = new FormData(form);
	$.ajax({
		url : "<c:url value='/api/webtoons'/>",
		type : 'post',
		enctype: 'multipart/form-data',
		data : formData,
		contentType: false,
		processData: false,
		success : function() {
			location.href= "<c:url value='/dashboard/webtoons'/>";
		},
		error : function(err) {
			console.log(err)
		}
	})
}
function addHashtag(){
	var hashtag = $("#customHashtag").val();
	var idx = hashtags.indexOf(hashtag); 
	if (idx > -1) return;
	hashtags.push(hashtag);
	$("#hashtags").remove();
	bindTemplate($("#hashtagsTemplate"), hashtags);
}
function removeHashtag(hashtag){
	var idx = hashtags.indexOf(hashtag); 
	if (idx > -1) hashtags.splice(idx, 1);
	$("#hashtags").remove();
	bindTemplate($("#hashtagsTemplate"), hashtags);
}
function initRecommandHashtag(){
	$("input[name='typeHashtag']").on("change", function(){
		var value = $(this).val();
		var idx = hashtags.indexOf(value); 
		if (idx > -1) return;
		var idx = hashtags.indexOf("episode"); 
		if (idx > -1) hashtags.splice(idx, 1);
		var idx = hashtags.indexOf("omnibus"); 
		if (idx > -1) hashtags.splice(idx, 1);
		var idx = hashtags.indexOf("story"); 
		if (idx > -1) hashtags.splice(idx, 1);
		hashtags.push(value);
		$("#hashtags").remove();
		bindTemplate($("#hashtagsTemplate"), hashtags);
	})
	$("input[name='checkHashtag']").on("click", function(){
		var value = $(this).val();
		var idx = hashtags.indexOf(value); 
		if (idx > -1) hashtags.splice(idx, 1);
		else hashtags.push(value);
		$("#hashtags").remove();
		bindTemplate($("#hashtagsTemplate"), hashtags);
	})
}
</script>
<style>
.hashtag{
	display: inline-block;
	padding: 5px 10px;
	background-color: #25a4cd;
	color: white;
	font-weight: bold;
	border-radius: 30px;
	cursor: pointer;
}
</style>
</head>
<body>
	<%@ include file="../layout/header.jsp"%>
	<%@ include file="../layout/nav.jsp"%>
	<main>
		<form id="insertWebtoonForm">
		<table border="1">
			<tr>
				<th>Title</th>
				<td><input type="text" name="title" id="title"></td>
			</tr>
			<tr>
				<th>Summary</th>
				<td><input type="text" name="summary" id="summary"></td>
			</tr>
			<tr>
				<th>Hashtag</th>
				<td>
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
					Custom : <input type="text" id="customHashtag" name="customHashtag">
					<button class="btn btn-primary btn-sm" id="addHashtagButton">add</button>
					<input type="text" id="hashtag" name="hashtag" hidden="hidden">
					<script id="hashtagsTemplate" type="text/x-handlebars-template">
					<div id="hashtags">
						{{#each .}}
				 		<div class="hashtag" onclick="removeHashtag('{{this}}')">#<span>{{this}}</span> X</div>
						{{/each}}
					</div>
					</script>
				</td>
			</tr>
			<tr>
				<th>Thumbnail</th>
				<td>
					<input type="file" name="thumbnailImage" value="이미지추가" id="thumbnailInput">
					<div id="output"></div>
				</td>
			</tr>
			<tr>
				<td><input type="button" id="insertWebtoonButton" value="submit"></td>
			</tr>
		</table>
		</form>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>