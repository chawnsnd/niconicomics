<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<header>
<div class="header_wrap">
	<div class="header_left">
		<div class="header_title" onclick="location.href='<c:url value="/"/>'">ニコニコ x 2<br>ミクス</div>
	</div>
		<div class="header_right">
		<input type="text" placeholder="작가 | 작품명 | 해시태그 검색">
		<div>
			<c:if test="${sessionScope.loginUser == null}">
			<a href="<c:url value="/users/login"/>">로그인</a>
			<a href="<c:url value="/users/join"/>">회원가입</a>
			</c:if>
			<c:if test="${sessionScope.loginUser != null}">
			<b>${sessionScope.loginUser.nickname}(${sessionScope.loginUser.email})</b>
			<a href="<c:url value="/users/me"/>">마이페이지</a>
				<c:if test="${sessionScope.loginUser.type == 'AUTHOR'}">
				<a href="<c:url value="/dashboard"/>">작가 대시보드</a>
				</c:if>
			<a href="<c:url value="/users/logout"/>">로그아웃</a>
			</c:if>
		</div>
	</div>
</div>
</header>