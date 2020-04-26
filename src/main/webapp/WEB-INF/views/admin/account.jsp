<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="../layout/global.jsp"%>
<script>
var account = null;
$(function(){
	getAccount();
})
function getAccount(){
	var pathname = window.location.pathname;
	var pathnameArr = pathname.split("/");
	var userId = pathnameArr[pathnameArr.length-1];
	$.ajax({
		url: "<c:url value='/account/"+userId+"'/>",
		type: "get",
		success: function(data){
			console.log(data);
			if(data == "") {
				bindTemplate($("#noAccountTemplate"), data);
			}else{
				bindTemplate($("#accountTemplate"), data);
			}
			account = data;
		},
		error: function(err){
			if(err.status == 401 || err.status == 403){
				alert("관리자가 아닙니다. 다시로그인해주세요.");
				location.href="<c:url value='/users/login'/>";
			}
		}
	})
}
function approveAccount(){
	var pathname = window.location.pathname;
	var pathnameArr = pathname.split("/");
	var userId = pathnameArr[pathnameArr.length-1];
	$.ajax({
		url: "<c:url value='/admin/account/"+userId+"/approve'/>",
		type: "patch",
		success: function(data){
			alert("승인하였습니다.");
			history.go(0);
		},
		error: function(err){
			alert("승인이 실패되었습니다.");
		}
	})
}
</script>
<style>
.box{
	border: 1px solid #a3a3a3;
	display: inline-block;
	box-shadow: 3px 3px 5px 0px #6c757d;
	padding: 10px;
	width: 800px;
	position: relative;
}
.title{
	width: 200px;
	font-weight: bold;
}
.item > div{
	display: inline-block;
}
.info{
	margin-top: 10px;
}
.btn-group{
	float: right;
}
</style>
</head>
<body>
<main>
<div>
	<div id="noAccountTemplate" class="template">
		<div>등록된 계좌가 없습니다.</div>
	</div>
	<div id="accountTemplate" class="template">
		<div class="box">
			<div class="item">
				<div class="title">이름</div>
				<div class="value">{{name}}</div>
			</div>
			<div class="item">
				<div class="title">전화번호</div>			
				<div class="value">{{phone}}</div>
			</div>
			<div class="item">		
				<div class="title">주민번호</div>			
				<div class="value">{{registrationNumber}}</div>
			</div>
			<div class="item">		
				<div class="title">은행명</div>			
				<div class="value">{{bankName}}</div>
			</div>
			<div class="item">		
				<div class="title">계좌주</div>			
				<div class="value">{{accountHolderName}}</div>
			</div>
			<div class="item">		
				<div class="title">계좌번호</div>			
				<div class="value">{{accountNumber}}</div>
			</div>
			<div class="item">		
				<div class="title">신분증</div>			
				<div class="value"><a href="{{idCard}}">다운로드</a></div>
			</div>
			<div class="item">		
				<div class="title">통장사본</div>			
				<div class="value"><a href="{{copyOfBankbook}}">다운로드</a></div>
			</div>
			<div class="item">		
				<div class="title">실명확인</div>			
				<div class="value">{{inquiryName}}</div>
			</div>
			<div class="item">		
				<div class="title">승인여부</div>			
				<div class="value">{{approved}}</div>
			</div>
			<div class="btn-group">
				<button class="btn btn-outline-secondary btn-sm" onclick="approveAccount()">승인</button>
			</div>
		</div>
	</div>
</div>
</main>
</body>
</html>