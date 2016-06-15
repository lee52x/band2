<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>


<!-- Start : header Bar -->
    <nav class="navbar navbar-default navbar-fixed">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation-example-2">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Table List</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-left">
                        <li>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-dashboard"></i>
                            </a>
                        </li>
                        <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="fa fa-globe"></i>
                                    <b class="caret"></b>
                                    <span class="notification">5</span>
                              </a>
                              <ul class="dropdown-menu">
                                <li><a href="#">Notification 1</a></li>
                                <li><a href="#">Notification 2</a></li>
                                <li><a href="#">Notification 3</a></li>
                                <li><a href="#">Notification 4</a></li>
                                <li><a href="#">Another notification</a></li>
                              </ul>
                        </li>
                        <li>
                           <a href="">
                                <i class="fa fa-search"></i>
                            </a>
                        </li>
                    </ul>

                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    가입밴드
                                    <b class="caret"></b>
                              </a>
                             <c:forEach var="dto" items="${list}">  
                              <ul class="dropdown-menu">
                                <li><a href="">${url}</a></li>
                                <li><a href="#">${url}</a></li>
                                <li><a href="#">${url}</a></li>
                                <li><a href="#">${url}</a></li>
                                <li><a href="#">${url}</a></li>
                                <li class="divider"></li>
                                <li><a href="#">${url}</a></li>
                              </ul>
                              </c:forEach>
                        </li>
                        
                        
                        
                        <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: blue">
                                 ${sessionScope.main.userId}님
                                    <b class="caret"></b>
                              </a>
                              <ul class="dropdown-menu">
                                <li><a href="<%=cp%>/comfirmMember/pwd/${url}">정보수정</a></li>
                              
                                <li class="divider"></li>
                                <li><a href="<%=cp%>/group/${url}">로그아웃</a></li>
                               <c:if test="${sessionScope.main.grade==1||sessionScope.main.grade==2}">
                                 <li class="divider"></li>
                                <li><a href="<%=cp%>/account/main/${url}">관리자페이지</a></li>
                                </c:if>
                              </ul>
                        </li>
                      
                    </ul>
                </div>
            </div>
        </nav>
        <!-- End : header Bar -->
        