<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="<c:url value="/resources/js/jquery-3.4.1.min.js" />"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
var sock = new SockJS('<c:url value="/chat" />?webtoonId=${webtoonId}'); //소켓연결
sock.onmessage = onMessage; //소켓에서 메시지 받음
sock.onclose = onclose; //연결 끊음
$(function(){
	$("#middle").css("height", $(window)[0].innerHeight-110);
	$("#chat_room").css("height", $("#middle").height()-50);
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
function sendMessage(){
	message = $("#message").val();
	if(message==""){
		return;
	}else{
		sock.send(JSON.stringify({
			userId: me.userId,
			webtoonId: ${webtoonId},
			type: "GENERAL",
			message: message})) //소켓에다 메시지 보냄
		$("#message").val("");
	}
}
function onMessage(evt){
	var data =JSON.parse(evt.data);
	var sender = data.nickname;
	var message = data.message;
	var type = data.type;
	var rgb = hashStringToColor(sender);
	if(type == "GENERAL"){
		$("#chat_room").append(
			"<div class='message' style='word-break:break-all;'><b style='color: "+rgb+"; margin-right: 5px;'>"+sender+":</b>"+message+"</div>"
		);
	}else if(type == "DONATE" || type == "DOTPLE"){
		$("#chat_room").append(
				"<div class='message' style='word-break:break-all;'><b style='color: #fbc714; margin-right: 5px;'><i class='fas fa-bullhorn'></i> notice:</b>"+message+"</div>"
		);
	}
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
.message{
	padding: 5px 20px;
}
#top{
	height: 60px;
	line-height: 60px;
	text-align: center;
	border-bottom: 1px solid #aeaeae;
	font-weight: bold;
}
#bottom{
	height: 50px;
	line-height: 50px;
	text-align: center;
	border-top: 1px solid #aeaeae;
}
#chat_room{
   	overflow-y: auto;
   	font-size: 12px;
   	width: 100%;
   	display: inline-block;
}
#middle{
	display: inline-block;
	overflow-y: hidden;
}
#chat_input{
	display: inline-block;
	height: 50px;
	width: 100%;
}
.please_login{
	line-height: 50px;
	vertical-align: middle;
	text-align: center;
}
#message{
	flex: 4;
}
#send_btn{
	flex: 1;
}
.send_form{
	width: 100%;
}
</style>
<div id="chat">
<div id="top">
CHATTING
</div>
<div id="middle">
	<div id="chat_room">
	</div>
	<div id="chat_input">
		<c:if test="${sessionScope.loginUser == null}">
		<div class="please_login">Please <a href="<c:url value='/users/login'/>">login.</a></div>
		</c:if>
		<c:if test="${sessionScope.loginUser != null}">
		<div class="send_form input-group-prepend">
			<input class="form-control" id="message" type="text" placeholder="message">
			<button class="btn btn-default btn-success" id="send_btn">send</button>
		</div>
		</c:if>
	</div>
</div>
<div id="bottom">
Please keep your manners.
</div>
</div>
