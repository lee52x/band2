

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>



<script type="text/javascript">



//답글보기 클릭시 답글리스트
function viewReply(guestNo)
{	
	$("#button1"+guestNo).html("댓글닫기");
	$("#button1"+guestNo).click(function(){
		   $("#listReplyAnswer"+guestNo).hide();
		   $("#button1"+guestNo).html("댓글보기");
		 });
	
	
	
	var uid="${sessionScope.main.userId}";
	if(! uid){
		login();
		return false;
	}
	var params="guestNo="+guestNo;

	$.ajax({
		type:"POST"
	   ,url:"<%=cp%>/guestBoard/viewReply/${url}"
	   ,data:params
	   ,success:function(data){
		  // $("#listReplyAnswer").html(data);
		  $("#listReplyAnswer"+guestNo).html(data);
	   }
	   ,error:function(e){
		   alert(e.responseText);
	   }
	   
	  
		
	   
	});

}



function modalSendReply(){
	
	var f=document.modalReplyForm;
	
	if(!f.content.value){
		f.content.focus();
		return false;
	}
	
	var guestNo=$("#modalGuestNo").val();
	
	var params="content="+f.content.value;
	params+="&answer="+guestNo;
	
	$.ajax({
		type:"POST"
		,url:"<%=cp%>/guestBoard/created/${url}"
		,data:params
		,dataType:"json"
		,success:function(data) {
			$(content).val("");
			
  			var state=data.state;
			if(state=="true") {
				$("#modalReply").modal("hide");
				listPage(1);
				
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

function sendReplyAnswerDlg(guestNo){
	 $("#modalContent").val("");
	 $("#modalGuestNo").val(guestNo);
	 $("#modalReply").modal("show");	
     $("#modalUserId").focus();
}

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
		,url:"<%=cp%>/guestBoard/createdReply/${url}"
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
<c:forEach var="dto" items="${list}">
	<div class="stream-list">

		<div class="media stream">
		
			<div class="stream-headline">
				<h5 class="stream-author">
					<p style="font-weight: bold; color:#5d5d5d;">${dto.name }
						<a onclick="deleteGuest('${dto.guestNo}','${dto.imageFilename}')"
							class="btn btn-small pull-right"
							style="border-radius:0px; background-color:#bdbdbd; color:#FFF; padding: 5px 6px;"><span
							style="margin-left: 0px;" class="icon-remove shaded pull-right"></span></a>
					</p>
					<small>${dto.created}</small>




				</h5>




				<div class="stream-text">
					<br> ${dto.content} <br>
					
					
					
					<c:if test="${not empty dto.imageFilename}">
					<br><br>
						<div class="stream-attachment photo">
							<div class="responsive-photo">
								
								<p style="margin-bottom: 0px;">
									<img src="<%=cp%>/uploads/guest/${dto.imageFilename}">
								</p>
					</c:if>
					
					
					
				</div>
			</div>
			
			
			
			
			<c:if test="${not empty dto.player}">
				<br><br>
				<div class="stream-attachment video">
					<div class="responsive-video">

						
						<iframe width="640" height="360" style="border: none;"
							src="http://www.youtube.com/embed/${dto.player}"> </iframe>
			</c:if>

<br><br>

		</div>
	</div>

	<div class="stream-options">


		<a href="javascript:sendLike('${dto.guestNo}','1')"
			class="btn btn-small" style="color: #fff; background-color:#334e7e ;border-color: #1DC7EA;"><span
			class="icon-thumbs-up shaded"></span>&nbsp;Like&nbsp;<span
			id="likeCount${dto.guestNo}">${dto.likeCount}</span> </a> <a
			href="javascript:sendReplyAnswerDlg('${dto.guestNo}');"
			class="btn btn-small"> <i class="icon-reply shaded"></i> Reply
		</a> <a href="" class="btn btn-small" style="margin-left: 0px;"> <i
			class="icon-retweet shaded"></i> Repost
		</a>

		<button class="btn btn-small pull-right" id="button1${dto.guestNo}"
			class="icon-retweet  pull-right" onclick="viewReply(${dto.guestNo});">댓글보기</button>


	</div>
	<div id="listReplyAnswer${dto.guestNo}"
		style="padding-top: 5px; min-height: 50px;"></div>
	 <hr style="border-top: 1px solid #e0e0e0"/>

</c:forEach>




<div id="modalReply" class="modal fade" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header"  style="background-color:#334e7e; color:#FFF; font-size: 20px; font-weight: bold;">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				댓글 쓰기
			</div>
			<div class="modal-body">
				<form name="modalReplyForm" method="post">
					<div class="form-group">
						<label class="control-label" for="modalContent">작성자: ${sessionScope.main.userName} </label><br>

						<div class="row-fluid">
							<input type="text" id="modalContent" name="content"
								placeholder="내용을 입력하세요" style="width: 470px"> <input
								type="hidden" id="modalGuestNo" name="guestNo">
							&nbsp;<button class="btn btn-primary" type="button"
								onclick="modalSendReply();">등록</button>
						</div>
					</div>

					<div class="form-group" align="right"></div>


				</form>
			</div>
		</div>
	</div>

</div>







