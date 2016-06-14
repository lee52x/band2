<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link href="<%=cp%>/res/css/communityManager/prettify.min.css" rel="stylesheet">
<link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">
<link href="<%=cp%>/res/css/admin/bootstrap-progressbar-3.3.4.css" rel="stylesheet">


<script type="text/javascript">
function searchInterest() {
		var f=document.searchForm;
		
		f.action="<%=cp%>/manager/interest/${url}";
		f.submit();
}

</script>

 

<div class="row">
	<div class="x_content">
		<table class="table">
			<thead>
				<tr>
					<th>관심 순위</th>
					<th>해쉬 이름</th>
					<th>해쉬 개수</th>
					<th>비율</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="dto" items="${list}">
				<tr>
					<th scope="row">${dto.listNum}</th>
					<td>${dto.hashName}</td>
					<td>${dto.hashCount}</td>
					<td class="">
					<p style="float:right; margin-bottom:0">${dto.hashRatio}%</p>
					<div class="progress progress_sm" style="width: 76%;">
                    	<div class="progress-bar bg-green" role="progressbar" data-transitiongoal="${dto.hashRatio}"></div>
                    </div>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
		<div class="paging" style="text-align: center; min-height: 50px; line-height: 50px;">
            <c:if test="${dataCount==0 }">
                 	등록된 게시물이 없습니다.
            </c:if>
            <c:if test="${dataCount!=0 }">
                ${paging}
            </c:if>
        </div>   
        <div style="clear: both;">
        	<div style=" width: 60%; text-align: center;">
        		<form name="searchForm" method="post" class="form-inline">
						  <select class="form-control input-sm" name="searchKey">
						      <option value="hashDate">날짜</option>
						  </select>
						  <input type="date" class="form-control input-sm input-search" name="searchValue">~
						  <input type="date" class="form-control input-sm input-search" name="searchValue2">
						  <button type="button" class="btn btn-info btn-sm btn-search" onclick="searchInterest();"><span class="glyphicon glyphicon-search"></span> 검색</button>
        		</form>
        	</div>
       	</div>
	</div>
</div>

<!-- bootstrap-progressbar -->
<script src="<%=cp%>/res/js/admin/bootstrap-progressbar/bootstrap-progressbar.js"></script>