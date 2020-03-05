<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>니코니코믹스 웹서버</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
var str = "pingpong";
var host = "http://localhost:80";
function test(){
	$.ajax({
		url: host+"/test",
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
<body>
<h1>니코니코믹스 API 서버</h1>
<p> 현재시간 :  ${serverTime} </p>
<button onclick="test()">API 테스트</button>
</body>
</html>
