<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<script type="text/javascript">
function searchList(){
	var f=document.searchForm;
	f.action="<%=cp%>/freeBoard/list/${boCateNum}/${url}";
		f.submit();

	}
</script>

<style type="text/css">
</style>

<!-- Start : Board List -->
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="header">
						<br><br>
						<div style="text-align: center;">
						<h4 class="title" style="color: #5D5D5D; font-weight: bold;'">${boardName}</h4>
						
						<p class="category">그룹 회원들과 자유롭게 소통하세요!</p>
						</div>
						


						<div class="content table-responsive table-full-width" style="width:95%; padding-left:130px;">
							<small style="color: grey;">${dataCount}개(${page}/${total_page}페이지)</small>
							<table class="table table-hover table-striped">
								<thead style="background-color: #fbdf80;">
									<tr>
										<th style="width: 10%; text-align: center; color:black;">글번호</th>
										<th style="width: 45%; text-align: center; color:black;">제목</th>
										<th style="width: 15%; text-align: center; color:black;">작성자</th>
										<th style="width: 10%; text-align: center; color:black;">작성일</th>
										<th style="width: 5%; text-align: center; color:black;">Hit</th>
									</tr>
								</thead>
								<tbody style="text-align: center;">
									<c:forEach var="dto" items="${list}">
										<tr>
											<td>${dto.listNum}</td>
											<td style="text-align: left;">
											<a href="${urlArticle}&boardNo=${dto.boardNo}"
											   style="color:#334e7e;">${dto.subject}&nbsp;
											   <c:if test="${dto.replyCount>0}">
											   <span style="color:black;">[${dto.replyCount}]</span>
											   </c:if></a></td>
											  
											<td>
											<c:choose>
								 				<c:when test="${dto.grade == 1}"><div class="btn btn-danger btn-xs" style="margin:0;padding:0 2px;font-size:11px;">그룹장</div></c:when>
								 				<c:when test="${dto.grade == 2}"><div class="btn btn-warning btn-xs" style="margin:0;padding:0 2px;font-size:11px;">운영진</div></c:when>
								 				<c:when test="${dto.grade == 3}"><div class="btn btn-info btn-xs" style="margin:0;padding:0 2px;font-size:11px;">일　반</div></c:when>
								 				<c:when test="${dto.grade == 4}"><div class="btn btn-success btn-xs" style="margin:0;padding:0 2px;font-size:11px;">O　&nbsp;&nbsp;B</div></c:when>
							    			</c:choose>
											&nbsp;${dto.name}</td>
											<td>${dto.created}</td>
											<td align="center">${dto.hitCount}</td>

										</tr>
									</c:forEach>
								</tbody>
							</table>
							<input type="button" value=" 글쓰기 " class="btn btn-default btn-sm" 
							    style="background-color: #fbdf80; border:0; color:black; float:right;"
								onclick="javascript:location.href='<%=cp%>/freeBoard/created/${boCateNum}/${url}';">

							<table style="margin: 0px auto; border-spacing: 0px;">

								<tr height="35">
									<td align="center"><c:if test="${dataCount==0 }">
				                 					  등록된 게시물이 없습니다.
				         						</c:if> <c:if test="${dataCount!=0 }">
				                 					  ${paging}
				         						</c:if></td>
								</tr>
								<tr height="35">
									<td align="center" width="100%">
										<form name="searchForm" action="" method="post">
											<select name="searchKey" class="selectField" style="height: 26px;">
												<option value="subject">제목</option>
												<option value="name">작성자</option>
												<option value="content">내용</option>
												<option value="created">등록일</option>
											</select> 
											<input type="text" name="searchValue" class="boxTF">&nbsp;
											<input type="button" value=" 검 색 " class="btn btn-default btn-sm"
											style="background-color: #fbdf80; border:0; color:black; float:right;"
												onclick="searchList()">
										</form>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>


		</div>
	</div>
</div>


<!-- End : Board List -->







