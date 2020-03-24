<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>webtoonInsert</title>
<script src="./resources/js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#bts1").on('click', insert);
	})
	function insert(){
		alert("실행합니다.");
		$.ajax({
			url : 'insertWebtoon'
			,type : 'POST'
			,data : {
				title : title,
				hashtag : hashtag,
				summary : summary
				thumbnail :  thumbnail
			},
			,success : function(){
				alert('등록성공')
			}
			,error : function(){
				alert('실패')
			} 
		})
	}
</script>
</head>
<body>
	<table>
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
		<td><input type="file" name="thumbnail" size="30"></td>
		</tr>
		<tr>
		<input type = "button" id="bts1" value="등록">
		</tr>
	</table>
</body>
</html>