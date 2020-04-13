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
			$("#thumbnailInput").on('change', thumbnailPreview);
		},
		error : function(err) {
			console.log(err);
		}
	})
}	

function thumbnailPreview(){
	var reader = new FileReader();
	reader.onload = function (e) {
		$('#output').html("<img src='"+e.target.result+"' width='200px'>");
	}
	reader.readAsDataURL($("#thumbnailInput")[0].files[0]);
}

function updateWebtoon() {
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
		<form id="updateWebtoonForm">
		<table border="1">
			<script id = "webtoonTemplate" type="text/x-handlebars-template">
			<tr>
				<th>제목</th>
				<td><input type="text" value = "{{title}}" name="title" id="title"></td>
			</tr>
			<tr>
				<th>요약</th>
				<td><input type="text" value = "{{summary}}" name="summary" id="summary"></td>
			</tr>
			<tr>
				<th>해시태그</th>
				<td><input type="text" id="hashtag" value ="{{hashtag}}" name="hashtag"></td>
			</tr>
			<tr>
				<th>썸네일</th>
				<td>
					<input type="file" name="thumbnailImage" id="thumbnailInput">
					<div id="output">
						<img id="thumbnail" src = '{{thumbnail}}' width='200px'>
					</div>
				</td>
			</tr>
			</script>
			<tr>
				<td>
					<input type="button" id="updateWebtoonButton" value="수정">
				</td>
			</tr>
		</table>		
		</form>
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>