<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<script>
var currentPage = 1;
var totalPageCount = 1;

$(document).ready(function() {
	$('#insert').on('click', insertWebtoon);
	getWebtoons(1);
});

function insertWebtoon(){
	location.href="<c:url value='/dashboard/webtoons/insert'/>"
}

function deleteWebtoon(webtoonId){
	$.ajax({
		url : "<c:url value='/api/webtoons/'/>"+webtoonId,
		method : "delete",
		success : function(){
			location.reload();
		},
		error : function(err){
			console.log(err)
		}
	})
}

function updateWebtoon(webtoonId){
	location.href = "<c:url value='/dashboard/webtoons/"+webtoonId+"/update'/>"
}

function getWebtoons(curPage){
	$.ajax({
		url: "<c:url value='/api/webtoons'/>", // core/webtoons
		type: "GET",
		data:{
			authorId : "${sessionScope.loginUser.userId}"
		},
		success: function(data){
			console.log(data);
			$("#webtoonList").remove();
			$("#navi").remove();
			bindTemplate($('#naviTemplate'), data.navi);
			bindTemplate($('#webtoonListTemplate'), data.webtoonList);
			currentPage = (data.navi.currentPage == 0) ? 1 : data.navi.currentPage;
			totalPageCount = (data.navi.totalPageCount == 0) ? 1 : data.navi.totalPageCount;
		},
		error: function(err){
			console.log(err);
		}
	})
}
</script>
<style>
.image_container{
	width: 80px;
	height: 50px;
	background-size: cover;
	background-position: center;
}
</style>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
<%@ include file="../layout/nav.jsp"%>
<main>
<h2>Webtoon</h2><hr>
<div class="card">
	<div class="card-body">
		<p class="card-title float-left">
			<input type = "button" class="btn btn-primary" id = "insert" value ="Enroll Webtoon">
		</p>
		<script id="naviTemplate" type="text/x-handlebars-template">
		<div id="navi" class="float-right">
			<div class="input-group" style="width: 150px;">
				<div class="input-group-prepend" id="idx"><span class="input-group-text">{{currentPage}} / {{totalPageCount}}</span></div>
				<div class="input-group-append">
					<button class="btn btn-secondary btn-sm" onclick="getEpisodes({{currentPage}}-1)">prev</button>
					<button class="btn btn-secondary btn-sm" onclick="getEpisodes({{currentPage}}+1)">next</button>
				</div>
			</div>
		</div>
		</script>
		<script id="webtoonListTemplate" type="text/x-handlebars-template">
		<table id="webtoonList" class="table">
			<tr>
				<th>
					Thumbnail
				</th>
				<th width="70%">
					Title
				</th>
				<th>
					Reg Date
				</th>
			</tr>
			{{#each .}}
			<tr onclick = "location.href = '../dashboard/webtoons/{{webtoonId}}'">
				<td>
					<div class="image_container" style="background-image: url({{thumbnail}})"></div>
				</td>
				<td>
					{{title}}
				</td>
				<td>
					{{regDate}}
				</td>
			</tr>
			{{/each}}
		</table>
		</script>
	</div>
</div>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>