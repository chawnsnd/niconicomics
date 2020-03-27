<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="./layout/global.jsp"%>
</head>
<body>
<%@ include file="./layout/header.jsp"%>
<%@ include file="./layout/nav.jsp"%>
<main>
<form action="./account/enroll" method="post">
	이름: <input type="text" name="name"><br>
	전화번호: <input type="text" name="phone"><br>
	주민번호: <input type="text" name="registrationNumber"><br>
	은행: <input type="text" name="bankName"><br>
	계좌주: <input type="text" name="accountHolderName"><br>
	계좌번호: <input type="text" name="accountNumber"><br>
	신분증: <input type="file" name="idCard"><br>
	통장사본: <input type="file" name="copyOfBankbook"><br>
	<input type="submit" value="등록">
</form>
</main>
<%@ include file="./layout/footer.jsp"%>
</body>
</html>