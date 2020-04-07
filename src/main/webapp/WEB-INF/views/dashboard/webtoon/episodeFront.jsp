<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<script>
$(document).ready(function() {
	$('#insert').on('click', insertEpisode);
	myEpisode();
});
function insertEpisode(){
	var url = "/core/api/webtoons/"+${webtoonId}+"/episodes/insert";
	console.log("url: " + url);
	$.ajax({
		url: url, // core/webtoons
		type: "POST",
		data:{
			no : 0
			,title : "def"
			,webtoon_id : ${webtoonId}
			,thumbnail : "def"
		},
		success: function(data){
			console.log(data);
			location.href="<c:url value='/dashboard/webtoons/"+${webtoonId}+"/episodes/insert'/>"
		},		
		error: function(data){
			console.log("err", data);
		},
		complete: function(){
			console.log("complete");
		}
	})
}
function myEpisode(){
	$.ajax({
		url: "../webtoons", // core/webtoons
		type: "GET",
		data:{
			authorId : "${sessionScope.loginUser.userId}" 
		},
		success: function(data){
			console.log(data);
			output(data);
		},
		error: function(data){
			console.log("err", data);
		},
		complete: function(){
			console.log("complete");
		}
	})
}
function output(data){
	var str="<table border='1'>"
	$.each(data,function(index, items){
		str +="<tr onclick = 'location.href='>"
		str +="<td class ='replynum'>"+items.title+"</td>"
		str +="<td class ='text'>"+items.summary+"</td>"
		str +="<td class ='id'>"+items.hashtag+"</td>"
		str +="<td class ='inputdate'>"+items.mgrhashtag+"</td>"
		str +="<td class ='inputdate'><img src ="+items.thumbnail+"></td>"
		str +="</tr>"	
	})
	str+="</table>"
	$('#episodeList').html(str);
}
</script>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/nav.jsp"%>
<main>
<input type = "button" class="btn btn-primary" id = "insert" value ="에피소드등록">
${webtoonId}
<div id = "episodeList">
</div>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>