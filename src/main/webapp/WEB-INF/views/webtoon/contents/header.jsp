<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<style>
header{
	background-color: white;
	border-bottom: 1px solid #a3a3a3;
	display: flex;
	position: absolute;
	top:0;
	left:0;
	height: 60px;
	line-height: 60px;
	width: 100%;
	z-index: 9;
}
header *{
	display: inline-block;
}
.logo{
	padding: 0 10px;
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
	color: #e83d3d;
}
</style>
<header>
	<div class="logo" onclick="location.href='<c:url value="/"/>'">ニコニコ</div>
	<script id="titleTemplate" type="text/x-handlebars-template">
		<div id="title" class="title" onclick="location.href='<c:url value="/webtoons/${webtoonId}"/>'">{{title}} Ep. ${episodeNo}</div>
	</script>
	<div class="menu">
		<div class="menu_item" id="toggleDotple" onclick="toggleDotple()">DOTPLE</div>
		<div class="menu_item" id="toggleChatroom" onclick="toggleChatroom()">CHAT</div>
		<div class="menu_item" id="support" data-toggle="modal" data-target="#supportModal">DONATE</div>
	</div>
</header>