<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
var webtoon;
$(function(){
	bindTemplate($("#modalTemplate"), {webtoon, me});
})
<c:if test="${sessionScope.loginUser != null}">
function donate(){
	$.ajax({
		url: "<c:url value='/api/donates'/>",
		type: "post",
		data: {
			authorId: webtoon.authorId,
			sponsorId: ${sessionScope.loginUser.userId},
			webtoonId: ${webtoonId},
			nico: $("#donateNico").val()
		},
		success: function(result){
			if(result){
				alert("후원이 성공하였습니다.")
				$("#closeModal").trigger("click");
				sock.send(JSON.stringify({
					userId: ${sessionScope.loginUser.userId},
					webtoonId: ${webtoonId},
					type: "DONATE",
					message: "${sessionScope.loginUser.nickname}님이 "+$("#donateNico").val()+"니코를 후원하였습니다."
				}))
			}else{
				alert("후원이 실패하였습니다.")
			}
		},
		error: function(err){
			console.log(err);
		}
	})
}
</c:if>
</script>
<!-- Modal -->
<div class="modal fade" id="supportModal" tabindex="-1" role="dialog" aria-labelledby="supportModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">DONATE</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <script id="modalTemplate" type="text/x-handlebars-template">
      <div class="modal-body">
        <div class="author"><h5>To. {{webtoon.authorNickname}}</h5></div>
		<div class="input-group mb-3">
			<input type="number" id="donateNico" class="form-control" placeholder="nico">
			<div class="input-group-prepend">
				<span class="input-group-text">	/ {{me.nico}} Nico</span>
			</div>
		</div>
      </div>
      </script>
      <div class="modal-footer">
        <button type="button" id="closeModal" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="donate()">후원하기</button>
      </div>
    </div>
  </div>
</div>