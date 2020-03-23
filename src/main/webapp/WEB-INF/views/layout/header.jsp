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
		<div class="header_dropdown dropdown">
			<div class="dropdown-toggle" id="dropdownMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<i class="header_bars fas fa-bars"></i>
			</div>
			<ul class="header_dropdown_menu dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
				<li role="presentation"><a role="menuitem" tabindex="-1" href="#">Login</a></li>
				<li role="presentation"><a role="menuitem" tabindex="-1" href="#">Join</a></li>
			</ul>
		</div>
	</div>
</div>
</header>