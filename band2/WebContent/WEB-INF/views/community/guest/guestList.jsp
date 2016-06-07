

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>


<script type="text/javascript">




// 댓글별 답글 추가
function sendReplyAnswer(guestNo) {
	var uid="${sessionScope.main.userId}";
	if(! uid) {
		login();
		return false;
	}
	
	
	var rta="#replyContent"+guestNo;
	var content=$.trim($(rta).val());
	if(! content ) {
		alert("내용을 입력하세요 !!!\n");
		$(rta).focus();
		return false;
	}
	

	
	var params="content="+content;
	params+="&answer="+guestNo;
	
	
	$.ajax({
		type:"POST"
		,url:"<%=cp%>/guest/createdReply/${url}"
		,data:params
		,dataType:"json"
		,success:function(data) {
			$(rta).val("");
			
  			var state=data.state;
			if(state=="true") {
				listAnswer(guestNo);
				countAnswer(guestNo);
			} else if(state=="false") {
				alert("답글을 등록하지 못했습니다. !!!");
			} else if(state=="loginFail") {
				login();
			}
		}
		,error:function(e) {
			alert(e.responseText);
		}
	});
}


</script>

<div class="panel panel-default">

	<c:forEach var="dto" items="${list}">

		<div class="panel-heading">
			<!-- <a href="#" class="pull-right">더보기</a> -->
			<h4>작성자:${dto.name}</h4>
			<h4>등록일:${dto.created}</h4>
			<h4 align="right">
			<h4 class="input-group-btn">
					<button  type="button" class="btn btn-primary pull-right" style="background: red" onclick="sendLike('${dto.guestNo}','1')"><span class="glyphicon glyphicon-thumbs-up"></span>좋아요<span id="likeCount${dto.guestNo}">${dto.likeCount}</span></button>
					<c:if test="${sessionScope.main.userId==dto.userId}">
					 <button class="btn btn-primary pull-right" type="button" onclick="deleteGuest('${dto.guestNo}','${dto.imageFilename}');">삭제</button>
					</c:if>
				</h4>
			</h4>
			</div>
			
				
				
			
		<div class="panel-body">
			${dto.content}
			</div>
			
		
			<c:if test="${not empty dto.player}">
			<iframe width="640" height="360" src="http://www.youtube.com/embed/${dto.player}">
</iframe>
  
			</c:if>
			
			<div class="clearfix"></div>
			<c:if test="${not empty dto.imageFilename}">
			<hr>
			<p> <img src="<%=cp%>/uploads/guest/${dto.imageFilename}" style="width: 580; height: 360;" border="0"></p>
			
			</c:if>
			
		

<!-- 답글 시작 -->
  
            <div style="float: left;">
                <button type="button" class="btn btn-primary btn-sm" onclick="replyAnswerLayout('${dto.guestNo}');">답글<span id="answerCount${dto.guestNo}"></span> <span id="answerGlyphicon${dto.guestNo}" class="glyphicon glyphicon-triangle-bottom"></span></button>
            </div>
                           
       
        
            
                <textarea id="replyContent${dto.guestNo}" class="form-control" rows="3" required="required"></textarea>
          
            <div style="text-align: right; padding-top: 7px;">
            
                <button type="button" class="btn btn-primary btn-sm" onclick="sendReplyAnswer('${dto.guestNo}')"> 답글등록 </button>
               <hr>
            </div>
      
      

          
      
                        </c:forEach>



	</div>
	

  



