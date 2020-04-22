<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../../layout/global.jsp"%>
<script>
$(function() {
	getEpisode();
})

function getEpisode(){
	$.ajax({
		url : '<c:url value="/api/webtoons/${webtoonId}/episodes/${episodeNo}"/>',
		type : "GET",
		success : function(data){
			bindTemplate($('#updateEpisodeTemplate'), data);
			$('#output').html("<img src='"+data.episode.thumbnail+"' width='120px'>");
			$("#thumbnailInput").on('change', thumbnailPreview);
			$("#updateEpisodeButton").on('click', updateEpisode);
			contentsPreview();
		},
		error : function(err) {
			console.log(err);
		}
	})
}

function addContents(){
	var curIdx = $(".contents").last().data("idx");
	var html = '<div class="contents">'+
		'<input type="file" name="'+(Number(curIdx)+1)+'" class="contentsInput">'+
		'<input type="button" class="btn btn-danger btn-sm float-right" value="REMOVE" onclick="removeContents(this)">'+
		'<input type="button" class="btn btn-outline-secondary btn-sm float-right mr-1"value=" ▼ " onclick="downContents(this)">'+
		'<input type="button" class="btn btn-outline-secondary btn-sm float-right" value=" ▲ " onclick="upContents(this)">'+
		'</div>';
	$("#contentsList").append(html);
	$(".contentsInput").off('change');
	$(".contentsInput").on('change', contentsPreview);
}

function removeContents(target){
	var idx = $(target).parents().children("input[type='file']").attr("name");
	$(".contents").eq(idx-1).remove();
	contentsPreview();
}

function contentsPreview(){
	$('#contentsPreview').html("");
	$('.contentsInput').each(function(i, inp){
		if($(inp)[0].files.length == 0){
			var image = $(inp).data("image");
			$('#contentsPreview').append("<div><img src='"+image+"' width='50%'></div>");
		}else{
			var reader = new FileReader();
			reader.onload = function (e) {
				$('#contentsPreview').append("<div><img src='"+e.target.result+"' width='50%'></div>");
			}
			if($(inp)[0].files.length != 0) reader.readAsDataURL($(inp)[0].files[0]);
		}
	});
}

function thumbnailPreview(){
	var reader = new FileReader();
	reader.onload = function (e) {
		$('#output').html("<img src='"+e.target.result+"' width='120px'>");
	}
	reader.readAsDataURL($("#thumbnailInput")[0].files[0]);
}

function updateEpisode() {
	if(!validate()) return;
	var form = $('#updateEpisodeForm')[0];
	var formData = new FormData(form);
	$.ajax({
		url : "<c:url value='/api/webtoons/${webtoonId}/episodes/${episodeNo}/put'/>",
		type : 'post',
		enctype: 'multipart/form-data',
		data : formData,
		contentType: false,
		processData: false,
		success : function() {
			location.href= "<c:url value='/dashboard/webtoons/${webtoonId}'/>";
		},
		error : function(err) {
			console.log(err)
		}
	})
}

function upContents(target){
	var curFile = $(target).parent().children("input[type='file']");
	var idx = curFile.attr("name");
	if(idx<=1) return;
	var prevFile = $("input[type='file'][name="+(idx-1)+"]");
	var dt1 = new DataTransfer();
	var dt2 = new DataTransfer();
	if(curFile[0].files.length != 0) dt1.items.add(curFile[0].files[0]);
	if(prevFile[0].files.length != 0) dt2.items.add(prevFile[0].files[0]);
	prevFile[0].files = dt1.files;
	curFile[0].files = dt2.files;
	contentsPreview();
}

function downContents(target){
	var curFile = $(target).parent().children("input[type='file']");
	var idx = curFile.attr("name");
	if(idx>=$(".contents").length) return;
	var nextFile = $("input[type='file'][name="+(Number(idx)+1)+"]");
	var dt1 = new DataTransfer();
	var dt2 = new DataTransfer();
	if(curFile[0].files.length != 0) dt1.items.add(curFile[0].files[0]);
	if(nextFile[0].files.length != 0) dt2.items.add(nextFile[0].files[0]);
	nextFile[0].files = dt1.files;
	curFile[0].files = dt2.files;
	contentsPreview();
}

function validate(){
	var result = true;
	if($("#title").val()==""||$("#title").val()==null) result = false;
	if($("#thumbnailInput")[0].files.length == 0) result = false;
	if(!result) alert("Please check the input box.");
	return result;
}
</script>
<style>
#contentsPreview{
	text-align: center;
	width: 100%;
	height: 400px;
	overflow-y: scroll;
	padding: 20px 0;
}
</style>
</head>
<body>
<%@ include file="../../layout/header.jsp"%>
<%@ include file="../../layout/nav.jsp"%>
<main>
<h2>Webtoon</h2><hr>
<div class="card">
	<script id = "updateEpisodeTemplate" type="text/x-handlebars-template">
	<form id="updateEpisodeForm">
	<table class="table">
		<tr>
			<th>No</th>
			<td>${episodeNo}</td>
			<th>Title</th>
			<td colspan="2"><input type="text" class="form-control" name="title" id="title" value="{{episode.title}}"></td>
		</tr>
		<tr>
			<th>Thumbnail</th>
			<td colspan="4">
				<input type="file" name="thumbnailImage" value="이미지추가" id="thumbnailInput">
				<div id="output" class="mt-3"></div>
			</td>
		</tr>
		<tr>
			<th>Manuscript</th>
			<td colspan="3">
				<input type="button" class="btn btn-warning btn-sm" value="ADD" onclick="addContents()">
				<div id="contentsList" class="card mt-2">
					{{#each contentsList}}
					<div class="contents">
						<input type="file" name="{{this.idx}}" class="contentsInput" data-image="{{this.image}}" disabled>
						<input type="button" class="btn btn-danger btn-sm float-right" value="REMOVE" onclick="removeContents(this)">
						<input type="button" class="btn btn-outline-secondary btn-sm float-right mr-1" value=" ▼ " onclick="downContents(this)">
						<input type="button" class="btn btn-outline-secondary btn-sm float-right" value=" ▲ " onclick="upContents(this)">
					</div>
					{{/each}}
				</div>
			</td>
			<td width="500px">
				<div id="contentsPreview" class="card"></div>
			</td>
		</tr>
		<tr>
			<td colspan="5" class="text-center">
				<input type="button" class="btn btn-outline-secondary" value="Cancel" onclick="history.go(-1);">
				<input type="button" class="btn btn-primary" id="updateEpisodeButton" value="Edit">
			</td>
		</tr>
	</table>
	</form>
	</script>
</div>
</main>
<%@ include file="../../layout/footer.jsp"%>
</body>
</html>