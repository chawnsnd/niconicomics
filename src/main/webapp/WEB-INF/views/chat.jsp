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
var webtoonId = location.pathname.substr(location.pathname.lastIndexOf("/")+1);
var sock = new SockJS('<c:url value="/chat" />?webtoonId='+webtoonId); //소켓연결
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
// function init(){
// 	sock.send(JSON.stringify({
// 		userId:1,
// 		webtoonId: webtoonId,
// 		type: "join"
// 	}));
// }
function sendMessage(){
	me = $("#me").val();
	message = $("#message").val();
	if(me==""||message==""){
		return;
	}else{
		sock.send(JSON.stringify({
			userId:1,
			webtoonId: webtoonId,
			type: "chat",
			message: message})) //소켓에다 메시지 보냄
		$("#message").val("");
	}
}
function onMessage(evt){
	var data =JSON.parse(evt.data);
	var sender = data.userId;
	var message = data.message;
	if(sender == me){
		$("#chat_room").append(
			"<p style='text-align: right;'><b>"+sender+"</b><br>"+message+"</p>"
		);
	}else{
		$("#chat_room").append(
			"<p><b>"+sender+"</b><br>"+message+"</p>"
		);
	}
	scrollDown();
}
function scrollDown(){
	$("#chat_room").scrollTop($("#chat_room")[0].scrollHeight);
}
</script>
<style>
#chat_room{
	width: 92vw;
	height: 60vh;
	border: 3px solid gray;	
   	overflow-y: auto;
   	padding: 0 3vw;
   	font-size: 4vmin;
}
#chat_input{
	border: 3px solid gray;
	width: 98vw;
	display: inline-flex;
}
#me{
	min-width: 0px;	
	flex: 2;
	font-size: 4vmin;
}
#message{
	min-width: 0px;	
	flex: 5;
	font-size: 4vmin;
}
#send_btn{
	min-width: 0px;
	flex: 1;
	font-size: 4vmin;
}
</style>
</head>
<body>
<h1>채팅</h1>
<div id="chat_room">
</div>
<div id="chat_input">
	<input id="me" type="text" placeholder="이름">
	<input id="message" type="text" placeholder="메시지">
	<button id="send_btn">전송</button>
</div>
</body>
</html>