<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style>
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
</style>

<script type="text/javascript">
function updateFee(memberNo, state, eventNo) {
	
  var params="memberNo="+memberNo+"&state="+state+"&eventNo="+eventNo;
  
  if(state=="N"){
	  var url="<%=cp%>/account/updateFee/${url}";
  }
  if(state=="Y"){
	  var url="<%=cp%>/account/updateFeeN/${url}";
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
</script>

<div class="tab-content">
	<div id="eventTable">
		<p>[${detailDto.eventName}]회비 납부율 - ${detailDto.eventFee} -
			${detailDto.todate}까지 ${ratio}%</p>
		<div class="">
			<div class="progress progress_sm" style="width: 100%;">
				<div class="progress-bar bg-green" role="progressbar"
					data-transitiongoal="50"></div>
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
						<td>${dto.grade}</td>
						<td>${dto.tel}</td>
						<td>${dto.email}</td>
						<td>
						<c:if test="${dto.fee=='N'}">                   
                        <a onclick="updateFee('${dto.memberNo}','N','${dto.eventNo}');" class="aa">미납부</a>
                        </c:if>
                        <c:if test="${dto.fee=='Y'}">                   
                        <a onclick="updateFee('${dto.memberNo}','Y','${dto.eventNo}');" class="bb">납부</a>
                        </c:if> 
                    </td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
