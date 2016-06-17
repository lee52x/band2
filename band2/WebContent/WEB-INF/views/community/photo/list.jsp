<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.imgLayout{
	width: 220px;
	height: 260px;
	padding: 5px 5px 5px;
	margin: 15px 25px;
	/* border: 1px solid #DAD9FF; */
	float: left;
}

.subject {
     width:220px;
     height:25px;
     line-height:25px;
     margin:5px auto 0px;
     /* border-top: 1px solid #DAD9FF; */
     display: inline-block;
     white-space:nowrap;
     overflow:hidden;
     text-overflow:ellipsis;
     cursor: pointer;
     text-align: center;
}



/* 전체 테두리 세로 길이만 지정*/
.card .header {
   height: 930px;
}

.btn{
	border:none; 
	color:#000; 
	background-color: #fbdf80;"
}
</style>

<script type="text/javascript">
function searchList() {
		var f=document.searchForm;
		f.action="<%=cp%>/photoBoard/list/${boCateNum}/${url}";
		f.submit();
}


function article(photoNo) {
	var url="${urlArticle}&photoNo="+photoNo;
	location.href=url;
}
</script>

<div class="card">
	<div class="header">
		<div class="bodyFrame2">
		<br><br>
		    <div class="body-title">
		          <h4 class="title" style="text-align:center; color: #5D5D5D; font-weight: bold;"> ${boardName} </h4>
		    </div>
		    
		    <p class="category" style="text-align:center;">
		         추억의 포토 갤러리를 회원과 공유할 수 있는 공간입니다.
		    </p>
		
		    <div style="max-width:900px; margin: 0px auto;">
		<c:if test="${dataCount!=0 }"> 
		<br>   
		        <div style=" color:grey; clear: both; height: 30px; line-height: 30px;">
		        <p align="right" style="font-size:12px">
		            ${dataCount}개(${page}/${total_page} 페이지)
		        </p>
		        </div>

		        <div style="clear: both;">
		    <c:forEach var="dto" items="${list}" varStatus="status">
		                 <c:if test="${status.index==0}">
		                       <c:out value="<div style='clear: both; max-width:810px; margin: 0px auto;'>" escapeXml="false"/>
		                 </c:if>
		                 <c:if test="${status.index!=0 && status.index%3==0}">
		                        <c:out value="</div><div style='clear: both; max-width:810px; margin: 0px auto;'>" escapeXml="false"/>
		                 </c:if>
					      <div class="imgLayout">
			                     <img  onclick="javascript:article('${dto.photoNo}');" src="<%=cp%>/uploads/photo/${dto.imageFilename}" style="width: 220px; height: 220px; border: 1px solid #bdbdbd;" >
					             <span class="subject" onclick="javascript:article('${dto.photoNo}');" >
					                   ${dto.subject}
					             </span>
					       </div>
		    </c:forEach>
		
		    <c:set var="n" value="${list.size()}"/>
		    <c:if test="${n>0&&n%3!=0}">
				        <c:forEach var="i" begin="${n%3+1}" end="3" step="1">
					             <div class="imgLayout">&nbsp;</div>
				        </c:forEach>
		    </c:if>
			
		    <c:if test="${n!=0 }">
				       <c:out value="</div>" escapeXml="false"/>
		    </c:if>
		        </div>
		</c:if>
		

		        <div class="paging" style="text-align: center; min-height: 50px; line-height: 50px;">
		            <c:if test="${dataCount==0 }">
		            <br><br><br><br><br><br>
		                  등록된 게시물이 없습니다.
		            <br><br><br><br><br><br>
		            </c:if>
		            <c:if test="${dataCount!=0 }">
		                ${paging}
		            </c:if>
		        </div>   
     
		        
		        <div style="clear: both;">
		        		<div style="float: left; width: 20%; min-width: 85px;">
		        		    <button type="button" class="btn btn-default btn-sm wbtn" onclick="javascript:location.href='<%=cp%>/photoBoard/list/${boCateNum}/${url}';">새로고침</button>
		        		</div>
		        		<div style="float: left; width: 60%; text-align: center;">
		        		     <form name="searchForm" method="post" class="form-inline">
								  <select class="form-control input-sm" name="searchKey" style="padding: 3px 12px;">
								      <option value="subject">제목</option>
								      <option value="name">작성자</option>
								      <option value="content">내용</option>
								      <option value="created">등록일</option>
								  </select>
								  <input type="text" class="form-control input-sm input-search" name="searchValue">
								  <button type="button" class="btn btn-info btn-sm btn-search" onclick="searchList();"><span></span> 검색</button>
		        		     </form>
		        		</div>
		        		<div style="float: left; width: 20%; min-width: 85px; text-align: right;">
		        		    <button
		        		     type="button" class="btn btn-primary btn-sm bbtn" onclick="javascript:location.href='<%=cp%>/photoBoard/photoCreated/${boCateNum}/${url}';"><span class="glyphicon glyphicon glyphicon-pencil"></span> 등록하기</button>
		        		</div>
		        </div>
		        
		    </div>
		    
		</div>
	</div>
</div>