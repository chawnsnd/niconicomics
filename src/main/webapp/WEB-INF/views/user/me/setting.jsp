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
$(function(){
	$("#submit").on("click", function(){
		setUser();
	})
})

function setUser(){
	$.ajax({
		url: "<c:url value='/api/users'/>"+"/${sessionScope.loginUser.userId}"+"/setting",
		type: "post",
		data: {
			userId : ${sessionScope.loginUser.userId}
			,setDotple : $(":radio[name='setDotple']:checked").val()
			,setChat : $(":radio[name='setChat']:checked").val()
		},
		success: function(data){
			console.log(data);
			
			if(data=='yes'){
				location.href="<c:url value='/users/me/setting'/>";
				alert('설정이 완료되었습니다');
			}else{
				alert('잘못된 접근입니다');
			}
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

<form id="setUserForm">
	dotple
		<input type="radio" name="setDotple" value="SHOW" checked="checked">on
		<input type="radio" name="setDotple" value="HIDE">off<br>
	chatting
		<input type="radio" name="setChat" value="SHOW" checked="checked">on
		<input type="radio" name="setChat" value="HIDE">off<br>
<button id="submit">save</button>
</form>


</main>

</body>
</html>