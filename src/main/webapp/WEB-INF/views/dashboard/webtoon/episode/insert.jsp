<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../../layout/global.jsp"%>
<script type="text/javascript">
$(function() {
	$("#insertEpisodeButton").on('click', insertEpisode);
	$("#thumbnailInput").on('change', thumbnailPreview);
	$(".contentsInput").on('change', contentsPreview);
})

function addContents(){
	var curIdx = $(".contents").length;
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
		var reader = new FileReader();
		reader.onload = function (e) {
			$('#contentsPreview').append("<div><img src='"+e.target.result+"' width='50%'></div>");
		}
		if($(inp)[0].files.length != 0) reader.readAsDataURL($(inp)[0].files[0]);
	});
}

function thumbnailPreview(){
	var reader = new FileReader();
	reader.onload = function (e) {
		$('#output').html("<img src='"+e.target.result+"' width='120px'>");
	}
	reader.readAsDataURL($("#thumbnailInput")[0].files[0]);
}

function insertEpisode() {
	var form = $('#insertEpisodeForm')[0];
	var formData = new FormData(form);
	$.ajax({
		url : "<c:url value='/api/webtoons/${webtoonId}/episodes/${episodeNo}'/>",
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
	<form id="insertEpisodeForm">
	<table class="table">
		<tr>
			<th>No</th>
			<td>${episodeNo}</td>
			<th>Title</th>
			<td colspan="2"><input type="text" class="form-control" name="title" id="title"></td>
		</tr>
		<tr>
			<th>Thumbnail</th>
			<td colspan="4">
				<input type="file" name="thumbnailImage" value="이미지추가" id="thumbnailInput">
				<div id="output" class="mt-3"></div>
			</td>
		</tr>
		<tr>
			<th>원고등록</th>
			<td colspan="3">
				<input type="button" class="btn btn-warning btn-sm" value="ADD" onclick="addContents()">
				<div id="contentsList" class="card mt-2">
					<div class="contents">
						<input type="file" name="1" class="contentsInput">
						<input type="button" class="btn btn-danger btn-sm float-right" value="REMOVE" onclick="removeContents(this)">
						<input type="button" class="btn btn-outline-secondary btn-sm float-right mr-1" value=" ▼ " onclick="downContents(this)">
						<input type="button" class="btn btn-outline-secondary btn-sm float-right" value=" ▲ " onclick="upContents(this)">
					</div>
				</div>
			</td>
			<td width="500px">
				<div id="contentsPreview" class="card"></div>
			</td>
		</tr>
		<tr>
			<td colspan="5" class="text-center">
				<input type="button" class="btn btn-outline-secondary" value="Cancel" onclick="history.go(-1);">
				<input type="button" class="btn btn-primary" id="insertEpisodeButton" value="Post">
			</td>
		</tr>
	</table>
	</form>
</div>
</main>
<%@ include file="../../layout/footer.jsp"%>
</body>
</html>