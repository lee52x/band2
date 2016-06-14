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
</style>

<script>
function list(transactionNo) {

  	var url="<%=cp%>/community/accountList/${url}";
  	
  	$.post(url, {transactionNo:transactionNo}, function(data){
  		$("#accountList").html(data);
	});	
}
</script>

		<!-- Start : Board List -->

<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="card">
				<div class="header">
					<h4 class="title">공 지 사 항</h4>
					<p class="category">공지사항 임시 테이블</p>
				</div>
				<div class="content table-responsive table-full-width">
					<table class="table table-hover table-striped">
						<thead>
							<th style="width: calc(10%);">공지 번호</th>
							<th style="width: calc(60%);">공지 내용</th>
							<th style="width: calc(15%);">공지 날짜</th>
						</thead>
						<tbody>
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


			<div class="card">
				<div class="header">
					<h4 class="title">회 계 내 역</h4>
					<p class="category">Here is a subtitle for this table</p>
				</div>
				<br>
                <ul class="list-group">
              	  <c:forEach items="${accountList}" var="dto">
                    <li><a href="#" onclick="list('${dto.transactionNo}');" class="list-group-item">${dto.listName}</a></li>
                  </c:forEach>
                </ul>
                <div id="accountList"></div>
			</div>

		</div>
	</div>
</div>
<!-- End : Board List -->