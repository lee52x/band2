

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>



<script type="text/javascript">
//방명록답글 리스트
$(function(){
	listPage1();
});

function listPage1(){
	
	$.post(url,function(data){
		$("#guestAnswer").html(data);
	});
}


//답글보기 클릭시 답글리스트
function viewReply(guestNo)
{
	var uid="${sessionScope.main.userId}";
	if(! uid){
		login();
		return false;
	}
	var params="guestNo"+guestNo;
	
	$.ajax({
		type:"POST"
	   ,url:"<%=cp%>/guestBoard/viewReply/${url}"
	   ,data:params
	   ,dataType:"json"
	   ,succes:function(data){
		   listPage1();
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
<div class="stream-list" >
								
									<div class="media stream">
										<a href="#" class="media-avatar medium pull-left">
											<img src="<%=cp%>/res/img/user.png">
										</a>
											<div class="stream-headline">
												<h5 class="stream-author">
											<p style="font-weight: bolder;">${dto.name }</p>
												<small>${dto.created}</small>
													<p align="right">
													<a onclick="deleteGuest('${dto.guestNo}','${dto.imageFilename}')"><span style="color: red" class="icon-trash shaded">Delete</span></a>
													</p>
													
												</h5>
												
												
													
										
												<div class="stream-text">
												<br><br>
													${dto.content}
													 <br>
													 <c:if test="${not empty dto.imageFilename}">
													 	<div class="stream-attachment photo">
													<div class="responsive-photo">
			
			<p> <img src="<%=cp%>/uploads/guest/${dto.imageFilename}">
			</p>
			</c:if>
													</div>
												</div>
												<c:if test="${not empty dto.player}">
                                              <div class="stream-attachment video">
													<div class="responsive-video">
														
                                                        
			<iframe width="640" height="360" src="http://www.youtube.com/embed/${dto.player}">
</iframe>
  
			</c:if>
                                                        
													</div>
												</div>
												
													<div class="stream-options" >
													
												<a  href="javascript:sendLike('${dto.guestNo}','1')">&nbsp<span class="icon-thumbs-up shaded"></span>Like<span id="likeCount${dto.guestNo}">${dto.likeCount}</span>
													
												</a>
												<a href="javascript:sendReplyAnswerDlg('${dto.guestNo}');"  class="btn btn-small">
													<i class="icon-reply shaded"></i>
													Reply
												</a>
												<a href="" class="btn btn-small">
													<i class="icon-retweet shaded"></i>
													Repost
												</a>
												
												  <button class="pull-right" type="button" onclick="viewReply(${dto.guestNo});">댓글보기</button>
												
												
											</div>

		 </c:forEach>
		 <div id="guestAnswer"></div>
	
	
	
	<div id="modalReply" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					댓글작성
			</div>
			<div class="modal-body">
			    <form name="modalReplyForm" method="post">
			         <div class="form-group">
			            <label class="control-label" for="modalContent">작성자:${dto.name}</label><br>
			           
			            <div class="row-fluid">
						<input type="text"  id="modalContent" name="content" placeholder="내용을 입력하세요" style="width: 510px"  >
						<input type="hidden" id="modalGuestNo" name="guestNo">
						<button class="btn btn-primary" type="button" onclick="modalSendReply();">등록</button>
						</div>
			        </div>
			        
			        <div class="form-group" align="right">
			        	
			           
			            
                    </div>
                    
	
			    </form>
			</div>
		</div>
	</div>
	
</div>



								<div class="stream-respond" align="center" id="response">
												<div class="media stream" align="left">
													<a href="#" class="media-avatar small pull-left">
														<img src="<%=cp%>/res/img/user.png">
													</a>
													<div class="media-body">
														<div class="stream-headline">
															<h5 class="stream-author">
																John Donga 
																<small>10 July 14</small>
															</h5>
															<div class="stream-text">
																Lorem Ipsum is simply dummy text of the printing and typesetting industry.
															</div>
														</div><!--/.stream-headline-->
													</div>
												</div><!--/.media .stream-->
										
											</div><!--/.stream-respond-->
	
	
	
	
	
	
