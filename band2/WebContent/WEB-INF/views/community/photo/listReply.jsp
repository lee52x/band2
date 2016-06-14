<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<c:if test="${dataCount!=0}">
<script type="text/javascript">
// 댓글별 답글 리스트
function listAnswer(answer) {
	var listReplyAnswerId="#listReplyAnswer"+answer;
	var url="<%=cp%>/photoBoard/photoReplyAnswer/${url}";
	$.post(url, {answer:answer}, function(data){
		$(listReplyAnswerId).html(data);
	});
}

// 댓글별 답글 갯수
function countAnswer(answer) {
	var url="<%=cp%>/photoBoard/photoCountAnswer/${url}";
	$.post(url, {answer:answer}, function(data){
		var count="("+data.count+")";
		var answerCountId="#answerCount"+answer;
		var answerGlyphiconId="#answerGlyphicon"+answer;
		
		$(answerCountId).html(count);
		$(answerGlyphiconId).removeClass("glyphicon-triangle-bottom");
		$(answerGlyphiconId).addClass("glyphicon-triangle-top");
	}, "JSON");
}

// 댓글별 답글 폼
function replyAnswerLayout(commentNo) {
	var id="#replyAnswerLayout"+commentNo;
	var replyContent="#replyContent"+commentNo;
	var answerGlyphiconId="#answerGlyphicon"+commentNo;
	
	if($(id).is(':hidden')) {
		$("[id*=replyAnswerLayout]").hide();
		
		$("[id*=answerGlyphicon]").each(function(){
			$(this).removeClass("glyphicon-triangle-top");
			$(this).addClass("glyphicon-triangle-bottom");
		});
		
		listAnswer(commentNo);
		countAnswer(commentNo);
		
		$(id).show();
		$(answerGlyphiconId).removeClass("glyphicon-triangle-bottom");
		$(answerGlyphiconId).addClass("glyphicon-triangle-top");
	}  else {
		$(id).hide();
		$(answerGlyphiconId).removeClass("glyphicon-triangle-top");
		$(answerGlyphiconId).addClass("glyphicon-triangle-bottom");
	}
}

// 댓글별 답글 추가
function sendReplyAnswer(photoNo,commentNo) {
	var uid="${sessionScope.main.userId}";
	if(! uid) {
		login();
		return false;
	}
	
	var rta="#replyContent"+commentNo;
	var content=$.trim($(rta).val());
	if(! content ) {
		alert("내용을 입력하세요 !!!\n");
		$(rta).focus();
		return false;
	}
	
	var params="photoNo="+photoNo;
	params+="&content="+content;
	params+="&answer="+commentNo;
	
	$.ajax({
		type:"POST"
		,url:"<%=cp%>/photoBoard/photoCreatedReply/${url}"
		,data:params
		,dataType:"json"
		,success:function(data) {
			$(rta).val("");
			
  			var state=data.state;
			if(state=="true") {
				listAnswer(commentNo);
				countAnswer(commentNo);
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

// 댓글별 답글 삭제
function deleteReplyAnswer(commentNo, answer) {
	var uid="${sessionScope.main.userId}";
	if(! uid) {
		login();
		return false;
	}
	
	if(confirm("게시물을 삭제하시겠습니까 ? ")) {	
		var url="<%=cp%>/photoBoard/photoDeleteReply/${url}";
		$.post(url, {commentNo:commentNo, mode:"answer"}, function(data){
		        var state=data.state;
				if(state=="loginFail") {
					login();
				} else {
				    listAnswer(answer);
				    countAnswer(answer);
				}
		}, "json");
	}
}
</script>
</c:if>

<div style="clear: both; padding-top: 20px;">
    <div style="float: left;"><span style="color: #3EA9CD; font-weight: bold;">댓글 ${replyCount}개</span> <span>[댓글 목록, ${pageNo}/${total_page} 페이지]</span></div>
    <div style="float: right; text-align: right;"></div>
</div>
              
<div style="clear: both; padding-top: 5px;">

<c:forEach var="vo" items="${listReply}">
    <!-- 리플 내용 리스트 시작 -->
    <div style="clear:both; margin-top:5px; padding: 10px; border: #d5d5d5 solid 1px; min-height: 130px;">
        <div style="clear: both;">
            <div style="float: left;">${vo.name} | ${vo.created}</div>
            <div style="float: right;  text-align: rigth;">
<c:if test="${sessionScope.main.userId==vo.userId || sessionScope.main.userId=='admin'}">		   
                <a onclick='deleteReply("${vo.commentNo}", "${pageNo}");'>삭제</a>
</c:if>		   
<c:if test="${sessionScope.main.userId!=vo.userId && sessionScope.main.userId!='admin'}">		   
                <a href='#'>신고</a>
</c:if>		   
            </div>
        </div>
        <div style="clear: both; padding: 5px 0 5px 0px;  min-height: 70px;">
            ${vo.content}
        </div>
        <div style="clear: both; min-height: 30px;">
            <div style="float: left;">
                <button type="button" class="btn btn-primary btn-sm" onclick="replyAnswerLayout('${vo.commentNo}');">답글<span id="answerCount${vo.commentNo}">(${vo.answerCount})</span> <span id="answerGlyphicon${vo.commentNo}" class="glyphicon glyphicon-triangle-bottom"></span></button>
            </div>
            <div style="float: right; text-align: rigth;">
                <button type="button" class="btn btn-info btn-sm" onclick="sendLike('${vo.commentNo}', '1')"><span class="glyphicon glyphicon-hand-up"></span> 좋아요 <span id="likeCount${vo.commentNo}">${vo.likeCount}</span></button>
                <button type="button" class="btn btn-warning btn-sm" onclick="sendLike('${vo.commentNo}', '0')"><span class="glyphicon glyphicon-hand-down"></span> 싫어요 <span id="disLikeCount${vo.commentNo}">${vo.disLikeCount}</span></button>
            </div>                        
        </div>

        <!-- 답글 시작 -->
        <div id="replyAnswerLayout${vo.commentNo}" style="display: none;">
            <div style="clear: both; margin-top:10px; padding: 5px; border-top: #d5d5d5 solid 1px;">
                <textarea id="replyContent${vo.commentNo}" class="form-control" rows="3" required="required"></textarea>
            </div>
            <div style="text-align: right; padding-top: 7px;">
                <button type="button" class="btn btn-primary btn-sm" onclick="sendReplyAnswer('${vo.photoNo}', '${vo.commentNo}')"> 답글등록 </button>
            </div>

            <!-- 답글 리스트 -->       
            <div id="listReplyAnswer${vo.commentNo}" style="padding-top: 5px;"></div>
        </div> <!-- 답글 끝 -->
                        
    </div>  <!-- 리플 내용 리스트 끝 -->
</c:forEach>
</div>
              
<div style="clear: both; padding-top: 10px; text-align: center;">
    ${paging}
</div>
