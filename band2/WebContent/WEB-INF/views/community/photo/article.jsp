<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.bbs-article .table {
    margin-top: 15px;
}
.bbs-article .table thead tr, .bbs-article .table tbody tr {
    height: 30px;
}
.bbs-article .table thead tr th, .bbs-article .table tbody tr td {
    font-weight: normal;
    border-top: none;
    border-bottom: none;
}
.bbs-article .table thead tr {
    border-top: #d5d5d5 solid 1px;
    border-bottom: #dfdfdf solid 1px;
} 
.bbs-article .table tbody tr {
    border-bottom: #dfdfdf solid 1px;
}
.bbs-article .table i {
    background: #424951;
    display: inline-block;
    margin: 0 7px 0 7px;
    position: relative;
    top: 2px;
    width: 1px;
    height: 13px;    
}

.bbs-reply {
    font-family: NanumGothic, 나눔고딕, "Malgun Gothic", "맑은 고딕", 돋움, sans-serif;
}

.bbs-reply-write {
    border: #d5d5d5 solid 1px;
    padding: 10px;
    min-height: 50px;
}
</style>

<script type="text/javascript">
//-------------------------------------
//댓글 리스트
$(function(){
	listPage(1);
});

function listPage(page) {
	var url="<%=cp%>/photoBoard/photoReply/${boCateNum}/${url}";
	var photoNo="${dto.photoNo}";
	$.post(url, {photoNo:photoNo, pageNo:page}, function(data){
		$("#listReply").html(data);
	});
}

function login() {
	location.href="<%=cp%>/group/${url}";
}

//댓글 추가
function sendReply() {
	var uid="${sessionScope.main.userId}";
	if(! uid) {
		login();
		return false;
	}

	var photoNo="${dto.photoNo}"; // 해당 게시물 번호
	var content=$.trim($("#content").val());
	if(! content ) {
		alert("내용을 입력하세요 !!! ");
		$("#content").focus();
		return false;
	}
	
	var params="photoNo="+photoNo;
	params+="&content="+content;
	params+="&answer=0";
	
	$.ajax({
		type:"POST"
		,url:"<%=cp%>/photoBoard/photoCreatedReply/${boCateNum}/${url}"
		,data:params
		,dataType:"json"
		,success:function(data) {
			$("#content").val("");
			
			var state=data.state;
			if(state=="true") {
				listPage(1);
			} else if(state=="false") {
				alert("댓글을 등록하지 못했습니다. !!!");
			} else if(state=="loginFail") {
				login();
			}
		}
		,error:function(e) {
			alert(e.responseText);
		}
	});
}

//좋아요/싫어요 개수
function countLike(commentNo) {
	var url="<%=cp%>/photoBoard/photoReplyCountLike/${boCateNum}/${url}";
	$.post(url, {commentNo:commentNo}, function(data){
		var likeCountId="#likeCount"+commentNo;
		var disLikeCountId="#disLikeCount"+commentNo;
		var likeCount=data.likeCount;
		var disLikeCount=data.disLikeCount;
		
		$(likeCountId).html(likeCount);
		$(disLikeCountId).html(disLikeCount);
	}, "JSON");
}

//게시물 좋아요/싫어요 갯수
function countLike1(photoNo) {
	var url="<%=cp%>/photoBoard/photoCountLike/${boCateNum}/${url}";
	$.post(url, {photoNo:photoNo}, function(data){
		var likeCountId="#likeCount1"+photoNo;
		var disLikeCountId="#disLikeCount1"+photoNo;
		var likeCount=data.likeCount;
		var disLikeCount=data.disLikeCount;
		
		$(likeCountId).html(likeCount);
		$(disLikeCountId).html(disLikeCount);
	}, "JSON");
}

//좋아요/싫어요 추가
function sendLike(commentNo, replyLike) {
	var uid="${sessionScope.main.userId}";
	if(! uid) {
		login();
		return false;
	}

	var msg="게시물이 마음에 들지 않으십니까 ?";
	if(replyLike==1)
		msg="게시물에 공감하십니까 ?";
	if(! confirm(msg))
		return false;
	
	var params="commentNo="+commentNo;
	params+="&replyLike="+replyLike;

	$.ajax({
		type:"POST"
		,url:"<%=cp%>/photoBoard/photoReplyLike/${boCateNum}/${url}"
		,data:params
		,dataType:"json"
		,success:function(data) {
			
			var state=data.state;
			if(state=="true") {
				countLike(commentNo);
			} else if(state=="false") {
				alert("좋아요/싫어요는 한번만 가능합니다. !!!");
			} else if(state=="loginFail") {
				login();
			}
		}
		,error:function(e) {
			alert(e.responseText);
		}
	});
}

//게시물 좋아요,싫어요
function sendLike1(photoNo, photoLike) {
	var uid="${sessionScope.main.userId}";
	if(! uid) {
		login();
		return false;
	}

	var msg="게시물이 마음에 들지 않으십니까 ?";
	if(photoLike==1)
		msg="게시물에 공감하십니까 ?";
	if(! confirm(msg))
		return false;
	
	var params="photoNo="+photoNo;
	params+="&photoLike="+photoLike;

	$.ajax({
		type:"POST"
		,url:"<%=cp%>/photoBoard/photoBoardLike/${boCateNum}/${url}"
		,data:params
		,dataType:"json"
		,success:function(data) {
			
			var state=data.state;
			if(state=="true") {
				countLike1(photoNo);
			} else if(state=="false") {
				alert("좋아요/싫어요는 한번만 가능합니다. !!!");
			} else if(state=="loginFail") {
				login();
			}
		}
		,error:function(e) {
			alert(e.responseText);
		}
	});
}

//댓글 삭제
function deleteReply(commentNo, page) {
	var uid="${sessionScope.main.userId}";
	if(! uid) {
		login();
		return false;
	}
	
	if(confirm("게시물을 삭제하시겠습니까 ? ")) {	
		var url="<%=cp%>/photoBoard/photoDeleteReply/${boCateNum}/${url}";
		$.post(url, {commentNo:commentNo, mode:"reply"}, function(data){
		        var state=data.state;

				if(state=="loginFail") {
					login();
				} else {
					listPage(page);
				}
		}, "json");
	}
}

//-------------------------------------
function deletePhoto() {
<c:if test="${sessionScope.main.userId=='admin' || sessionScope.main.userId==dto.userId}">
  var photoNo = "${dto.photoNo}";
  var page = "${page}";
  var params = "photoNo="+photoNo+"&page="+page;
  var url = "<%=cp%>/photoBoard/photoDelete/${boCateNum}/${url}?" + params;

  if(confirm("위 자료를 삭제 하시 겠습니까 ? "))
  	location.href=url;
</c:if>    
<c:if test="${sessionScope.main.userId!='admin' && sessionScope.main.userId!=dto.userId}">
  alert("게시물을 삭제할 수  없습니다.");
</c:if>
}

function updatePhoto() {
<c:if test="${sessionScope.main.userId==dto.userId}">
  var photoNo = "${dto.photoNo}";
  var page = "${page}";
  var params = "photoNo="+photoNo+"&page="+page;
  var url = "<%=cp%>/photoBoard/photoUpdate/${boCateNum}/${url}?" + params;

  location.href=url;
</c:if>

<c:if test="${sessionScope.main.userId!=dto.userId}">
 alert("게시물을 수정할 수  없습니다.");
</c:if>
}

</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-picture"></span> 포토갤러리 </h3>
    </div>
    
    <div class="alert alert-info">
        <i class="glyphicon glyphicon-info-sign"></i> 추억의 포토 갤러리를 회원과 공유할 수 있는 공간입니다.
    </div>
    
    <div class="table-responsive" style="clear: both;">
        <div class="bbs-article">
            <table class="table">
                 <thead>
                     <tr>
                         <th colspan="2" style="text-align: center;">
                                ${dto.subject}
                         </th>
                     </tr>
                <thead>
                 <tbody>
                     <tr>
                         <td style="text-align: left;">
                             이름 : ${dto.name}
                         </td>
                         <td style="text-align: right;">
                          ${dto.created}
                         </td>
                     </tr>
                     
                     <tr style="border-bottom:none;">
                         <td colspan="2">
                             <img src="<%=cp%>/uploads/photo/${dto.imageFilename}" style="max-width:100%; height:auto; resize:both;">
                         </td>
                     </tr>
                     
                     <tr>
                         <td colspan="2" style="min-height: 30px;">
                              ${dto.content}
                         </td>
                     </tr>
                     <tr>
                         <td colspan="2">
                              <span style="display: inline-block; min-width: 45px;">이전글</span> :
                              <c:if test="${not empty preReadDto }">
                                  <a href="<%=cp%>/photoBoard/photoArticle/${boCateNum}/${url}?${params}&photoNo=${preReadDto.photoNo}">${preReadDto.subject}</a>
                              </c:if>					
                         </td>
                     </tr>
                     <tr>
                         <td colspan="2" style="border-bottom: #d5d5d5 solid 1px;">
                              <span style="display: inline-block; min-width: 45px;">다음글</span> :
                              <c:if test="${not empty nextReadDto }">
                                  <a href="<%=cp%>/photoBoard/photoArticle/${boCateNum}/${url}?${params}&photoNo=${nextReadDto.photoNo}">${nextReadDto.subject}</a>
                              </c:if>
                         </td>
                     </tr>                                          
                </tbody>
                <tfoot>
                	<tr>
                		<td>
<c:if test="${sessionScope.main.userId==dto.userId}">
                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="updatePhoto();">수정</button>
</c:if>
<c:if test="${sessionScope.main.userId==dto.userId || sessionScope.main.userId=='admin'}">	                		    
                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="deletePhoto();">삭제</button>
</c:if>                		    
                		</td>
                		<td align="right">
                		<button type="button" class="btn btn-info btn-sm" onclick="sendLike1('${dto.photoNo}', '1')"><span class="glyphicon glyphicon-hand-up"></span> 좋아요 <span id="likeCount1${dto.photoNo}">${dto.likeCount}</span></button>
                        <button type="button" class="btn btn-warning btn-sm" onclick="sendLike1('${dto.photoNo}', '0')"><span class="glyphicon glyphicon-hand-down"></span> 싫어요 <span id="disLikeCount1${dto.photoNo}">${dto.disLikeCount}</span></button>
                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/photoBoard/list/${boCateNum}/${url}?${params}';"> 목록으로 </button>
                		</td>
                	</tr>
                </tfoot>
            </table>
       </div>
       
       <div class="bbs-reply">
           <div class="bbs-reply-write">
               <div style="clear: both;">
           	       <div style="float: left;"><span style="font-weight: bold;">댓글쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span></div>
           	       <div style="float: right; text-align: right;"></div>
               </div>
               <div style="clear: both; padding-top: 10px;">
                   <textarea id="content" class="form-control" rows="3"></textarea>
               </div>
               <div style="text-align: right; padding-top: 10px;">
                   <button type="button" class="btn btn-primary btn-sm" onclick="sendReply();"> 댓글등록 <span class="glyphicon glyphicon-ok"></span></button>
               </div>           
           </div>
       
           <div id="listReply"></div>
       </div>
   </div>

</div>