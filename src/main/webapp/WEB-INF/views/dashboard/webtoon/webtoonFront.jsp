<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<script>
$(document).ready(function() {
	$('#insert').on('click', insertWebtoons);
	
});
function insertWebtoons(){
	$.ajax({
		url: "../webtoons", // core/webtoons
		type: "POST",
		data:{
			title : "def"
			,summary : "def"
			,hashtag : "def"
			,mgrHashtag : "def"
			,thumbnail : "def"
		},
		success: function(data){
			console.log("asdf");
			location.href="webtoons/insert";
		},
		error: function(data){
			console.log("err", data);
		},
		complete: function(){
			console.log("complete");
		}
	})
}
</script>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/nav.jsp"%>
<main>
<input type = "button" class="btn btn-primary" id = "insert" value ="웹툰등록">
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>