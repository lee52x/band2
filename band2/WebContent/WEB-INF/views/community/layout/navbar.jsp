<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

	<!-- Start : nav Bar -->
	<div class="sidebar" data-color="blue" data-image="<%=cp%>/res/img/community/sidebar-5.jpg">
  	  <!--   you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple" -->
    
    	<div class="sidebar-wrapper">
            <div class="logo">
                <a href="<%=cp %>/community/main/${url}" class="simple-text">
                
                    그룹 이름
                </a>
            </div>

            <ul class="nav">
                <li>
                    <a href="<%=cp %>/community/main/${url}">
                        <i class="pe-7s-graph"></i>
                        <p>커뮤니티 홈</p>
                    </a>
                </li>
                <li>
                    <a href="<%=cp%>/freeBoard/list/${url}">
                        <i class="pe-7s-user"></i>
                        <p>자유게시판</p>
                    </a>
                </li>
                <li>
                    <a href="<%=cp%>/photoBoard/list/${url}">
                        <i class="pe-7s-note2"></i>
                        <p>포토게시판</p>
                    </a>
                </li>
               <li>
                    <a href="<%=cp%>/guestBoard/list/${url}">
                        <i class="pe-7s-news-paper"></i>
                        <p>방명록</p>
                    </a>
                </li>
                <li>
                    <a href="<%=cp%>/community/chat/${url}">
                        <i class="pe-7s-bell"></i>
                        <p>채팅</p>
                    </a>
       
            </ul>
    	</div>
    </div>
    <!-- End : nav Bar -->