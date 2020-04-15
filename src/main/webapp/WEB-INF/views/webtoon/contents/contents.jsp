<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<c:url value='/resources/js/jquery-3.4.1.min.js'/>"></script>
<script src="<c:url value='/resources/js/bootstrap/bootstrap.bundle.min.js'/>"></script>
<script src="<c:url value='/resources/js/bootstrap/bootstrap.min.js'/>"></script>
<script src="<c:url value='/resources/js/bootstrap/tagsinput.js'/>"></script>
<script src="<c:url value='/resources/js/handlebars-v4.7.3.js'/>"></script>
<script src="<c:url value='/resources/js/handlebars-custom.js'/>"></script>
<script src="<c:url value='/resources/js/contents.js'/>"></script>
<script src="<c:url value='/resources/js/component.js'/>"></script>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap/bootstrap-grid.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap/bootstrap-reboot.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap/tagsinput.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap/bootstrap.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/handlebars.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/component.css'/>">
<script src="https://kit.fontawesome.com/74fba7f134.js" crossorigin="anonymous"></script>
<script>

var me;
var webtoon;
var episode;
var contentsList;

$(function(){
	$("main").height($(window)[0].innerHeight);
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

function clickImage(e){
	var st = $(".contents")[0].scrollTop;
	e = e || window.event;
	e.stopPropagation();
	e.preventDefault();
	var target = event.currentTarget;
	$("#dotpleForm").remove();
	$(target).append('<div id="dotpleForm" style="width: 250px" data-idx='+$(target).data('idx')+' data-xAxis='+e.offsetX+' data-yAxis='+e.offsetY+'>'+
	'<input class="form-control" type="text" id="dotpleContents" placeholder="message" onkeyup="enterDotple()">'+
	'<div class="input-group">'+
		'<div class="input-group-prepend">'+
			'<div class="input-group-text">'+
			'<input type="checkbox" onclick="toggleDotpleDonate()">'+
			'</div>'+
		'</div>'+
		'<input id="inputNico" type="number" class="form-control d-none">'+
		'<div id="dotpleNico" class="input-group-append d-none">'+
		'<span class="input-group-text">'+me.nico+'/ Nico</span>'+
		'</div>'+
		'<div id="noneCheck" class="input-group-append">'+
			'<span class="input-group-text">Check donation</span>'+
		'</div>'+
	'</div>'+
	'<button class="btn btn-primary btn-block" id="dotpleSubmit" onclick="submitDotple()" class="btn btn-primary btn-sm">Submit</button>'+
	'</div>');
	$("#dotpleContents").focus();
	$("#dotpleForm").on("click", function(e){
		e.stopPropagation();
		e.preventDefault();
	})
	$("#dotpleForm").css({
		"text-align": "left",
		"position": "absolute",
		"background-color": "white",
		"display": "inline-block",
		"z-index": 9,
		"top": e.offsetY,
		"left": e.offsetX
	});
	$(".contents").scrollTop(st);
}

function toggleDotpleDonate(){
	$("#inputNico").val(0);
	if($("#dotpleNico").hasClass("d-none")){
		$("#dotpleNico").removeClass("d-none")
		$("#inputNico").removeClass("d-none")
		$("#noneCheck").addClass("d-none")
	}else{
		$("#dotpleNico").addClass("d-none")
		$("#inputNico").addClass("d-none")
		$("#noneCheck").removeClass("d-none")
	}
}

function deleteDotple(dotpleId){
	$.ajax({
		url: "<c:url value='/api/webtoons/${webtoonId}/episodes/${episodeNo}/dotples/'/>"+dotpleId,
		method: "delete",
		success: function(data){
			$(".dotple[data-dotpleid="+dotpleId+"]").remove();
		}
	})
}

function createDotple(dotple){
	var dotpleHtml = $("<div style='z-index: 8; position: absolute; top: "+dotple.yaxis+"px; left: "+dotple.xaxis+"px;'"+
	"class='dotple' data-dotpleid="+dotple.dotpleId+">"+dotple.contents+"</div>");
	if(dotple.userId == me.userId){
		dotpleHtml.addClass("mydotple");
		dotpleHtml.html(dotpleHtml.html()+" <i class='far fa-times-circle'></i>");
		dotpleHtml.attr("onclick", "deleteDotple("+dotple.dotpleId+")")
	}
	if(dotple.type == "DONATE"){
		dotpleHtml.addClass("donateDotple");
		dotpleHtml.html("<i class='fas fa-money-bill-wave'></i> "+dotpleHtml.html());
	}
	$(dotpleHtml).appendTo(".image[data-idx="+dotple.idx+"]");
	$(".dotple").on("click", function(e){e.stopPropagation();})
	settingDotple();
}

function initDotple(){
	return new Promise(function(resolve, reject){
		$.ajax({
			url: "<c:url value='/api/webtoons/${webtoonId}/episodes/${episodeNo}/dotples'/>",
			method: "get",
			success: function(data){
				$.each(data, function(index, dotple){
					createDotple(dotple);
				});
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
		},
		error: function(err){
			console.log(err);
		}
	})
}
function enterDotple(e){
	e = e || window.event;
	if(e.keyCode == 13) {
		e.preventDefault();
		$('#dotpleSubmit').trigger('click');
	}
}

function submitDotple(e){
	e = e || window.event;
	var idx = $(e.target).parent().data("idx");
	var xAxis = $(e.target).parent().data("xaxis");
	var yAxis = $(e.target).parent().data("yaxis");
	var contents = $("#dotpleContents").val();
	if(me == ''){
		alert("Please login.");
		return;
	}else{
		var nico = Number($("#inputNico").val());
		var data = {
				userId: me.userId,
				idx: idx,
				xAxis: xAxis,
				yAxis: yAxis,
				contents: contents,
				nico: nico
		};
		$.ajax({
			url: "<c:url value='/api/webtoons/${webtoonId}/episodes/${episodeNo}/dotples'/>",
			type: "post",
			data: data,
			success: function(data){
				var message = "${sessionScope.loginUser.nickname} left a dotple.";
				if(nico > 0){
					message = "${sessionScope.loginUser.nickname} left a dotple width "+nico+" Nico donation."
				}
				sock.send(JSON.stringify({
					userId: me.userId,
					webtoonId: ${webtoonId},
					type: "DOTPLE",
					message: message
				}))
				$("#dotpleForm").remove();
				getMe();
				createDotple(data);
			},
			error: function(err){
				console.log(err);
			}
		})
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
.mydotple{
	border: 1px solid #fbc714;
	cursor: pointer;
}
.donateDotple{
	border: 1px solid #e83d3d;
}
#dotpleForm{
	border: 1px solid #eaeaea;
}
</style>
</head>
<body>
<%@ include file="./header.jsp"%>
<main>
<script id="contentsTemplate" type="text/x-handlebars-template">
<div class="contents" id="contents">
	{{#each .}}
	<div class="image_container">
		<div class="image" data-idx={{idx}} onclick="clickImage()">
			<img src="{{image}}" width="700px">
		</div>
	</div>
	{{/each}}
</div>
</script>
<div class="chatroom" id="chatroom">
<%@ include file="./chat.jsp"%>
</div>
</main>
<%@ include file="./footer.jsp"%>
</body>
<%@ include file="./modal.jsp"%>
</html>