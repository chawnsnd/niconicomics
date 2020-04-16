<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
var me = null;
$(function(){
	Handlebars.registerHelper('isAuthor', function (type) {
	  	return type === "AUTHOR";
	});
	getHeaderMe();
	if(me == null){
		bindTemplate($("#headerNoLoginTemplate"), {});
	}else{
		bindTemplate($("#headerLoginTemplate"), me);
	}
});
function getHeaderMe(){
	$.ajax({
		url: "<c:url value='/api/users/me'/>",
		method: "get",
		async: false,
		success: function(data){
			if(data != ""){
				me = data;
			}
		},
		error: function(err){
			console.log(err);
		}
	})
}
function logout(){
	$.ajax({
		url: "<c:url value='/api/users/logout'/>",
		method: "get",
		success: function(){
			me = null;
			location.href = "<c:url value='/'/>"			
		},
		error: function(err){
			console.log(err);
		}
	})
}
</script>
<header>
<div class="header_wrap">
	<div class="header_left">
		<div class="header_title" onclick="location.href='<c:url value="/"/>'">ニコニコ<br>ニコニコ<br>ミクス</div>
		<div class="header_menus">
			<a href="<c:url value='/'/>">HOME</a>
			<a href="<c:url value='/webtoons'/>">SEARCH</a>
			<a href="https://github.com/chawnsnd/niconicomics" target="_blank">API REFERENCE</a>
		</div>
	</div>
	<div class="header_right">
			<script id="headerNoLoginTemplate" type="text/x-handlebars-template">
			<div class="header_notLogin">
			<a href="<c:url value="/users/login"/>"><i class="fas fa-sign-in-alt"></i> Sign in</a>
			<a href="<c:url value="/users/join"/>"><i class="fas fa-pen"></i> Sign up</a>
			</div>
			</script>
			<script id="headerLoginTemplate" type="text/x-handlebars-template">
			<div class="header_login">
			<div class="header_userinfo">{{nickname}}</div>
			<a href="<c:url value="/users/mypage/profile"/>"><i class="fas fa-home"></i> MyPage</a>
				{{#if (isAuthor type)}}
				<a href="<c:url value="/dashboard"/>"><i class="fas fa-chart-line"></i> Dashboard</a>
				{{/if}}
			<a onclick="logout()" href="#"><i class="fas fa-sign-out-alt"></i> Sign Out</a>
			</div>
			</div>
			</script>
	</div>
</div>
</header>