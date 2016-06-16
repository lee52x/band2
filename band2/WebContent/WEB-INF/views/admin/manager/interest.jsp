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

 
<div class="col-md-7 col-sm-12 col-xs-12 col-md-offset-2">
            <div class="x_panel">
            	<div class="x_title">
                    <h2><i class="fa fa-heart"></i>
                    <small style="font-weight: bold;">우리 그룹 관심사</small></h2>
                    <div class="clearfix"></div>
                </div>
<div class="row">
	<div class="x_content">
		<small style="color: grey;">※커뮤니티 게시글들의 해쉬태그를 분석한 결과입니다.</small>
		<br><br>
		<hr>
		
		<table class="table table-striped jambo_table bulk_action">
			<thead>
				<tr>
					<th>관심 순위</th>
					<th>키워드</th>
					<th>해쉬 개수</th>
					<th>관심도</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="dto" items="${list}">
				<tr>
					<th scope="row">${dto.listNum}위 
					<c:if test="${dto.listNum==1}">
					<i class="fa fa-trophy" style="color:gold;"></i>
					</c:if>
					<c:if test="${dto.listNum==2}">
					<i class="fa fa-trophy" style="color:silver;"></i>
					</c:if>
					<c:if test="${dto.listNum==3}">
					<i class="fa fa-trophy" style="color:brown;"></i>
					</c:if></th>
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
        	<div style=" width: 100%; text-align: center;">
        		<form name="searchForm" method="post" class="form-inline">
						  <input type="date" class="form-control input-sm input-search" name="searchValue">~
						  <input type="date" class="form-control input-sm input-search" name="searchValue2">
						  <button type="button" class="btn btn-info btn-sm btn-search" onclick="searchInterest();"><span class="glyphicon glyphicon-search"></span> 검색</button>
        		</form>
        	</div>
       	</div>
	</div>
</div>
</div>
</div>
<!-- bootstrap-progressbar -->
<script src="<%=cp%>/res/js/admin/bootstrap-progressbar/bootstrap-progressbar.js"></script>