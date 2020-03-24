<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>니코니코믹스 웹서버</title>
<%@ include file="./layout/global.jsp"%>
<style>
.main_left{
	width: 650px;
	float: left;
}
.main_right{
	width: 300px;
	float: right;
}
.item>img{
	max-height: 200px;
}
.left_item{
	padding: 25px 0 10px 0;
}
.item_title{
	font-size: 20px;
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
${sessionScope.loginUser.userId}
${sessionScope.loginUser.email}
<div class="main_left">
	<div class="carousel slide left_item" data-ride="carousel">
	  <ol class="carousel-indicators">
	    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
	    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
	    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
	  </ol>
	  <div class="carousel-inner" role="listbox">
	    <div class="item active">
	      <img src="resources/images/ps.jpg">
	    </div>
	    <div class="item">
	      <img src="resources/images/ps.jpg">
	    </div>
	  </div>
	  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
	    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	    <span class="sr-only">Previous</span>
	  </a>
	  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
	    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	    <span class="sr-only">Next</span>
	  </a>
	</div>
	<div class="webtoon_list left_item">
		<div class="item_title">Recommand</div>
		<div class="row">
			<div class="col-xs-6 col-md-3">
				<a href="#" class="thumbnail">
					<img src="resources/images/ps.jpg">
				</a>
			</div>
			<div class="col-xs-6 col-md-3">
				<a href="#" class="thumbnail">
					<img src="resources/images/ps.jpg">
				</a>
			</div>
			<div class="col-xs-6 col-md-3">
				<a href="#" class="thumbnail">
					<img src="resources/images/ps.jpg">
				</a>
			</div>
			<div class="col-xs-6 col-md-3">
				<a href="#" class="thumbnail">
					<img src="resources/images/ps.jpg">
				</a>
			</div>
		</div>
	</div>
	<div class="webtoon_list left_item">
		<div class="item_title">New</div>
		<div class="row">
			<div class="col-xs-6 col-md-3">
				<a href="#" class="thumbnail">
					<img src="resources/images/ps.jpg">
				</a>
			</div>
			<div class="col-xs-6 col-md-3">
				<a href="#" class="thumbnail">
					<img src="resources/images/ps.jpg">
				</a>
			</div>
			<div class="col-xs-6 col-md-3">
				<a href="#" class="thumbnail">
					<img src="resources/images/ps.jpg">
				</a>
			</div>
			<div class="col-xs-6 col-md-3">
				<a href="#" class="thumbnail">
					<img src="resources/images/ps.jpg">
				</a>
			</div>
		</div>
	</div>
	<div class="webtoon_list left_item">
		<div class="item_title">#SF</div>
		<div class="row">
			<div class="col-xs-6 col-md-3">
				<a href="#" class="thumbnail">
					<img src="resources/images/ps.jpg">
				</a>
			</div>
			<div class="col-xs-6 col-md-3">
				<a href="#" class="thumbnail">
					<img src="resources/images/ps.jpg">
				</a>
			</div>
			<div class="col-xs-6 col-md-3">
				<a href="#" class="thumbnail">
					<img src="resources/images/ps.jpg">
				</a>
			</div>
			<div class="col-xs-6 col-md-3">
				<a href="#" class="thumbnail">
					<img src="resources/images/ps.jpg">
				</a>
			</div>
		</div>
	</div>
</div>
<div class="main_right">
	<div class="card">
		<div class="card_title">Views Rank</div>
		<ol>
			<li><a href="#">apple</a></li>
			<li><a href="#">banana</a></li>
			<li><a href="#">apple</a></li>
			<li><a href="#">banana</a></li>
			<li><a href="#">apple</a></li>
			<li><a href="#">banana</a></li>
			<li><a href="#">apple</a></li>
			<li><a href="#">banana</a></li>
			<li><a href="#">apple</a></li>
			<li><a href="#">banana</a></li>
		</ol>
	</div>
</div>
<div class="main_right">
	<div class="card">
		<div class="card_title">Dotple Rank</div>
		<ol>
			<li><a href="#">apple</a></li>
			<li><a href="#">banana</a></li>
			<li><a href="#">apple</a></li>
			<li><a href="#">banana</a></li>
			<li><a href="#">apple</a></li>
			<li><a href="#">banana</a></li>
			<li><a href="#">apple</a></li>
			<li><a href="#">banana</a></li>
			<li><a href="#">apple</a></li>
			<li><a href="#">banana</a></li>
		</ol>
	</div>
</div>
</main>
<%@ include file="./layout/footer.jsp"%>
</body>
</html>
