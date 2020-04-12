<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<%@ include file="../../layout/global.jsp"%>
<script>
function charge(){
	var item = $("input[name='item']:checked").val();
	$.ajax({
		url: "<c:url value='/api/nico/charge1'/>",
		method: "get",
		data: {
			userId: ${sessionScope.loginUser.userId},
			item: item
		},
		success: function(url){
			location.href = url;
		}
	});
}
</script>
<style>
.box{
	border: 1px solid #a3a3a3;
	display: inline-block;
	box-shadow: 3px 3px 5px 0px #6c757d;
	padding: 10px;
	width: 420px;
	position: relative;
}
.title{
	width: 120px;
	font-weight: bold;
}
.item > div{
	display: inline-block;
}
</style>
</head>

<body>
<%@ include file="../../layout/header.jsp"%>

<main>
<%@ include file="./layout/style.jsp"%>

	<div id = "contentsWrap">
	<section>
		<div class="box">
			<div class="item">
				<div class="title">Charged Nico</div>			
				<div class="value">${sessionScope.loginUser.nico} NICO</div>
			</div>
			<div class="item">		
				<div class="title">Item</div>			
				<div class="value">
					<label><input type="radio" name="item" value="1000니코">1000 NICO</label>
					<label><input type="radio" name="item" value="3000니코">3000 NICO</label>
					<label><input type="radio" name="item" value="10000니코">10000 NICO</label>
				</div>
			</div>
			<div class="item">
				<button class="btn btn-primary" onclick="charge()">Charge</button>
			</div>
		</div>
	</section>
	</div>
</main>
<%@ include file="../../layout/footer.jsp"%>
</body>
</html>