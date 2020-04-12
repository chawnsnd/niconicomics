<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../layout/global.jsp"%>
<script type="text/javascript">
$(function() {
	$("#insertWebtoonButton").on('click', insertWebtoon);
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
</script>
</head>
<body>
	<%@ include file="../layout/header.jsp"%>
	<%@ include file="../layout/nav.jsp"%>
	<main>
		<form id="insertWebtoonForm">
		<table border="1">
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" id="title"></td>
			</tr>
			<tr>
				<th>요약</th>
				<td><input type="text" name="summary" id="summary"></td>
			</tr>
			<tr>
				<th>해시태그</th>
				<td><input type="text" id="hashtag" name="hashtag"></td>
			</tr>
			<tr>
				<th>썸네일</th>
				<td>
					<input type="file" name="thumbnailImage" value="이미지추가" id="thumbnailInput">
					<div id="output"></div>
				</td>
			</tr>
			<tr>
				<td><input type="button" id="insertWebtoonButton" value="등록"></td>
			</tr>
		</table>
		</form>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>