<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<header>
<div class="header_wrap">
	<div class="header_left">
		<div class="header_title" onclick="location.href='<c:url value="/"/>'">ニコニコ x 2<br>ミクス</div>
	</div>
		<div class="header_right">
		<input type="text" placeholder="Author | Webtoon | Hashtag">
		<div>
			<c:if test="${sessionScope.loginUser == null}">
			<a href="<c:url value="/users/login"/>">Sign in</a>
			<a href="<c:url value="/users/join"/>">Sign up</a>
			</c:if>
			<c:if test="${sessionScope.loginUser != null}">
			<b>${sessionScope.loginUser.nickname}(${sessionScope.loginUser.email})</b>
			<a href="<c:url value="/users/me/profile"/>">MyPage</a>
				<c:if test="${sessionScope.loginUser.type == 'AUTHOR'}">
				<a href="<c:url value="/dashboard"/>">Dashboard</a>
				</c:if>
			<a href="<c:url value="/users/logout"/>">Sign out</a>
			</c:if>
		</div>
	</div>
</div>
</header>