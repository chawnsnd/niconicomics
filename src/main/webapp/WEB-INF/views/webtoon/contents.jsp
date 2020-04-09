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
var dotpleTemp = [{
	dotpleId: 1,
	userId: 2,
	contentsId: 1,
	contents: "ㅎㅎㅎㅎ",
	xAxis: 23,
	yAxis: 42
},{
	dotpleId: 2,
	userId: 3,
	contentsId: 3,
	contents: "ㅋㅋㅋㅋ",
	xAxis: 123,
	yAxis: 65
}];
var hide = false;
var showDotpleForm = false;
var footerPositionTop;
var fullScreen = false;
$(function(){
	$("main").css("height", $(window)[0].innerHeight);
	footerPositionTop = $("footer").offset().top;
	initDotple();
	initScroll();
	initHotKey();
	$(".image").on("click",function(e){
		if(showDotpleForm){
			$("#dotpleForm").remove();
			showDotpleForm = !showDotpleForm;
			return;
		}
		$("#dotpleForm").remove();
		var html = $("#dotpleFormTemplate").html();
		$(this).append(html);
		$("#dotpleForm").on("click", function(e){
			e.stopPropagation();
		})
		$("#dotpleDonateForm").on("click", function(e){
			$(this).css("display", "inline-block");
		})
		$("#dotpleSubmit").on("click", function(e){
			$("#dotpleForm").remove();
			showDotpleForm = false;
		})
		var offsetX = e.offsetX; //DB에 넣을때 사용
		var offsetY = e.offsetY; //이미지태그 기준
		$(this).css("position", "relative");
		$("#dotpleForm").css({
			"text-align": "left",
			"position": "absolute",
			"background-color": "white",
			"display": "inline-block",
			"z-index": 9,
			"border": "2px solid #a3a3a3",
			"top": offsetY,
			"left": offsetX
		});
		showDotpleForm = true;
	})
	
})
function initScroll(){
	$(window).on("mousemove", function(e){
		if(hide){
			if(e.pageY<=$("header").outerHeight()){
				$("header").show();
			}else{
				$("header").hide();
			}
			if(e.pageY>=footerPositionTop){
				$("footer").show();
			}else{
				$("footer").hide();
			}
		}
	})
	$("#contents").on("scroll", function(e){
		var st = $(this).scrollTop();
		var sh = $(this)[0].scrollHeight;
		var oh = $(this).outerHeight();
		if(st >= $("header").outerHeight()){
			$("header").hide();
			$("footer").hide();
			hide = true;
		}else{
			$("header").show();
			$("footer").show();
			hide = false;
		}
		if(sh-st == oh){
			$("header").show();
			$("footer").show();
			hide = false;
		}
	});
}
function toggleChatroom(e){
	$("#chatroom").toggle();
}
function toggleDotple(){
	$(".dotple").toggle();
}
function initDotple(){
	$.each(dotpleTemp, function(index, dotple){
		var html = "<div data-num='"+index+"' class='dotple'>"+dotple.contents+"</div>";
		$(".image").eq(dotple.contentsId-1).prepend(html);
		$(".dotple").data("num", index).css({
			"top": dotple.yAxis,
			"left": dotple.xAxis
		})
		$(".dotple").data("num", index).on("click", function(e){
			e.stopPropagation();
		})
	})
}
function initHotKey(){
	$(document).keydown(function(e){
		if(e.keyCode == 27){
			$("#dotpleForm").remove();
			showDotpleForm = false;
		}
	})
	$(document).dblclick(function() {
		var docV = document.documentElement;
		if(!fullScreen){
			if (docV.requestFullscreen)
		        docV.requestFullscreen();
		    else if (docV.webkitRequestFullscreen) // Chrome, Safari (webkit)
		        docV.webkitRequestFullscreen();
		    else if (docV.mozRequestFullScreen) // Firefox
		        docV.mozRequestFullScreen();
		    else if (docV.msRequestFullscreen) // IE or Edge
		        docV.msRequestFullscreen();
			$("main").css("height", $(window)[0].outerHeight);
			fullScreen = true;
		}else{
			if (document.exitFullscreen)
		        document.exitFullscreen();
		    else if (document.webkitExitFullscreen) // Chrome, Safari (webkit)
		        document.webkitExitFullscreen();
		    else if (document.mozCancelFullScreen) // Firefox
		        document.mozCancelFullScreen();
		    else if (document.msExitFullscreen) // IE or Edge
		        document.msExitFullscreen();
			$("main").css("height", $(window)[0].innerHeight);
			fullScreen = false;
		}
	})
}
</script>
<style>
header{
	background-color: white;
	border-bottom: 1px solid #a3a3a3;
	display: flex;
	position: absolute;
	top:0;
	left:0;
	height: 40px;
	width: 100%;
	z-index: 9;
}
main{
	display: flex;
}
footer{
	position: absolute;
	heigth: 40px;
	bottom: 0;
	width: 100%;
	z-index: 9;
	border: 1px solid #a3a3a3;
	display: flex;
	background-color: white;
}
header *{
	display: inline-block;
}
.logo{
	padding: 5px 10px;
	background-color: #fbc714;
	font-weight: bold;
	font-size: 20px;
	cursor: pointer;
	display: inline-block;
}
.title{
	display: inline-block;
	vertical-align: middle;
	margin: auto;
	flex: 8;
	cursor: pointer;
	padding-left: 10px;
}
.menu_item{
	font-size: 20px;
	display: inline-block;
	vertical-align: middle;
	text-align: center;
	cursor: pointer;
	height: 100%;
	font-weight: bold;
}
.menu{
	padding-right: 5px;
}
.menu_item:hover{
	color: #fbc714;
}
.image{
	display: inline-block;
	margin: 0;
	position: relative;
}
.image > img{
	width: 700px;
}
.image_container:first-of-type{ 
 	margin-top: 80px; 
} 
.image_container:last-of-type{ 
 	margin-bottom: 80px; 
} 
.contents{
	margin: 0 auto;
	text-align: center;
	overflow-y: auto;
	flex: 5;
}
.contents::-webkit-scrollbar { 
    display: none; 
}
footer > * {
	cursor: pointer;
	text-align: center;
	flex: 1;
}
.chatroom{
	border-left: 1px solid #a3a3a3;
	flex: 1;
	overflow-y: auto;
}
#dotpleFormTemplate{
	display: none;
}
.dotple{
	display: inline-block;
	position: absolute;
	z-index: 9;
	opacity: 0.7;
	background-color: white;
	padding: 3px;
	border: 1px solid #eaeaea;
	border-radius: 5px;
	cursor: default;
}
</style>
</head>
<body>
<header>
	<div class="logo" onclick="location.href='<c:url value="/"/>'">ニコニコ</div>
	<div class="title" onclick="location.href='<c:url value="/webtoons/${webtoonId}"/>'">펭수펭하 ${episodeNo}화</div>
	<div class="menu">
		<div class="menu_item" id="toggleDotple" onclick="toggleDotple()">DOTPLE</div>
		<div class="menu_item" id="toggleChatroom" onclick="toggleChatroom()">CHAT</div>
		<div class="menu_item" id="support" data-toggle="modal" data-target="#supportModal">DONATE</div>
	</div>
</header>
<main>
<script id="dotpleFormTemplate">
	<div id="dotpleForm">
	<div><input type="text"></div>
	<div><label><input type="checkbox">후원</label></div>
	<div id="dotpleDonateForm" style="display: none;"><span>후원금액</span><input type="number"></div>
	<div><button style="float: right;" id="dotpleSubmit" class="btn btn-primary btn-sm">등록</button></div>
	</div>
</script>
<div class="contents" id="contents">
	<script id="dotpleTemplate">
		<div class="dotple">{{contents}}</div>
	</script>
	<div class="image_container">
		<div class="image">
			<img src="/core/resources/images/ps.jpg" width="700px">
		</div>
	</div>
	<div class="image_container">
		<div class="image">
			<img src="/core/resources/images/ps.jpg" width="700px">
		</div>
	</div>
	<div class="image_container">
	<div class="image">
		<img src="/core/resources/images/ps.jpg" width="700px">
	</div>
	</div>
	<div class="image_container">
		<div class="image">
			<img src="/core/resources/images/ps.jpg" width="700px">
		</div>
	</div>
	<div class="image_container">
		<div class="image">
			<img src="/core/resources/images/ps.jpg" width="700px">
		</div>
	</div>
</div>
<div class="chatroom" id="chatroom">
<%@ include file="./chat.jsp"%>
</div>
</main>
<footer>
	<div class="item" id="prev" onclick="location.href='./${episodeNo - 1}'">prev</div>
	<div class="item" id="next" onclick="location.href='./${episodeNo + 1}'">next</div>
</footer>
</body>
<%@ include file="./modal.jsp"%>
</html>