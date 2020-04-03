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
	setting();
})

function setting(){
	$.ajax({
		url: "<c:url value='/api/users'/>"+"/${sessionScope.loginUser.userId}"+"/setting",
		type: "post",
		success: function(data){
			if(data=='yes'){
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

</main>

</body>
</html>