<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
$(function(){
// 	getUser();
})
function donate(){
	$.ajax({
		url: "<c:url value='/api/nico/donate'/>",
		type: "post",
		data: {
			authorId: 1,
			sponsorId: ${sessionScope.loginUser.userId},
			nico: $("#donateNico").val()
		},
		success: function(){	
			$(".modal").css("display", "none");
		},
		error: function(err){
			console.log(err);
		}
	})
}
</script>
<!-- Modal -->
<div class="modal fade" id="supportModal" tabindex="-1" role="dialog" aria-labelledby="supportModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Donation</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div>작가</div>
        <div>${webtoonId}의 작가</div>
        
        <div>충전된 금액</div>
        <div>20000</div> NICO
        
        <div>후원금액</div>
        <div>
        <input type="number" id="donateNico"> NICO
        </div>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" onclick="donate()">후원하기</button>
      </div>
    </div>
  </div>
</div>