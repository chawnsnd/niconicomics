<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>니코니코믹스 웹서버</title>
<%@ include file="./layout/global.jsp"%>
</head>
<body>
<%@ include file="./layout/header.jsp"%>
<main>
	<h1>니코니코믹스 API 서버</h1>
	<p>현재시간 : ${serverTime}</p>
	<button onclick="test()">API 테스트</button>
</main>
<%@ include file="./layout/footer.jsp"%>
</body>
</html>
