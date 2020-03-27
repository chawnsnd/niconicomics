<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="./layout/global.jsp"%>
<script>
$(function(){
	$("#submit").on("click", function(){
		enrollAccount();
	})
})
function enrollAccount(){
	var form = $('#accountForm')[0];
    var formData = new FormData(form);
	$.ajax({
		url: "../account/${sessionScope.loginUser.userId}",
		type: "post",
		data: formData,
        contentType : false,
        processData : false,
		success: function(result){
			if(result){
				alert("등록이 성공되었습니다.");
				location.href = "<c:url value='/dashboard/account'/>";	
			}else{
				alert("등록이 실패되었습니다.");
			}
		},
		error: function(err){
			console.log(err);
		}
	});
}
</script>
</head>
<body>
<%@ include file="./layout/header.jsp"%>
<%@ include file="./layout/nav.jsp"%>
<main>
<form id="accountForm">
	이름: <input type="text" id="name" name="name"><br>
	전화번호: <input type="text" id="phone" name="phone"><br>
	주민번호: <input type="text" id="registrationNumber" name="registrationNumber"><br>
	은행: <input type="text" id="bankName" name="bankName"><br>
	계좌주: <input type="text" id="accountHolderName" name="accountHolderName"><br>
	계좌번호: <input type="text" id="accountNumber" name="accountNumber"><br>
	신분증: <input type="file" id="idCardImg" name="idCardImg"><br>
	통장사본: <input type="file" id="copyOfBankbookImg" name="copyOfBankbookImg"><br>
</form>
<button id="submit">등록</button>
</main>
<%@ include file="./layout/footer.jsp"%>
</body>
</html>