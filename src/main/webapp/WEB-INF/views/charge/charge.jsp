<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>충전페이지</title>
<script src="./resources/js/jquery-3.4.1.min.js"></script>
<script>
$(function(){
	$.ajax({
		url: "./charge/userinfo-temp",
		method: "get",
		success: function(user){
			$("#nico").html(user.nico+"니코");
		}
	});
})
function charge(){
	var item = $("input[name='item']:checked").val();
	$.ajax({
		url: "./charge/kakaopay-ready",
		method: "get",
		data: {
			item: item
		},
		success: function(url){
			location.href = url;
		}
	});
}
</script>
</head>
<body>
	<label><input name="item" value="1000니코" type="radio">1000니코</label>
	<label><input name="item" value="2000니코" type="radio">2000니코</label>
	<label><input name="item" value="3000니코" type="radio">3000니코</label>
	<hr/>
	<input type="submit" value="충전하기" onclick="charge()">
	<hr/>
	<span>충전된 니코 : </span><span id="nico"></span>
</body>
</html>