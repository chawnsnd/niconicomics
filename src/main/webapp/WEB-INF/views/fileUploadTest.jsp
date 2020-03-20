<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<c:url value="/resources/js/jquery-3.4.1.min.js" />"></script>
<script>
var images = [];
var imageTypes = ['image/png', 'image/gif', 'image/jpeg', 'image/bmp', 'image/x-icon'];
$(function(){
	$("#uploadInput").on("change", function(){
		console.dir(this);
		imageUpload(this.files[0]);
	})
})
function imageUpload(file){
	if(!isImage(file)){
		return alert("지원하지 않는 형식입니다..");
	}
	
	var form = $('#uploadForm')[0];
    var formData = new FormData(form);
	$.ajax({
		url: "/core/file-upload-test",
		method: "post",
		data: formData,
        contentType : false,
        processData : false,
        success: function(data){
            console.log(data)
        }
	})
}
function isImage(file){
	if(imageTypes.indexOf(file.type)<0){
		return false;
	}else{
		return true;
	}
}
</script>
</head>
<body>
<form id="uploadForm">
<input type="file" name="image" value="이미지추가" id="uploadInput">
</form>
</body>
</html>