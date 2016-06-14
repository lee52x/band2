<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
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

 <!-- Start : Board List -->
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                            
                             
                               <h4 class="title" style="color: #5F00FF">${boardName}</h4>
                               
                                <p class="category">회원들간 자유롭게 소통하세요! </p> 
                                <p align="right">${dataCount}개(${page}/${total_page} 페이지)</p>
                          
                            
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                   
                                        <th style="width:calc(15%);">게시글번호</th>
                                    	<th style="width:calc(40%);">제목</th>
                                    	<th style="width:calc(15%);">작성자</th>
                                    	<th style="width:calc(20%);">작성일</th>
                                    	<th style="width:calc(10%);">조회수</th>
                                    	
                                    </thead>
                                    <tbody>
                                   <c:forEach var="dto" items="${list}">
                                        <tr>
                                        	<td>${dto.listNum}</td>
                                        	<td><a href="${urlArticle}&boardNo=${dto.boardNo}">${dto.subject}</a></td>
                                        	<td>${dto.userId}</td>
                                        	<td>${dto.created}</td>
                                        	<td align="center">${dto.hitCount}</td>
                                        	
                                        </tr>
                                      </c:forEach>
                                        
                                    </tbody>
                                </table>
  
                            </div>
                        </div>
                    </div>
                </div>
     		<table style="width: 700px; margin: 0px auto; border-spacing: 0px;">
			   <tr height="35">
				<td align="center">
			        <c:if test="${dataCount==0 }">
			                   등록된 게시물이 없습니다.
			         </c:if>
			        <c:if test="${dataCount!=0 }">
			               ${paging}
			         </c:if>
				</td>
			   </tr>
			</table>
			 <div class="content table-responsive table-full-width">
   <table style="width: 610px; margin: 20px auto 0px; border-spacing: 0px;">
   <tr height="35">
      <td align="left" width="50%">
          <form name="searchForm" action="" method="post">
              <select name="searchKey" class="selectField">
                  <option value="subject">제목</option>
                  <option value="name">작성자</option>
                  <option value="content">내용</option>
                  <option value="created">등록일</option>
            </select>
            <input type="text" name="searchValue" class="boxTF">
            <input type="button" value=" 검 색 " class="btn" onclick="searchList()">
        </form>
      </td>
      <td align="right">
          <input type="button" value=" 글올리기 " class="btn" onclick="javascript:location.href='<%=cp%>/freeBoard/created/${boCateNum}/${url}';">
         
      </td>
         
       
   </tr>
</table>



            </div>
            
        </div>
        </div>
        </div>
        
        
        <!-- End : Board List -->
        
        
        
        
        
        
        
        