<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../layout/global.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$("#bts1").on('click', insertWebtoon);
	})
	var images = [];
	var index = 1;
	var imageTypes = [ 'image/png', 'image/gif', 'image/jpeg', 'image/bmp',
			'image/x-icon' ];
	var thumbnailPath;
	$(function() {
		$("#uploadInput").on("change", function() {
			uploadImage(this.files[0]);
		})
	})
	function uploadImage(file) {
		if (!isImage(file)) {
			return alert("지원하지 않는 형식입니다..");
		}

		var form = $('#uploadForm')[0];
		var formData = new FormData(form);
		
		$.ajax({
			url :'<c:url value="/api/webtoons/'+${sessionScope.newWebtoon.webtoonId}+'/thumbnail"/>' ,
			method : "post",
			data : formData,
			async : false,
			contentType : false,
			processData : false,
			success : function(data) {

				thumbnailPath = data
				console.log(thumbnailPath)
				$("#output").html(
						"<img src = '"+data+"'><button onclick='deleteImage(`"
								+ data + "`)'>삭제</button>")
			},
			error : function(err) {
				console.log("이미지 저장 실패", err);
			}
		})
	}

	function deleteImage(path) {
		$.ajax({
			url : "/core/file-delete-test",
			method : "post",
			data : {
				path : path
			},
			success : function() {
				console.log("삭제성공");
				$("#output").html("");

			}
		})
	}
	function isImage(file) {
		if (imageTypes.indexOf(file.type) < 0) {
			return false;
		} else {
			return true;
		}
	}
	function insertWebtoon(data) {

		var title = $("#title").val();
		var hashtag = $("#hashtag").val();
		var summary = $("#summary").val();
		var thumbnailUp = thumbnailPath;
		console.log(thumbnailUp);
		var data = {
				title : title,
				hashtag : hashtag,
				summary : summary,
				thumbnail : thumbnailUp,
				authorId : "${sessionScope.loginUser.userId}"
		};
		$.ajax({
			url : "<c:url value='/api/webtoons/"+${sessionScope.newWebtoon.webtoonId}+"'/>",
			type : 'patch',
			data : JSON.stringify(data),
			contentType : 'application/json',
			success : function() {
				alert('등록성공')
				location.href = "<c:url value='/dashboard/webtoons'/>";
			},
			error : function() {
				alert('실패')
			}
		})
	}
</script>
</head>
<body>
	<%@ include file="../layout/header.jsp"%>
	<%@ include file="../layout/nav.jsp"%>
	<main>
		<table>
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
					<td><input type="text" id="hashtag" "name="hashtag"></td>
				</tr>
				<tr>
					<th>썸네일</th>
					<td><form id="uploadForm">
							<!-- <input type="number" name="index"> -->
							<input type="file" name="image" value="이미지추가" id="uploadInput">
						</form>
						<div id="output"></div></td>
				</tr>
				<tr>
					<td><input type="button" id="bts1" value="등록"></td>
				</tr>
			</table>
			
	</main>
	<%@ include file="../layout/footer.jsp"%>
</body>
</html>