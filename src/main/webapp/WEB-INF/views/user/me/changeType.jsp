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
	changeType();
})

function changeType(){
	$.ajax({
		url: "<c:url value='/api/users'/>"+"/${sessionScope.loginUser.userId}"+"/change-to-author",
		type: "post",
		success: function(data){
			if(data=='yes'){
				alert('작가 변경 완료');
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