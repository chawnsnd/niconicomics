<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<%@ include file="../../layout/global.jsp"%>
</head>
<script>
var me;
$(function(){
	Handlebars.registerHelper('showDotple', function (showDotple) {
	  	return showDotple === "SHOW";
	});
	Handlebars.registerHelper('showChat', function (showChat) {
	  	return showChat === "SHOW";
	});
	getMe();
})
function getMe(){
	$.ajax({
		url: "<c:url value='/api/users/me'/>",
		method: "get",
		async: false,
		success: function(data){
			me = data;
			bindTemplate($("#settingTemplate"), data);
			$("#submit").on("click", function(){
				setUser();
			})
		},
		error: function(err){
			console.log(err);
		}
	})
}
function setUser(){
	$.ajax({
		url: "<c:url value='/api/users/'/>"+me.userId,
		type: "patch",
		contentType: "application/json",
		data: JSON.stringify({
			showDotple : $(":radio[name='showDotple']:checked").val(),
			showChat : $(":radio[name='showChat']:checked").val()
		}),
		success: function(){
			location.href="<c:url value='/users/mypage/profile'/>";
		},
		error: function(err){
			console.log(err)
		}
	})
}

</script>

<body>
<%@ include file="../../layout/header.jsp"%>
<main>
<%@ include file="./layout/style.jsp"%>
<div id = "contentsWrap">
	<section>
	<h2>Setting</h2><hr>
<script id="settingTemplate" type="text/x-handlebars-template">
<div class="box">
		<div class="item">
			<div class="title">Dotple</div>
			<div class="value">
			{{#if (showDotple showDotple)}}
			<input type="radio" name="showDotple" value="SHOW" checked="checked">on
			<input type="radio" name="showDotple" value="HIDE">off<br>
			{{/if}}
			{{#unless (showDotple showDotple)}}
			<input type="radio" name="showDotple" value="SHOW">on
			<input type="radio" name="showDotple" value="HIDE" checked="checked">off<br>
			{{/unless}}
			</div>
		</div>
		<div class="item">
			<div class="title">Chatting</div>
			<div class="value">
			{{#if (showChat showChat)}}
			<input type="radio" name="showChat" value="SHOW" checked="checked">on
			<input type="radio" name="showChat" value="HIDE">off<br>
			{{/if}}
			{{#unless (showChat showChat)}}
			<input type="radio" name="showChat" value="SHOW">on
			<input type="radio" name="showChat" value="HIDE" checked="checked">off<br>
			{{/unless}}
			</div>
		</div>
		<div class="item">
			<button class="btn btn-primary btn-block" id="submit">setting</button>
		</div>
</div>
</script>
	</section>
</div>
</main>
<%@ include file="../../layout/footer.jsp"%>
</body>
</html>