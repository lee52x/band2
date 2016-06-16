<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

	<!-- Start : nav Bar -->
	<div class="sidebar" data-color="azure" >
  	  <!--   you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple" -->
    
    	<div class="sidebar-wrapper">
            <div class="logo">
                <a href="<%=cp %>/community/main/${url}" class="simple-text">
                ${sessionScope.main.groupName}
                </a>
            </div>

            <ul class="nav">
            	<li>
                    <a href="<%=cp %>/community/main/${url}">
                        <p>커뮤니티 홈</p>
                    </a>
                </li>
            
            
            	<c:forEach items="${navList}" var="nv">
            	<li>
            		<c:if test="${nv.boCateType=='자유'}">
	            	 	<a href="<%=cp%>/freeBoard/list/${nv.boCateNum}/${url}">
	                       	<p>${nv.boCateName}</p>
	                   	</a>
                    </c:if>
                    	
                    <c:if test="${nv.boCateType=='사진'}">
	            	 	<a href="<%=cp%>/photoBoard/list/${nv.boCateNum}/${url}">
	                       	<p>${nv.boCateName}</p>
	                   	</a>
                    </c:if>
                    	
                    <c:if test="${nv.boCateType=='방명록'}">
	            		 <a href="<%=cp%>/guestBoard/list/${nv.boCateNum}/${url}">
	                       	<p>${nv.boCateName}</p>
	                    </a>
                    </c:if>
               	</li>
            	</c:forEach>
                
                <li>
                    <a href="<%=cp%>/community/chat/${url}">
                    	<p>채팅</p>
                    </a>
                </li>
            </ul>
    	</div>
    </div>
    <!-- End : nav Bar -->