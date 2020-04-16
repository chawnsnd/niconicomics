<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../layout/global.jsp"%>
<script>
$(function() {
	$("#updateWebtoonButton").on('click', updateWebtoon);
	getWebtoon();
})

function getWebtoon(){
	$.ajax({
		url : '<c:url value="/api/webtoons/${webtoonId}"/>',
		type : "GET",
		success : function(data){
			bindTemplate($('#webtoonTemplate'), data);
			$('#thumbnail_output').html("<img src='"+data.thumbnail+"' width='200px'>");
			$("#thumbnailInput").on('change', thumbnailPreview);
			data["hashtags"] = data.hashtag.split("#").slice(1);
			$(data.hashtags).each((idx, tag)=>{
				$('input[name="typeHashtag"], input[name="checkHashtag"]').each((idx, box)=>{
					if($(box).val() == tag) $(box).prop("checked", true);
					return true;
				})
				$('input[data-role="tagsinput"]').tagsinput('add', { "value": idx+1, "text": tag});
			})
		},
		error : function(err) {
			console.log(err);
		}
	})
}	

function thumbnailPreview(){
	var reader = new FileReader();
	reader.onload = function (e) {
		$('#thumbnail_output').html("<img src='"+e.target.result+"' width='200px'>");
	}
	reader.readAsDataURL($("#thumbnailInput")[0].files[0]);
}

function updateWebtoon() {
	var strHashtags = "";
	strHashtags += "#"+$("input[name='typeHashtag']:checked").val();
	$("input[name='checkHashtag']:checked").each((idx, hashtag) => {
		strHashtags += "#"+$(hashtag).val();
	})
	strHashtags += "#"+$("input[data-role='tagsinput']").val();
	$("#hashtag").val(strHashtags);
	var form = $('#updateWebtoonForm')[0];
	var formData = new FormData(form);
	$.ajax({
		url : "<c:url value='/api/webtoons/${webtoonId}/put'/>",
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
</script>
</head>
<body>
	<%@ include file="../layout/header.jsp"%>
	<%@ include file="../layout/nav.jsp"%>
	<main>
		<div class="card">
		<form id="updateWebtoonForm">
		<script id = "webtoonTemplate" type="text/x-handlebars-template">
		<table class="table">
		<tr>
			<th>Title</th>
			<td><input type="text" class="form-control" name="title" id="title" value={{title}}></td>
		</tr>
		<tr>
			<th>Summary</th>
			<td><textarea class="form-control" name="summary" id="summary">{{summary}}</textarea></td>
		</tr>
		<tr>
			<th>Tag</th>
			<td>
				<div>
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
		</script>
		</form>
		</div>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>