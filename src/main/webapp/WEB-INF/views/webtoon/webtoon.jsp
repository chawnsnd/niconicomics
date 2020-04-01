<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
</head>
<body>
<%@ include file="../layout/header.jsp"%>
<main>
${webtoonId}
<img src="<c:url value='/resources/images/ps.jpg'/>">
{{제목}}
{{설명설명설명설명}}
<div>
<br>
<div><a href="./${webtoonId}/episodes/1">1화</a></div>
<div><a href="./${webtoonId}/episodes/2">2화</a></div>
<div><a href="./${webtoonId}/episodes/3">3화</a></div>
<div><a href="./${webtoonId}/episodes/4">4화</a></div>
</div>
</main>
<%@ include file="../layout/footer.jsp"%>
</body>
</html>