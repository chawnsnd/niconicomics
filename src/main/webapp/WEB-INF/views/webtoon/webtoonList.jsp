<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
</head>
<style>
.card{
	display: inline-block;
	width: 150px;
	height: 100px;
	margin: 0px 6px;
	margin-bottom: 6px;
	cursor: pointer;
}
.searchbox{
	display: inline-block;
	border: 1px solid #aeaeae;
	width: 100%;
	height: 200px;
}
.line{
	margin: 20px 0;
}
.right{
	float: right;
}
.keyword{
	display: inline-block;
	padding: 5px 10px;
	background-color: #25a4cd;
	color: white;
	font-weight: bold;
	border-radius: 30px;
	cursor: pointer;
}
</style>
<body>
<%@ include file="../layout/header.jsp"%>
<main>
<div class="searchbox">
</div>
<div class="line">
	<div class="keyword">#SF X</div>
	<div class="keyword">#참피 X</div>
	<div class="keyword">제목 : 펭수 X</div>
	<div class="keyword">작가 : EBS X</div>
	<div class="right btn-group">
		<div>1 / 12345</div>
		<button class="btn btn-light">prev</button>
		<button class="btn btn-light">next</button>
	</div>
</div>
<div class="cards">
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
<div class="card" onclick="location.href ='<c:url value='/webtoons/3'/>'">
	<img src="<c:url value='/resources/images/ps.jpg'/>" width="150px;">
	<div>펭수펭하</div>
	<div>#SF</div>
	<div>20.04.03</div>
</div>
</div>

</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>