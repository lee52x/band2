<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<style type="text/css">
.guest {
    font-family: NanumGothic, 나눔고딕, "Malgun Gothic", "맑은 고딕", 돋움, sans-serif;
}
.guest-write {
    border: #d5d5d5 solid 1px;
    padding: 10px;
    min-height: 50px;
}

.table td {
    font-weight: normal;
    border-top: none;
}
.table .guest-header{
    border: #d5d5d5 solid 1px;
    background: #eeeeee; color: #787878;
} 
</style>

<script type="text/javascript">
$(function(){
	listPage(1);
});

function listPage(page) {
	var url="<%=cp%>/community/guestList/${url}";
	$.post(url, {pageNo:page}, function(data){
		printGuest(data);
	}, "JSON");
}

function sendGuest() {
	var uid="${sessionScope.main.userId}";
	if(! uid) {
		alert("로그인이 필요 합니다.");
		return false;
	}
	
	var content=$.trim($("#content").val());
	
	var params="content="+content;
	
	$.ajax({
		type:"POST"
		,url:"<%=cp%>/community/guestCreated/${url}"
		,data:params
		,dataType:"JSON"
		,success:function(data) {
			var isLogin=data.isLogin;
			if(isLogin=="false") {
				location.href="<%=cp%>/group/${url}";
				return false;
			}
			
			printGuest(data);
			$("#content").val("");
		}
		,beforeSend:check
		,error:function(e) {
			alert(e.responseText);
		}
	});
}

function check() {
	if(! $.trim($("#content").val()) ) {
		$("#content").focus();
		return false;
	}
	
	return true;
}

function deleteGuest(guestNo, page) {
	var uid="${sessionScope.main.userId}";
	if(! uid) {
		alert("로그인이 필요 합니다.");
		return;
	}
	
	if(confirm("게시물을 삭제하시겠습니까 ? ")) {	
		var url="<%=cp%>/community/guestDelete/${url}}";
		$.post(url, {guestNo:guestNo, pageNo:page}, function(data){
			var isLogin=data.isLogin;
			if(isLogin=="false") {
				location.href="<%=cp%>/group/${url}";
				return;
			}

			printGuest(data);

		}, "JSON");
	}
}

function printGuest(data) {
	var uid="${sessionScope.main.userId}";
	var total_page=data.total_page;
	var dataCount=data.dataCount;
	var pageNo=data.pageNo;
	var paging=data.paging;
	
	var out="<div style='clear: both; padding-top: 20px;'>";
	out+="  <div style='float: left;'>";
	out+="    <span style='color: #3EA9CD; font-weight: bold;'>방명록 "+dataCount+"개</span>";
	out+="    <span>[목록, "+pageNo+"/"+total_page+" 페이지]</span>";
	out+="  </div>";
	out+="  <div style='float: right; text-align: right;'></div>";
	if(dataCount!=0) {
		out+="  <div class='table-responsive' style='clear: both; padding-top: 5px;'>";
		out+="    <table class='table'>";
		for(var idx=0; idx<data.list.length; idx++) {
			var num=data.list[idx].num;
			var name=data.list[idx].name;
			var userId=data.list[idx].userId;
			var content=data.list[idx].content;
			var created=data.list[idx].created;
			
			out+="    <tr class='guest-header'>";
			out+="      <td style='width: 50%;'>"+ name+"</td>";
			out+="      <td style='width: 50%; text-align: right;'>" + created;
			if(uid==userId || uid=="admin") {
				out+=" | <a onclick='deleteGuest(\""+guestNo+"\", \""+pageNo+"\");'>삭제</a></td>" ;
			} else {
				out+=" | <a href='#'>신고</a></td>" ;
			}
			out+="    </tr>";
			out+="    <tr style='height: 50px;'>";
			out+="      <td colspan='2'>"+content+"</td>";
			out+="    </tr>";
		}
		out+="    <tr style='height: 30px;'>";
		out+="      <td colspan='2' style='text-align: center;'>";
		out+=paging;
		out+="      </td>";
		out+="    </tr>";
		out+="  </table>";
	}
	
	$("#listGuest").html(out);
}
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-pencil"></span> 방명록 <small>Guest Book</small></h3>
    </div>
    
    <div class="alert alert-info">
        <i class="glyphicon glyphicon-info-sign"></i> 방문 소감을 남겨 주세요.
    </div>
    
    <div class="guest">
            <div class="guest-write">
               <div style="clear: both;">
           	       <div style="float: left;"><span style="font-weight: bold;">방명록쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span></div>
           	       <div style="float: right; text-align: right;"></div>
               </div>
               <div style="clear: both; padding-top: 10px;">
                   <textarea id="content" class="form-control" rows="3" required="required"></textarea>
               </div>
               <div style="text-align: right; padding-top: 10px;">
                   <button type="button" class="btn btn-primary btn-sm" onclick="sendGuest();"> 등록하기 <span class="glyphicon glyphicon-ok"></span></button>
               </div>           
           </div>
       
           <div id="listGuest"></div>
    </div>
</div>