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


function login() {
	location.href="<%=cp%>/member/login";
}


//-------------------------------------
function deleteBoard() {
<c:if test="${sessionScope.main.userId=='admin' || sessionScope.main.userId==dto.userId}">
  var boardNo = "${dto.boardNo}";
  var page = "${page}";
  var params = "boardNo="+boardNo+"&page="+page;
  var url = "<%=cp%>/freeBoard/delete/${boCateNum}/${url}?" + params;

  if(confirm("위 자료를 삭제 하시 겠습니까 ? "))
  	location.href=url;
</c:if> 

<c:if test="${sessionScope.main.userId!='admin' && sessionScope.main.userId!=dto.userId}">
  alert("게시물을 삭제할 수  없습니다.");
</c:if>
}

function updateBoard() {
<c:if test="${sessionScope.main.userId==dto.userId}">
  var boardNo = "${dto.boardNo}";
  var page = "${page}";
  var params = "boardNo="+boardNo+"&page="+page;
  var url = "<%=cp%>/freeBoard/update/${boCateNum}/${url}?" + params;

  location.href=url;
</c:if>

<c:if test="${sessionScope.main.userId!=dto.userId}">
 alert("게시물을 수정할 수  없습니다.");
</c:if>
}

function login() {
	location.href="<%=cp%>/group/{url}";
}
//-------------------------------------
//댓글 리스트
$(function(){
	listPage(1);
});

function listPage(page) {
	var url="<%=cp%>/freeBoard/listReply/${boCateNum}/{url}";
	var boardNo="${dto.boardNo}";
	$.post(url, {boardNo:boardNo, pageNo:page}, function(data){
		$("#listReply").html(data);
	});
}

function login() {
	location.href="<%=cp%>/group/{url}";
}

//댓글 추가
function sendReply() {
	var uid="${sessionScope.main.userId}";
	if(! uid) {
		login();
		return false;
	}

	var boardNo="${dto.boardNo}"; // 해당 게시물 번호
	var content=$.trim($("#content").val());
	if(! content ) {
		alert("내용을 입력하세요 !!! ");
		$("#content").focus();
		return false;
	}
	
	var params="boardNo="+boardNo;
	params+="&content="+content;
	
	$.ajax({
		type:"POST"
		,url:"<%=cp%>/freeBoard/insertReply/${boCateNum}/${url}"
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
//댓글 삭제
function deleteReply(replyNum,page){
	var uid="${sessionScope.main.userId}";
	if(! uid){
		login();
		return false;
	}
	
	if(confirm("댓글을 삭제하시겠습니까?")){
		var url="<%=cp%>/freeBoard/deleteReply/${boCateNum}/${url}";
		$.post(url,{replyNum:replyNum},function(data){
			var state=data.state;
				
				if(state=="loginFail"){
					login();
				}else{
					listPage(page);
				}
		},"json");
	}
}



</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-book"></span> 게시판 </h3>
    </div>
    
    <div class="alert alert-info">
        <i class="glyphicon glyphicon-info-sign"></i> 회원과 자유로이 토론할 수 있는 공간입니다.
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
                             이름 : ${sessionScope.main.userId}
                         </td>
                         <td style="text-align: right;">
                          ${dto.created}<i></i>조회 ${dto.hitCount}
                         </td>
                     </tr>
                     <tr>
                         <td colspan="2" style="height: 230px;">
                              ${dto.content}
                         </td>
                     </tr>
                     <tr>
                         <td colspan="2">
                              <span style="display: inline-block; min-width: 45px;">첨부</span> :
                              <c:if test="${not empty dto.saveFilename}">
                                  <a href="<%=cp%>/freeBoard/download/${boCateNum}/${url}?boardNo=${dto.boardNo}"><span class="glyphicon glyphicon-download-alt"></span> ${dto.originalFilename}</a>
                              </c:if>
                         </td>
                     </tr>
                     <tr>
                         <td colspan="2">
                              <span style="display: inline-block; min-width: 45px;">이전글</span> :
                              <c:if test="${not empty preReadDto }">
                                  <a href="<%=cp%>/freeBoard/article/${boCateNum}/${url}?${params}&boardNo=${preReadDto.boardNo}">${preReadDto.subject}</a>
                              </c:if>					
                         </td>
                     </tr>
                     <tr>
                         <td colspan="2" style="border-bottom: #d5d5d5 solid 1px;">
                              <span style="display: inline-block; min-width: 45px;">다음글</span> :
                              <c:if test="${not empty nextReadDto }">
                                  <a href="<%=cp%>/freeBoard/article/${boCateNum}/${url}?${params}&boardNo=${nextReadDto.boardNo}">${nextReadDto.subject}</a>
                              </c:if>
                         </td>
                     </tr>                                          
                </tbody>
                <tfoot>
                	<tr>
                		<td>
<c:if test="${sessionScope.main.userId==dto.userId}">
                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="updateBoard();">수정</button>
</c:if>
<c:if test="${sessionScope.main.userId==dto.userId || sessionScope.main.userId=='admin'}">	                		    
                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="deleteBoard();">삭제</button>
</c:if>                		    
                		</td>
                		<td align="right">
                		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/freeBoard/list/${boCateNum}/${url}?${params}';"> 목록으로 </button>
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