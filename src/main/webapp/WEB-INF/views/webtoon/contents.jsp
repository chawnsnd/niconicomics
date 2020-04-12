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
<script src="<c:url value='/resources/js/contents.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap-theme.min.css'/>">
<script src="https://kit.fontawesome.com/74fba7f134.js" crossorigin="anonymous"></script>
<script>
var me;
var showDotpleForm = false;
var contentsList;
$(function(){
	getMe();
	getEpisode();
	initDotple();
	initShowHide();
	$("main").css("height", $(window)[0].innerHeight);
	footerPositionTop = $("footer").offset().top;
	initScroll();
	initHotKey();
})
function getMe(){
	$.ajax({
		url: "<c:url value='/api/users/me'/>",
		method: "get",
		async: false,
		success: function(data){
			me = data;
			bindTemplate($("#settingTemplate"), data);
		},
		error: function(err){
			console.log(err);
		}
	})
}
function clickImage(t, e){
	if(showDotpleForm){
		$("#dotpleForm").remove();
		showDotpleForm = !showDotpleForm;
		return;
	}
	$("#dotpleForm").remove();
	var html = $("#dotpleFormTemplate").html();
	$(t).append(html);
	$("#dotpleForm").on("click", function(e){
		e.stopPropagation();
	})
	$("#dotpleDonateForm").on("click", function(e){
		$(t).css("display", "inline-block");
	})
	var offsetX = e.offsetX; //DB에 넣을때 사용
	var offsetY = e.offsetY; //이미지태그 기준
	$("#dotpleSubmit").on("click", function(e){
		submitDotple($(t).parent().data("idx"), offsetX, offsetY);
		$("#dotpleForm").remove();
		showDotpleForm = false;
	})
	$(t).css("position", "relative");
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
}

function initDotple(){
	$.ajax({
		url: "<c:url value='/api/webtoons/${webtoonId}/episodes/${episodeNo}/dotples'/>",
		method: "get",
		success: function(data){
			for(var i=0; i<contentsList.length; i++){
				$.each(data[i], function(index, dotple){
					$(".image").eq(i-1).css("position", "relative");
					var html = "<div "+
						"style='position: absolute; top: "+dotple.yaxis+"px; left: "+dotple.xaxis+"px;'"+
						"data-num='"+index+"' class='dotple'>"+dotple.contents+"</div>";
					$(".image").eq(i-1).prepend(html);
					$(".image").eq(i-1).css("position", "relative");
					$(".dotple").data("num", index).on("click", function(e){
						e.stopPropagation();
					})
				});
			}
			if(me.showDotple == "SHOW"){
				$(".dotple").show();
			}else if(me.showDotple == "HIDE"){
				$(".dotple").hide();
			}
		},
		error: function(err){
			console.log(err);
		}
	})
}

function getEpisode(){
	$.ajax({
		url: "<c:url value='/api/webtoons/${webtoonId}/episodes/${episodeNo}'/>",
		type: "get",
		async: false,
		success: function(data){
			contentsList = data.contentsList;
			bindTemplate($(contentsTemplate), data.contentsList);
			$(".image").on("click", function(e){
				clickImage(this, e);
			})
		},
		error: function(err){
			console.log(err);
		}
	})
}
<c:if test="${sessionScope.loginUser != null}">
function submitDotple(idx, xAxis, yAxis){
	$.ajax({
		url: "<c:url value='/api/webtoons/${webtoonId}/episodes/${episodeNo}/dotples'/>",
		type: "post",
		data: {
			userId: ${sessionScope.loginUser.userId},
			idx: idx,
			xAxis,
			yAxis,
			contents: $("#dotpleContents").val()
		},
		success: function(result){
			sock.send(JSON.stringify({
				userId: ${sessionScope.loginUser.userId},
				webtoonId: ${webtoonId},
				type: "DOTPLE",
				message: "${sessionScope.loginUser.nickname}님이 닷플을 남겼습니다."
			}))
			$(".dotple").remove();
			initDotple();
		},
		error: function(err){
			console.log(err);
		}
	})
}
</c:if>
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
<script id="dotpleFormTemplate" type="text/x-handlebars-template">
	<div id="dotpleForm">
	<div><input type="text" id="dotpleContents"></div>
	<div><label><input type="checkbox">후원</label></div>
	<div id="dotpleDonateForm"><span>후원금액</span><input type="number"></div>
	<div><button style="float: right;" id="dotpleSubmit" class="btn btn-primary btn-sm">등록</button></div>
	</div>
</script>
<script id="contentsTemplate" type="text/x-handlebars-template">
<div class="contents" id="contents">
	{{#each .}}
	<div class="image_container" data-idx={{idx}}>
		<div class="image">
			<img src="{{image}}" width="700px">
		</div>
	</div>
	{{/each}}
</div>
</script>
<script id="dotpleTemplate" type="text/x-handlebars-template">
	<div class="dotple">{{contents}}</div>
</script>
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