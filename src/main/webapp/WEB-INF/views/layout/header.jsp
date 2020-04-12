<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
$(function(){
	Handlebars.registerHelper('isAuthor', function (type) {
	  	return type === "AUTHOR";
	});
	Handlebars.registerHelper('isLogin', function (me) {
	  	return me !== "";
	});
	getHeaderMe();
});
function getHeaderMe(){
	$.ajax({
		url: "<c:url value='/api/users/me'/>",
		method: "get",
		success: function(data){
			var me = {};
			me["me"] = data;
			bindTemplate($("#headerUserTemplate"), me);
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
		<div class="header_title" onclick="location.href='<c:url value="/"/>'">ニコニコ x 2<br>ミクス</div>
		<div class="header_menus">
			<a href="<c:url value='/webtoons'/>">All</a>
		</div>
	</div>
	<div class="header_right">
		<div class="header_search">
			<input type="text" placeholder="Author | Webtoon | Hashtag">
		</div>
		<div>
			<script id="headerUserTemplate" type="text/x-handlebars-template">
			{{#unless (isLogin me)}}
			<a href="<c:url value="/users/login"/>">Sign in</a>
			<a href="<c:url value="/users/join"/>">Sign up</a>
			{{/unless}}			
			{{#if (isLogin me)}}
			<b>{{me.nickname}}({{me.email}})</b>
			<a href="<c:url value="/users/mypage/profile"/>">MyPage</a>
				{{#if (isAuthor me.type)}}
				<a href="<c:url value="/dashboard"/>">Dashboard</a>
				{{/if}}
			<a onclick="logout()" href="#">Sign out</a>
			{{/if}}
			</script>
		</div>
	</div>
</div>
</header>