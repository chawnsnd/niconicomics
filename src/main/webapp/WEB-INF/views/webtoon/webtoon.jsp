<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
</head>
<style>
.episode-table{
	width: 100%;
}
.episode-table * {
	text-align: center;
	margin: auto;
}
tr:active{
	border: 2px solid #fbc714;
}
</style>
<body>
<%@ include file="../layout/header.jsp"%>
<main>
<div>
	<img src="<c:url value='/resources/images/ps.jpg'/>">
	<b>펭수펭하</b>
	설명설명설명설명
</div>
<br>
<table class="episode-table table">
	<tr>
		<th>회차</th>
		<th>이미지</th>
		<th>제목</th>
		<th>조회수</th>
		<th>등록일</th>
	</tr>
	<tr onclick="location.href = '<c:url value='/webtoons/${webtoonId}/episodes/3'/>'">
		<td>3</td>
		<td><img src="<c:url value='/resources/images/ps.jpg'/>" width="100px"></td>
		<td>펭수펭화 3화 : 펭바!</td>
		<td>125</td>
		<td>2020.04.03</td>
	</tr>
	<tr onclick="location.href = '<c:url value='/webtoons/${webtoonId}/episodes/2'/>'">
		<td>2</td>
		<td><img src="<c:url value='/resources/images/ps.jpg'/>" width="100px"></td>
		<td>펭수펭화 2화 : 펭펭!</td>
		<td>125</td>
		<td>2020.04.03</td>
	</tr>
	<tr onclick="location.href = '<c:url value='/webtoons/${webtoonId}/episodes/1'/>'">
		<td>1</td>
		<td><img src="<c:url value='/resources/images/ps.jpg'/>" width="100px"></td>
		<td>펭수펭화 1화 : 펭하!</td>
		<td>125</td>
		<td>2020.04.03</td>
	</tr>
</table>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>