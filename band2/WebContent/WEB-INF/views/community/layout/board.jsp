<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style>
.list-group
{
    margin-bottom: 0;
}
.list-group .list-group-item
{
    border-width: 1px 0;
}
.list-group .list-group-item:first-child
{
    border-top-right-radius: 0;
    border-top-left-radius: 0;
}
.list-group .list-group-item:last-child
{
    border-bottom: 0;
}
.panel a.list-group-item.active:hover, a.list-group-item.active:focus
{
    color: #000;
    background-color: #DDD;
    border-color: #DDD;
}
.deletebtn{
	float:right; 
	cursor:pointer; 
	color:red; 
}
.deletebtn:hover, .deletebtn:focus{
	text-decoration: underline;
}
</style>

<script>
function list(transactionNo) {
	 	var url="<%=cp%>/community/accountList/${url}";
  	    $.post(url, {transactionNo:transactionNo}, function(data){
  		 $("#accountList").html(data);
  		 $("#accountList").show();
  	    });
}
</script>


<div style="min-height: 300px;">
<!-- Start : Board List -->
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="header">
						<br><br>
						<div style="text-align: center;">
						<h4 class="title" style="color: #5D5D5D; font-weight: bold;'">공지사항</h4>
						
						<p class="category">그룹 관련 공지사항을 확인하세요!</p>
						</div>
						
						<div class="content table-responsive table-full-width" style="width:95%; padding-left:130px;">
							<table class="table table-hover table-striped">
								<thead style="background-color: #fbdf80;">
									<tr>
										<th style="width: 15%; text-align: center; color:black;">번호</th>
										<th style="width: 50%; text-align: center; color:black;">내용</th>
										<th style="width: 25%; text-align: center; color:black;">날짜</th>
									</tr>
								</thead>
								<tbody style="text-align: center;">
									<c:forEach items="${nlist}" var="vo">
										<tr>
											<td>${vo.listNum}</td>
											<td>${vo.content}</td>
											<td>${vo.created}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Start : Board List -->
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="header">
						<br>
						<br>
						<div style="text-align: center;">
							<h4 class="title" style="color: #5D5D5D; font-weight: bold;'">회계내역</h4>

							<p class="category">그룹 회계 관련 결산 내역을 확인하세요!</p>
						</div>

						<div class="content table-responsive table-full-width"
							style="width: 95%; padding-left: 130px;">
							<ul class="list-group" style="list-style-type: none;">
								<c:forEach items="${accountList}" var="dto">
									<li><a href="#" onclick="list('${dto.transactionNo}');"
										class="list-group-item">
										<i class="fa fa-database"></i>
										[ <span style="color:#334e7e;">${dto.listName}</span> ] 결산 내역<c:if
												test="${sessionScope.main.grade==1||sessionScope.main.grade==2}">
												<span
													onclick="javascript:location.href='<%=cp%>/community/deleteList/${url}?listNum=${dto.listNum}';"
													class="deletebtn">삭제&nbsp;</span>
											</c:if>
											<i class="fa fa-chevron-down" style="float:right;"></i>
									</a></li>
								</c:forEach>
							</ul>
							<br><br>
							<div id="accountList" style="display: none;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</div>
