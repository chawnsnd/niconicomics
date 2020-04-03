<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>니코니코믹스 웹서버</title>
<%@ include file="./layout/global.jsp"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.min.css">
<script src="https://unpkg.com/swiper/js/swiper.min.js"></script>
<script>

</script>
<script>
$(document).ready(function(){
	var bannerSlider = new Swiper('#banner-slider', {
		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev',
		},
		pagination: {
	        el: '.swiper-pagination',
      	}
	});
	var recommandSlider = new Swiper('#recommand-slider', {
		cssMode: true,
		slidesPerView: 4,
      	spaceBetween: 30,
      	mousewheel: true,
        keyboard: true,
        navigation: {
			nextEl: '#recommand-button-next',
			prevEl: '#recommand-button-prev',
		}
	});
	var newSlider = new Swiper('#new-slider', {
		cssMode: true,
		slidesPerView: 6,
      	spaceBetween: 30,
      	mousewheel: true,
        keyboard: true,
        navigation: {
			nextEl: '#new-button-next',
			prevEl: '#new-button-prev',
		}
	});
	var sfSlider = new Swiper('#sf-slider', {
		cssMode: true,
		slidesPerView: 6,
      	spaceBetween: 30,
      	mousewheel: true,
        keyboard: true,
        navigation: {
			nextEl: '#sf-button-next',
			prevEl: '#sf-button-prev',
		}
	});
});
</script>
<style>
.swiper-container {
	width: 100%;
	height: 100%;
}
.swiper-slide {
	text-align: center;
	font-size: 18px;
	background: #fff;
/* 	display: -webkit-box; */
/* 	display: -ms-flexbox; */
/* 	display: -webkit-flex; */
/* 	display: flex; */
	display: inline-block;
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
.label{
	text-align: left;
}
.label-big{
	font-size: 20px;
}
.label-small{
	font-size: 15px;
}
</style>
<style>
.item>img{
	max-height: 200px;
}
.left_item{
	padding: 50px 0 25px 0;
}
.item_title{
	font-size: 30px;
	font-weight: bold;
}
.card{
	margin: 0 0 30px 0;
	border: 1px solid #e1e1e1;
	padding: 10px;
}
.card_title{
	font-weight: bold;
}
</style>
</head>
<body>
<%@ include file="./layout/header.jsp"%>
<main>
<div class="swiper-container" id="banner-slider">
	<div class="swiper-wrapper">
		<div class="swiper-slide"><img src="resources/images/ps.jpg" width="1000px" height="400px"/></div>
		<div class="swiper-slide"><img src="resources/images/ps.jpg" width="1000px" height="400px"/></div>
		<div class="swiper-slide"><img src="resources/images/ps.jpg" width="1000px" height="400px"/></div>
		<div class="swiper-slide"><img src="resources/images/ps.jpg" width="1000px" height="400px"/></div>
		<div class="swiper-slide"><img src="resources/images/ps.jpg" width="1000px" height="400px"/></div>
	</div>
	<div class="swiper-button-next"></div>
	<div class="swiper-button-prev"></div>
	<div class="swiper-pagination"></div>
</div>

<div class="webtoon_list left_item">
	<div class="item_title">Recommand</div>
	<div class="row">
		<div class="swiper-container" id="recommand-slider">
			<div class="swiper-wrapper">
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="240px" height="300px">
					<div class="label">펭수펭하</div>
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="240px" height="300px">
					<div class="label">펭수펭하</div>
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="240px" height="300px">
					<div class="label">펭수펭하</div>	
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="240px" height="300px">
					<div class="label label-big">펭수펭하</div>
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="240px" height="300px">
					<div class="label label-big">펭수펭하</div>
				</div>
			</div>
			<div class="swiper-button-next" id="recommand-button-next"></div>
			<div class="swiper-button-prev" id="recommand-button-prev"></div>
		</div>
	</div>
</div>
<div class="webtoon_list left_item">
	<div class="item_title">New</div>
	<div class="row">
		<div class="swiper-container" id="new-slider">
			<div class="swiper-wrapper">
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="150px" height="200px">
					<div class="label label-big">펭수펭하</div>	
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="150px" height="200px">
					<div class="label label-big">펭수펭하</div>	
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="150px" height="200px">
					<div class="label label-big">펭수펭하</div>	
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="150px" height="200px">
					<div class="label label-big">펭수펭하</div>	
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="150px" height="200px">
					<div class="label label-big">펭수펭하</div>	
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="150px" height="200px">
					<div class="label label-big">펭수펭하</div>	
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="150px" height="200px">
					<div class="label label-big">펭수펭하</div>	
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="150px" height="200px">
					<div class="label label-big">펭수펭하</div>	
				</div>
			</div>
			<div class="swiper-button-next" id="new-button-next"></div>
			<div class="swiper-button-prev" id="new-button-prev"></div>
		</div>
	</div>
</div>
<div class="webtoon_list left_item">
	<div class="item_title">#SF</div>
	<div class="row">
		<div class="swiper-container" id="sf-slider">
			<div class="swiper-wrapper">
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="150px" height="200px">
					<div class="label label-big">펭수펭하</div>	
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="150px" height="200px">
					<div class="label label-big">펭수펭하</div>	
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="150px" height="200px">
					<div class="label label-big">펭수펭하</div>	
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="150px" height="200px">
					<div class="label label-big">펭수펭하</div>	
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="150px" height="200px">
					<div class="label label-big">펭수펭하</div>	
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="150px" height="200px">
					<div class="label label-big">펭수펭하</div>	
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="150px" height="200px">
					<div class="label label-big">펭수펭하</div>	
				</div>
				<div class="swiper-slide" onclick="location.href ='<c:url value='/webtoons/3'/>'">
					<img src="resources/images/ps.jpg" width="150px" height="200px">
					<div class="label label-big">펭수펭하</div>	
				</div>
			</div>
			<div class="swiper-button-next" id="sf-button-next"></div>
			<div class="swiper-button-prev" id="sf-button-prev"></div>
		</div>
	</div>
</div>
</main>
<%@ include file="./layout/footer.jsp"%>
</body>
</html>
