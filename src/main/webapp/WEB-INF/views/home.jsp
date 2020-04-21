<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>NICONICOMICS</title>
<%@ include file="./layout/global.jsp"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.min.css">
<script src="https://unpkg.com/swiper/js/swiper.min.js"></script>
<script>
var webtoons;
$(function(){
	bannerSliderSetting();
	getWebtoons().then(function(){
	});
	getNewWebtoons();
	$(".type").on("click", function(){
		getWebtoons($(this).data("type"));
		$(".type").removeClass("active");
		$(this).addClass("active");
	})
})
function getNewWebtoons(){
	$.ajax({
		url: "<c:url value='/api/webtoons'/>",
		method: "get",
		async: false,
		data:{
			currentPage: 1,
			countPerPage: 9,
		},
		success: function(data){
			$("#newWebtoons").remove();
			bindTemplate($("#newWebtoonsTemplate"), data.webtoonList);
		},
		error: function(err){
			console.log(err);
		}
	})
}
function getWebtoons(type){
	return new Promise(function(resolve, reject){
		$.ajax({
			url: "<c:url value='/api/webtoons'/>",
			method: "get",
			async: false,
			data:{
				currentPage: 1,
				CountPerPage: 30,
				hashtags: type
			},
			success: function(data){
				$("#webtoons").remove();
				bindTemplate($("#webtoonsTemplate"), data.webtoonList);
				resolve();
			},
			error: function(err){
				console.log(err);
				reject();
			}
		})
	})
}
</script>
<script>
function bannerSliderSetting(){
	var bannerSlider = new Swiper('#banner-slider', {
		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev',
		},
		pagination: {
	        el: '.swiper-pagination',
      	}
	});
}
</script>
<style>
.swiper-container {
	width: 100%;
	height: 300px;
}
.swiper-slide {
	text-align: center;
	font-size: 18px;
	background: #fff;
	display: flex;
	display: -webkit-box;
	display: -ms-flexbox;
	display: -webkit-flex;
	-webkit-box-pack: center;
	-ms-flex-pack: center;
	-webkit-justify-content: center;
	justify-content: center;
	-webkit-box-align: center;
	-ms-flex-align: center;
	-webkit-align-items: center;
	align-items: center;
	cursor: pointer;
}
</style>
<style>
.item>img{
	max-height: 200px;
}
.left_item{
	padding: 30px 0 15px 0;
}
.item_title{
	font-size: 30px;
	font-weight: bold;
}
.types{
	margin-top: 50px;
}
.type{
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
	padding: 0 10px;
}
.type.active{
	color: #e83d3d
}
.webtoons{
	display: inline-block;
	margin-top: 10px;
	width: 680px;
}
.webtoon{
	display: inline-block;
	cursor: pointer;
	margin-right: 15px;
	margin-top: 15px;
	width: 150px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
.webtoon:hover{
    box-shadow: 0.5px 0.5px 3px 0px black;
}
.image_container{
	width: 150px;
	height: 120px;
	background-size: cover;
	background-position: center;
}
.title{
	font-weight: bold;
	font-size: 16px;
	padding: 5px;
	padding-bottom: 0px;
}
.author{
	padding-left: 5px;
	padding-bottom: 5px;
}
.newWebtoon{
    display: inline-block;
    width: 310px;
    margin-top: 25px;
    margin-left: 30px;
    height: 400px;
}
.newWebtoon .title{
	color: #e83d3d
}
.newWebtoon ol{
	list-style:none;
	margin: 0;
	padding: 5px;
	width: 100%;
}
.newWebtoon ol li{
	padding: 5px 0;
	padding-top: 10px;
	border-bottom: 1px solid #aeaeae;
	cursor: pointer;
}
.newWebtoon ol li:hover{
	color: #a3a3a3;
}
</style>
</head>
<body>
<%@ include file="./layout/header.jsp"%>
<main>
<div class="swiper-container" id="banner-slider">
	<div class="swiper-wrapper">
		<div class="swiper-slide"><img src="<c:url value='/resources/images/banner/banner1.png'/>"></div>
		<div class="swiper-slide"><img src="<c:url value='/resources/images/banner/banner2.png'/>"></div>
		<div class="swiper-slide"><img src="<c:url value='/resources/images/banner/banner1.png'/>"></div>
	</div>
	<div class="swiper-button-next"></div>
	<div class="swiper-button-prev"></div>
	<div class="swiper-pagination"></div>
</div>

<div class="row types">
	<span class="type active" data-type="">all</span>|
	<span class="type" data-type="episode">#episode</span>|
	<span class="type" data-type="omnibus">#omnibus</span>|
	<span class="type" data-type="story">#story</span>
</div>
<script id="webtoonsTemplate" type="text/x-handlebars-template">
<div id="webtoons" class="row webtoons float-left">
	{{#each .}}
	<div class="card webtoon" onclick="location.href = '<c:url value='/webtoons/'/>{{webtoonId}}'">
		<div class="image_container" style="background-image: url({{thumbnail}})"></div>
		<div class="title">{{title}}</div>
		<div class="author">{{authorNickname}}</div>
	</div>
	{{/each}}
</div>
</script>
<script id="newWebtoonsTemplate" type="text/x-handlebars-template">
<div id="newWebtoons" class="newWebtoon box float-right">
	<div class="title">
		New Webtoon
	</div>
	<ol class="webtoons">
		{{#each .}}
		<li onclick="location.href = '<c:url value='/webtoons/'/>{{webtoonId}}'">{{title}}</li>
		{{/each}}
	<ol>
</div>
</div>
</script>
</main>
<%@ include file="./layout/footer.jsp"%>
</body>
</html>
