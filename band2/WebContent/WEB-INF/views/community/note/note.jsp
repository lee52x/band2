<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
$(function(){
	listNote("listReceive");
});

//탭을 선택 한 경우
$(function(){
	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		var active=$(this).attr("aria-controls");
		
		if(active=="listReceive"||active=="listSend")
		    listNote(active);
		else
			sendNoteForm();
	});	
});

function listNote(mode) {
	var url="<%=cp%>/community/noteList/${url}";
	
	$.get(url, {mode:mode}, function(data){
		var s=$.trim(data);
		if(s=="loginFail") {
			location.href="<%=cp%>/group/${url}";
			return;	
		}
		
		var id;
		if(mode=="listReceive") {
			id="#tabListReceive";
			$("#tabListSend").html(""); // noteSearchKey등의 id가 중복 되므로 다른 탭의 데이터는 지움
		} else {
			id="#tabListSend";
			$("#tabListReceive").html("");
		}
		
		$(id).html(data);
	});
}

function sendNoteForm() {
	var url="<%=cp%>/community/noteSend/${url}";
	
	$.get(url, {dumi:new Date().getTime()}, function(data){
		var s=$.trim(data);
		if(s=="loginFail") {
			location.href="<%=cp%>/group/${url}";
			return;	
		}
		
		$("#tabSend").html(data);
	});
}
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-envelope"></span> 쪽지관리 </h3>
    </div>
    
    <div class="alert alert-info">
        <i class="glyphicon glyphicon-info-sign"></i> 소중한 친구에게 쪽지를 보내거나 받은 쪽지를 확인할 수 있는 공간 입니다.
    </div>

    <div>
	    <div role="tabpanel">
			  <ul id="noteTab" class="nav nav-tabs" role="tablist">
			      <li role="presentation"  class="active"><a href="#tabListReceive" aria-controls="listReceive" role="tab" data-toggle="tab">받은 쪽지함</a></li>
		          <li role="presentation"><a href="#tabListSend" aria-controls="listSend" role="tab" data-toggle="tab">보낸 쪽지함</a></li>
		          <li role="presentation"><a href="#tabSend" aria-controls="send" role="tab" data-toggle="tab">쪽지 보내기</a></li>
			  </ul>
			
			  <div class="tab-content" style="padding: 5px; margin-top: 15px;">
			      <div role="tabpanel" class="tab-pane active" id="tabListReceive"></div>
			      <div role="tabpanel" class="tab-pane" id="tabListSend"></div>
			      <div role="tabpanel" class="tab-pane" id="tabSend"></div>
			  </div>
	    </div>
    </div>
    
</div>