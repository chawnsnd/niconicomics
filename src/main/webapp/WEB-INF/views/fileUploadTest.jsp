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
var index = 1;
var imageTypes = ['image/png', 'image/gif', 'image/jpeg', 'image/bmp', 'image/x-icon'];
$(function(){
	$("#uploadInput").on("change", function(){
		uploadImage(this.files[0]);
	})
})
function uploadImage(file){
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
            console.log(data);
            $("#output").html("<img src = '"+data+"'><button onclick='deleteImage(`"+data+"`)'>삭제</button>")
        },
        error: function(err){
			console.log("이미지 저장 실패",err);
        }
	})
}

function deleteImage(path){
	$.ajax({
		url: "/core/file-delete-test",
		method: "post",
		data: {
			path: path
		},
        success: function(data){
            console.log("삭제성공");
            $("#output").html("");
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
<!-- <input type="number" name="index"> -->
<input type="file" name="image" value="이미지추가" id="uploadInput">
</form>
<div id="output"></div>
</body>
</html>