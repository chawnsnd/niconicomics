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
})

function addContents(){
	var curIdx = $(".contents").last().data("idx");
	var html = '<div class="contents" data-idx='+(curIdx+1)+'>'+
					'<input type="file" name="'+(curIdx+1)+'" class="contentsInput">'+
				'</div>';
	$(".contents").last().after(html);
}

function removeContents(){
	if($(".contents").length != 1){
		$(".contents").last().remove();
	}
}

function contentsPreview(){
	$('#contentsPreview').html("");
	$('.contentsInput').each(function(i, inp){
		var reader = new FileReader();
		reader.onload = function (e) {
			$('#contentsPreview').append("<div><img src='"+e.target.result+"' width='400px'></div>");
		}
		reader.readAsDataURL($(inp)[0].files[0]);
	});
}

function thumbnailPreview(){
	var reader = new FileReader();
	reader.onload = function (e) {
		$('#output').html("<img src='"+e.target.result+"' width='200px'>");
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
</script>
<style>
main{
	position: relative;
}
#contentsPreview{
	position: absolute;
	top: 10px;
	right: 30px;
}
</style>
</head>
<body>
	<%@ include file="../../layout/header.jsp"%>
	<%@ include file="../../layout/nav.jsp"%>
	<main>
		<form id="insertEpisodeForm">
		<table border="1">
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" id="title"></td>
			</tr>
			<tr>
				<th>썸네일</th>
				<td>
					<input type="file" name="thumbnailImage" value="이미지추가" id="thumbnailInput">
					<div id="output"></div>
				</td>
			</tr>
			<tr>
				<th>원고등록</th>
				<td>
					<input type="button" value="ADD" onclick="addContents()">
					<input type="button" value="REMOVE" onclick="removeContents()">
					<input type="button" value="PREVIEW" onclick="contentsPreview()">
					<div class="contents" data-idx=1>
						<input type="file" name="1" class="contentsInput">
					</div>
				</td>
			</tr>
			<tr>
				<td><input type="button" id="insertEpisodeButton" value="등록"></td>
			</tr>
		</table>
		</form>
		<div id="contentsPreview"></div>
	</main>
	<%@ include file="../../layout/footer.jsp"%>
</body>
</html>