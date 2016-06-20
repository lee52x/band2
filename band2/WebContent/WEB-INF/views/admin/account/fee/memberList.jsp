<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style>
.btn {
    margin-bottom: 0px;
}
.aa{
	color:red; 
	cursor:pointer;
}
.aa:hover, .aa:focus, .bb:hover, .bb:focus {
    color:#2A3F54;
}

.bb{
	color:#1ABB9C; 
	cursor:pointer;
}

.progressb{
	background-color: #1abb9c;
	border-radius: 15px;
}
</style>

<script type="text/javascript">

$(function(){
	var bar = document.getElementById("bar");
	var width = 1;
	var id = setInterval(frame, 0);
	var ratio = ${ratio};
	
	function frame(){
		if(width<=ratio){
			width++;
			bar.style.width=width+'%';
		}
		
	}
	
});

function updateFee(memberNo, state, eventNo) {
  var td=$("#fee_"+memberNo);
  var params="memberNo="+memberNo+"&state="+state+"&eventNo="+eventNo;
  if(state=="N"){
	  var url="<%=cp%>/account/updateFee/${url}";
	  $(td).empty();
	  $(td).append("<a onclick='updateFee("+memberNo+",\"Y\","+eventNo+");' class='bb'>납부</a>");
  }
  if(state=="Y"){
	  var url="<%=cp%>/account/updateFeeN/${url}";
	  $(td).empty();
	  $(td).append("<a onclick='updateFee("+memberNo+",\"N\","+eventNo+");' class='aa'>미납부</a>");
  }

$.ajax({
	type:"post"
	,url:url
	,data:params
	,dataType:"json"
	,success:function(data){
		
	}
	,error:function(e) {
		alert(e.responseText);
	}
});
}


function sendMail(){
  	var params="receiverEmail=";
  	
  	<c:forEach var="dto" items="${mailList}">
  		params+="${dto.email},";
    </c:forEach>
    
    <c:forEach var="dto" items="${leader}">
		params+="&senderName=${dto.name}&senderEmail=${dto.email}&tel=${dto.tel}";
		params+="&bankName=${dto.bankName}&accountNumber=${dto.accountNumber}";
		params+="&accountHolder=${dto.accountHolder}&groupName=${dto.groupName}";
	</c:forEach>
	
	params+="&todate=${detailDto.todate}&eventFee=${detailDto.eventFee}&eventName=${detailDto.eventName}";
  	
   
  	var url="<%=cp%>/account/mail/${url}";
	
  	$.ajax({
  		type:"post"
  		,url:url
  		,data:params
  		,dataType:"json"
  		,success:function(data){
  			alert("메일 전송이 성공적으로 완료되었습니다.");
  		}
  		,error:function(e) {
    		alert(e.responseText);
    	}
  	});
}

</script>

<div class="tab-content">
	<div>
		<div>
		마감:${detailDto.todate} / <i class="fa fa-won"></i>${detailDto.eventFee}
		<p style="float:right; margin-bottom:0">${ratio}%</p>
	    </div>
			
		<div class="">
			<div class="progress progress-sm" style="height: 10px; border-radius: 15px;" id="progress">
			<div class="progress-bar progress-bar-primary progressb" id="bar" role="progressbar" aria-valuenow="92" 
			aria-valuemin="0" aria-valuemax="100" style="width:1%">
			</div>
			</div>
		</div>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>이름</th>
					<th>회원등급</th>
					<th>전화번호</th>
					<th>메일주소</th>
					<th>납부여부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${memberList}">
					<tr>
						<td>${dto.name}</td>
						<td>				
						<c:choose>
							<c:when test="${dto.grade == 1}"><div class="btn btn-danger btn-xs">그룹장</div></c:when>
							<c:when test="${dto.grade == 2}"><div class="btn btn-warning btn-xs">운영진</div></c:when>
							<c:when test="${dto.grade == 3}"><div class="btn btn-info btn-xs">일　반</div></c:when>
							<c:when test="${dto.grade == 4}"><div class="btn btn-success btn-xs">O　&nbsp;&nbsp;B</div></c:when>
							<c:when test="${dto.grade == 5}"><div class="btn btn-default btn-xs">미가입</div></c:when>
						</c:choose></td>
						<td>${dto.tel}</td>
						<td>${dto.email}</td>
						<td id="fee_${dto.memberNo}"><c:if test="${dto.fee=='N'}">
								<a onclick="updateFee('${dto.memberNo}','N','${dto.eventNo}');"
									class="aa">미납부</a>
							</c:if> <c:if test="${dto.fee=='Y'}">
								<a onclick="updateFee('${dto.memberNo}','Y','${dto.eventNo}');"
									class="bb">납부</a>
							</c:if></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#mailModal"><i class="fa fa-envelope-o"></i> 미납자 메일 전송</button>
	</div>
</div>


<!-- Modal -->
<div class="modal fade" id="mailModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" style="padding-top:100px;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="background-color: #334e7e;">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true" style="color: white;">×</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">
					<small style="font-weight: bold; color: #e1e2e3;">	
					<i class="fa fa-envelope"></i> 미납자 메일 전송
					</small>
				</h4>
			</div>
			<div class="modal-body">
			<small style="color: grey;">※미납 회원들에게 일괄적으로 회비 안내 메일을 보내드립니다.</small><br>
			<small style="color: grey;">※메일이 정상적으로 전송되지 않을 경우 회원 메일 주소를 확인하세요.</small>
			<hr>
				<table class="table table-bordered">
			<thead>
				<tr>
					<th>이름</th>
					<th>메일주소</th>
					<th>납부여부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${mailList}">
					<tr>
						<td>${dto.name}</td>
						<td>${dto.email}</td>
						<td id="fee_${dto.memberNo}">
						<a onclick="updateFee('${dto.memberNo}','N','${dto.eventNo}');"
									class="aa">미납부</a></td>
					</tr>
				</c:forEach>
			  </tbody>
			</table>
			<hr>
			<button type="button" class="btn btn-default btn-sm" onclick="sendMail();"><i class="fa fa-envelope-o"></i> 보내기</button>
			<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">전송 취소</button>
			</div>
		</div>
	</div>
</div>