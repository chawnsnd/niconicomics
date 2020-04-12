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
var webtoon;
var episode;
var contentsList;
var showDotpleForm = false;

$(function(){
	getMe();
	getWebtoon();
	getEpisode();
	initDotple().then(function(){
		if(me.showDotple == "SHOW"){
			$(".dotple").show();
		}else if(me.showDotple == "HIDE"){
			$(".dotple").hide();
		}
	});
	initShowHide();
	$("main").css("height", $(window)[0].innerHeight);
	footerPositionTop = $("footer").offset().top;
	initScroll();
	initHotKey();
})
function getWebtoon(){
	$.ajax({
		url: "<c:url value='/api/webtoons/${webtoonId}'/>",
		type: "get",
		async: false,
		success: function(data){
			webtoon = data;
			bindTemplate($("#titleTemplate"), data);
			$("#titleTemplate").remove();
		},
		error: function(err){
			console.log(err);
		}
	})
}
function getMe(){
	$.ajax({
		url: "<c:url value='/api/users/me'/>",
		method: "get",
		async: false,
		success: function(data){
			me = data;
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
	$("#dotpleContents").focus();
	$("#dotpleForm").on("click", function(e){
		e.stopPropagation();
	})
	$("#dotpleContents").on("keydown", function(e){
		if(e.keyCode == 13) $("#dotpleSubmit").trigger("click");
	})
	$("#dotpleDonateForm").on("click", function(e){
		$(t).css("display", "inline-block");
	})
	var offsetX = e.offsetX;
	var offsetY = e.offsetY;
	$("#dotpleSubmit").on("click", function(e){
		e.stopPropagation();
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
	return new Promise(function(resolve, reject){
		$.ajax({
			url: "<c:url value='/api/webtoons/${webtoonId}/episodes/${episodeNo}/dotples'/>",
			method: "get",
			success: function(data){
				for(var i=0; i<contentsList.length; i++){
					$.each(data[i], function(index, dotple){
						$(".image").eq(i-1).css("position", "relative");
						var html = "<div "+
							"style='position: absolute; top: "+dotple.yaxis+"px; left: "+dotple.xaxis+"px;'"+
							"class='dotple'>"+dotple.contents+"</div>";
						$(".image").eq(i-1).prepend(html);
						$(".image").eq(i-1).css("position", "relative");
						$(".dotple").data("num", index).on("click", function(e){
							e.stopPropagation();
						})
					});
				}
				resolve();
			},
			error: function(err){
				console.log(err);
				reject();
			}
		})
	})
}

function getEpisode(){
	$.ajax({
		url: "<c:url value='/api/webtoons/${webtoonId}/episodes/${episodeNo}'/>",
		type: "get",
		async: false,
		success: function(data){
			contentsList = data.contentsList;
			episode = data.episode;
			bindTemplate($("#contentsTemplate"), data.contentsList);
			$(".image").on("click", function(e){
				clickImage(this, e);
			})
		},
		error: function(err){
			console.log(err);
		}
	})
}
function submitDotple(idx, xAxis, yAxis){
	if(me == ''){
		alert("Please login.");
		return;
	}else{
		$.ajax({
			url: "<c:url value='/api/webtoons/${webtoonId}/episodes/${episodeNo}/dotples'/>",
			type: "post",
			data: {
				userId: me.userId,
				idx: idx,
				xAxis: xAxis,
				yAxis: yAxis,
				contents: $("#dotpleContents").val(),
			},
			success: function(result){
				sock.send(JSON.stringify({
					userId: me.userId,
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
}
function toggleDotpleDonate(){
	if($("#dotpleNico").attr("disabled")){
		$("#dotpleNico").attr("disabled", false);
	}else{
		$("#dotpleNico").attr("disabled", true);
	}
}
</script>
<style>
main{
	display: flex;
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
	flex: 3.5;
}
.contents::-webkit-scrollbar { 
    display: none; 
}
.chatroom{
	border-left: 1px solid #a3a3a3;
	flex: 1;
	overflow-y: hidden;
}
.dotple{
	display: inline-block;
	position: absolute;
	z-index: 8;
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
<%@ include file="./header.jsp"%>
<main>
<script id="dotpleFormTemplate" type="text/x-handlebars-template">
	<div id="dotpleForm" style="width: 250px">
		<input class="form-control" type="text" id="dotpleContents" placeholder="message">
		<button class="btn btn-primary btn-block" id="dotpleSubmit" class="btn btn-primary btn-sm">등록</button>
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
<%@ include file="./footer.jsp"%>
</body>
<%@ include file="./modal.jsp"%>
</html>