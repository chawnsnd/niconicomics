<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<script>
$(function() {
	$("#insertWebtoonForm").on("submit", function(e){
		e.preventDefault();
	});
	$("#insertWebtoonButton").on('click', insertWebtoon);
	$("#thumbnailInput").on('change', thumbnailPreview);
})

function thumbnailPreview(){
	var reader = new FileReader();
	reader.onload = function (e) {
		$('#thumbnail_output').html("<img src='"+e.target.result+"' width='120px'>");
	}
	reader.readAsDataURL($("#thumbnailInput")[0].files[0]);
}

function insertWebtoon() {
	if(!validate()) return;
	var strHashtags = "";
	strHashtags += "#"+$("input[name='typeHashtag']:checked").val();
	$("input[name='checkHashtag']:checked").each((idx, hashtag) => {
		strHashtags += "#"+$(hashtag).val();
	})
	if($("input[data-role='tagsinput']").val().trim()!=""){
		strHashtags += "#"+$("input[data-role='tagsinput']").val();
	}
	$("#hashtag").val(strHashtags);
	var form = $('#insertWebtoonForm')[0];
	var formData = new FormData(form);
// 	$.ajax({
// 		url : "<c:url value='/api/webtoons'/>",
// 		type : 'post',
// 		enctype: 'multipart/form-data',
// 		data : formData,
// 		contentType: false,
// 		processData: false,
// 		success : function() {
// 			location.href= "<c:url value='/dashboard/webtoons'/>";
// 		},
// 		error : function(err) {
// 			console.log(err)
// 		}
// 	})
}

function validate(){
	var result = true;
	if($("#title").val()==""||$("#title").val()==null) result = false;
	if($("#summary").val()==""||$("#summary").val()==null) result = false;
	if($("#thumbnailInput")[0].files.length == 0) result = false;
	if($("input[name='typeHashtag']:checked").length == 0) result = false;
	if(!result) alert("Please check the input box.");
	return result;
}

</script>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/nav.jsp"%>
<main>
<h2>Webtoon</h2><hr>
<div class="card">
	<form id="insertWebtoonForm">
	<table class="table">
		<tr>
			<th>Title</th>
			<td><input type="text" class="form-control" name="title" id="title"></td>
		</tr>
		<tr>
			<th>Summary</th>
			<td><textarea class="form-control" name="summary" id="summary"></textarea></td>
		</tr>
		<tr>
			<th>Tag</th>
			<td>
				<div>
					<span><b>Required</b></span>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="typeHashtag" id="episode" value="episode">
						<label class="form-check-label" for="episode">episode</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="typeHashtag" id="omnibus" value="omnibus">
						<label class="form-check-label" for="omnibus">omnibus</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="typeHashtag" id="story" value="story">
						<label class="form-check-label" for="story">story</label>
					</div>
				</div>
				<hr>
				<div>
					<div class="form-check form-check-inline">
						<label><input class="form-check-input" type="checkbox" name="checkHashtag" value="life">life</label>
					</div>
					<div class="form-check form-check-inline">
						<label><input class="form-check-input" type="checkbox" name="checkHashtag" value="gag">gag</label>
					</div>
					<div class="form-check form-check-inline">
						<label><input class="form-check-input" type="checkbox" name="checkHashtag" value="fantasy">fantasy</label>
					</div>
					<div class="form-check form-check-inline">
						<label><input class="form-check-input" type="checkbox" name="checkHashtag" value="action">action</label>
					</div>
					<div class="form-check form-check-inline">
						<label><input class="form-check-input" type="checkbox" name="checkHashtag" value="drama">drama</label>
					</div>
					<div class="form-check form-check-inline">
						<label><input class="form-check-input" type="checkbox" name="checkHashtag" value="romance">romance</label>
					</div>
					<div class="form-check form-check-inline">
						<label><input class="form-check-input" type="checkbox" name="checkHashtag" value="sensitivity">sensitivity</label>
					</div>
					<div class="form-check form-check-inline">
						<label><input class="form-check-input" type="checkbox" name="checkHashtag" value="thriller">thriller</label>
					</div>
					<div class="form-check form-check-inline">
						<label><input class="form-check-input" type="checkbox" name="checkHashtag" value="costume">costume</label>
					</div>
					<div class="form-check form-check-inline">
						<label><input class="form-check-input" type="checkbox" name="checkHashtag" value="sport">sport</label>
					</div>
				</div>
				<hr>
				<input type="text" class="form-control" placeholder="Custom hashtag" data-role="tagsinput">
				<input type="hidden" id="hashtag" name="hashtag">
			</td>
		</tr>
		<tr>
			<th>Thumbnail</th>
			<td>
				<input type="file" name="thumbnailImage" value="이미지추가" id="thumbnailInput">
				<div id="thumbnail_output" class="mt-3"></div>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="text-center">
				<input type="button" class="btn btn-outline-secondary" value="Cancel" onclick="history.go(-1);">
				<input type="button" class="btn btn-primary" id="insertWebtoonButton" value="Submit">
			</td>
		</tr>
	</table>
	</form>
</div>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>