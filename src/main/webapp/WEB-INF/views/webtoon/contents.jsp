<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" type="image/png" href="<c:url value='/resources/favicon.png'/>">
<script src="<c:url value='/resources/js/jquery-3.4.1.min.js'/>"></script>
<script src="<c:url value='/resources/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/resources/js/handlebars-v4.7.3.js'/>"></script>
<script src="<c:url value='/resources/js/handlebars-custom.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap-theme.min.css'/>">
<script src="https://kit.fontawesome.com/74fba7f134.js" crossorigin="anonymous"></script>
<script>
$(function(){
	$("img").on("click",function(e){
		dotple(e);
	})
	$("#toggleChatroom").on("click", function(){
		$("#chatroom").toggle();
	})
})
function toggleHeaderFooter(){
	$("header").toggle();
	$("footer").toggle();
	$("#chatroom").toggle();
}
function dotple(e){
	var offsetX = e.offsetX; //DB에 넣을때 사용
	var offsetY = e.offsetY; //이미지태그 기준
	var clientX = e.clientY; //닷플창 띄울 떄 사용
	var clientY = e.clientY; //브라우저 기준
	console.log(offsetX, offsetY);
}
</script>
<style>
.header_container{
	border-bottom: 1px solid #a3a3a3;
}
.header_container > *{
	display: inline-block;
}
.logo{
	padding: 5px 10px;
	background-color: #fbc714;
	font-weight: bold;
	font-size: 20px;
	cursor: pointer;
}
.title{
	width: 90vw;
}
.menu_item{
	display: inline-block;
	font-size: 20px;
	border: 1px solid #a3a3a3;
	cursor: pointer;
}
.image{
	margin: 0;
}
.contents{
	height: 87vh;	
	padding: 60px 0;
	margin: auto;
	text-align: center;
	overflow-y: auto;
	flex: 5;
}
.contents::-webkit-scrollbar { 
    display: none; 
}
.footer_container{
	display: flex;
	border: 1px solid #a3a3a3;
}
.footer_container > * {
	cursor: pointer;
	text-align: center;
	flex: 1;
}
main{
	display: flex;
}
.chatroom{
	border-left: 1px solid #a3a3a3;
	flex: 1;
}
</style>
</head>
<body>
<header>
<div class="header_container">
	<div class="logo" onclick="location.href='<c:url value="/"/>'">ニコ<br>ニコ</div>
	<div class="title" onclick="location.href='<c:url value="/webtoons/${webtoonId}"/>'">펭수펭하</div>
	<div class="menu">
		<div class="menu_item" id="toggleDotple">DOTPLE</div>
		<div class="menu_item" id="toggleChatroom">CHAT</div>
		<div class="menu_item" id="support" data-toggle="modal" data-target="#supportModal">SUPPORT</div>
	</div>
</div>
</header>
<main>
<div class="contents" onclick="toggleHeaderFooter()">
	<div class="image">
		<img src="/core/resources/images/ps.jpg" width="700px">
	</div>
	<div class="image">
		<img src="/core/resources/images/ps.jpg" width="700px">
	</div>
	<div class="image">
		<img src="/core/resources/images/ps.jpg" width="700px">
	</div>
	<div class="image">
		<img src="/core/resources/images/ps.jpg" width="700px">
	</div>
	<div class="image">
		<img src="/core/resources/images/ps.jpg" width="700px">
	</div>
</div>
<div class="chatroom" id="chatroom">
<%@ include file="./chat.jsp"%>
</div>
</main>
<footer class="footer_container">
	<div class="item" id="prev">prev</div>
	<div class="item" id="next">next</div>
</footer>
</body>
<%@ include file="./modal.jsp"%>
</html>