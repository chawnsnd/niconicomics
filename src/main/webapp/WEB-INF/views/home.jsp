<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<title>니코니코믹스 웹서버</title>
</head>

<script src="./resources/js/jquery-3.4.1.min.js"></script>

<body>
<!-- API 테스트 -->
<script>
var str = "pingpong";
function test(){
	$.ajax({
		url: "<c:url value='/test' />",
		type: "get",
		data: {
			str: str
		},
		success: function(data){
			if(data==str){
				alert("성공");
			}else{
				alert("실패");
			}
		},
		error: function(e){
			alert(JSON.stringify(e));
		}
	})
}
</script>
<h1>니코니코믹스 API 서버</h1>
<p> 현재시간 :  ${serverTime} </p>
<button onclick="test()">API 테스트</button>



<br>
<br>


<!-- 이미지 업로드 -->
<script src="https://sdk.amazonaws.com/js/aws-sdk-2.283.1.min.js"></script>
<script src="./resources/js/aws-s3.js"></script>
<script>
//이미지 저장
function uploadButton(){
    // 1. 파일객체를 가져와서
    var file = $("#file1");
    // 2. 첫번째매개변수에는 저장하고 싶은 경로
    //    두번째매개변수에는 저장하고 싶은 경로
    //    세번쨰 매개변수에는 아까 가져온 파일객체
    uploadImage("tests/test", file)
    // 3. 요런식을 쓴다. 몰라도 외워서 익숙해지면 됨
    .then(data => {
        console.log(data);
        $("#output").html(
            "<div data-key='"+data.Key+"'>"+
            "<img src='"+data.Location+"'>"+
            "<input type='file'>"+
            "<button onclick='modifyButton(`"+data.Key+"`)'>수정</button>"+
            "<button onclick='deleteButton(`"+data.Key+"`)'>삭제</button>"+
            "</div>"
        );
    }).catch(err => {
        console.log(err);
    })
    // 4) 결과 data.Location은 아마
    //    https://niconicomics-images.s3.ap-northeast-2.amazonaws.com/webtoon/2341/temp.jpg
    //    요런느낌으로 얻을 수 있을 거임
}

// 이미지 여러개 저장
function uploadsButton(){
    var files = $(".file")
    uploadImages("tests/test", files)
    .then(data => {
        console.log(data);
        $("#output").html("");
        data.forEach(img => {
            $("#output").append(
        		"<div data-key='"+img.Key+"'>"+
                "<img src='"+img.Location+"'>"+
                "<input type='file'>"+
                "<button onclick='modifyButton(`"+img.Key+"`)'>수정</button>"+
                "<button onclick='deleteButton(`"+img.Key+"`)'>삭제</button>"+
                "</div>"
            ); 
        });
    }).catch(err =>{
        console.log(err);
    })
}

// 이미지 삭제
function deleteButton(key){
    deleteImage(key)
    .then(data => {
        console.log(data);
        $("div[data-key='"+key+"']").remove();
    }).catch(err => {
        console.log(err);
    })
}

//이미지 수정
function modifyButton(key){
    var file = $("div[data-key='"+key+"']").find("input[type='file']");
    modifyImage(key, file)
    .then(data => {
        console.log(data);
        $("div[data-key='"+key+"']").replaceWith(
       		"<div data-key='"+data.Key+"'>"+
    		"<img src='"+data.Location+"'>"+
            "<input type='file'>"+
            "<button onclick='modifyButton(`"+data.Key+"`)'>수정</button>"+
            "<button onclick='deleteButton(`"+data.Key+"`)'>삭제</button>"+
            "</div>"
        )
    }).catch(err => {
        console.log(err);

    })
}
</script>
<style>
#output img{
	width: 300px;
}
</style>
<h1>이미지 업로드 테스트</h1>
<div>
    <input id="file1" type="file" />
    <input type="button" onclick="uploadButton()" value="업로드"/>
</div>
<hr>
<div>
    <input class="file" id="file2" type="file" />
    <input class="file" id="file3" type="file" />
    <input class="file" id="file4" type="file" />
    <input type="button" onclick="uploadsButton()" value="단체업로드"/>
</div>
<hr>
<div id="output"></div>



<br>
<br>



<!-- 채팅 -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
var sock = new SockJS('<c:url value="/chat" />'); //소켓연결
sock.onmessage = onMessage; //소켓에서 메시지 받음
sock.onclose = onclose; //연결 끊음
var me = null;
$(function(){
	$("#message, #me").on("keyup", function(e){
		if(e.keyCode == 13){
			sendMessage();
			$("#message").val("");
		}
	})
// 	$("#me").on("keyup", function(e){
// 		if(e.keyCode == 13){
// 			sendMessage();
// 			$(this).val("");
// 		}
// 	})
	$("#send_btn").on("click", function(){
		sendMessage();
	})
})
function sendMessage(){
	me = $("#me").val();
	message = $("#message").val();
	if(me==""||message==""){
		return;
	}else{
		sock.send(me+"|"+message) //소켓에다 메시지 보냄
		$("#message").val("");
	}
}
function onMessage(evt){
	var data = evt.data;
	var strArray = data.split("|");
	var sender = strArray[0];
	var message = strArray[1];
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
