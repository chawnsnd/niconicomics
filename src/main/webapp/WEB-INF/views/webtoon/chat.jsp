<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<c:url value="/resources/js/jquery-3.4.1.min.js" />"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
var me = null;
var sock = new SockJS('<c:url value="/chat" />?webtoonId=${webtoonId}'); //소켓연결
sock.onmessage = onMessage; //소켓에서 메시지 받음
sock.onclose = onclose; //연결 끊음
$(function(){
	$("#message, #me").on("keyup", function(e){
		if(e.keyCode == 13){
			sendMessage();
			$("#message").val("");
		}
	})
	$("#send_btn").on("click", function(){
		sendMessage();
	})
})
<c:if test="${sessionScope.loginUser != null}">
function sendMessage(){
	message = $("#message").val();
	if(message==""){
		return;
	}else{
		sock.send(JSON.stringify({
			userId: ${sessionScope.loginUser.userId},
			webtoonId: ${webtoonId},
			type: "chat",
			message: message})) //소켓에다 메시지 보냄
		$("#message").val("");
	}
}
</c:if>
function onMessage(evt){
	var data =JSON.parse(evt.data);
	var sender = data.nickname;
	var message = data.message;
	var rgb = hashStringToColor(sender);
	$("#chat_room").append(
		"<p style='word-break:break-all;'><b style='color: "+rgb+"; margin-right: 10px;'>"+sender+"</b>"+message+"</p>"
	);
	scrollDown();
}
function scrollDown(){
	$("#chat_room").scrollTop($("#chat_room")[0].scrollHeight);
}
function djb2(str){
	var hash = 5381;
	for (var i = 0; i < str.length; i++) {
		hash = ((hash << 5) + hash) + str.charCodeAt(i); /* hash * 33 + c */
	}
	return hash;
}
function hashStringToColor(str) {
	var hash = djb2(str);
	var r = (hash & 0xFF0000) >> 16;
	var g = (hash & 0x00FF00) >> 8;
	var b = hash & 0x0000FF;
	return "#" + ("0" + r.toString(16)).substr(-2) + ("0" + g.toString(16)).substr(-2) + ("0" + b.toString(16)).substr(-2);
}
</script>
<style>
#chat_room{
	height: 80vh;
   	overflow-y: auto;
   	padding: 1vw;
}
#chat_input{
	display: inline-flex;
}
#message{
	flex: 4;
}
#send_btn{
	flex: 1;
}
</style>
</head>
<body>
<div id="chat_room">
</div>
<div id="chat_input">
	<c:if test="${sessionScope.loginUser == null}">
	<div><a href="<c:url value='/users/login'/>">로그인</a> 후 이용해주세요</div>
	</c:if>
	<c:if test="${sessionScope.loginUser != null}">
	<div id="me">${sessionScope.loginUser.nickname }</div>
	<input id="message" type="text" placeholder="메시지">
	<button id="send_btn">전송</button>
	</c:if>
</div>
</body>
</html>