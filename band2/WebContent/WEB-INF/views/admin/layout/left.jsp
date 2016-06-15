<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="index.html" class="site_title"><i class="fa fa-paw"></i> <span>Gentellela Alela!</span></a>
            </div>

            <div class="clearfix"></div>
            
            <!-- menu profile quick info -->
            <div class="profile">
              <div class="profile_pic">
                <img src="<%=cp%>/res/img/img.jpg" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>어서오세요,</span>
                <h2>${sessionScope.main.userName}님</h2>
              </div>
            </div>
            <!-- /menu profile quick info -->

            <br />

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <h3>&nbsp;</h3>
                <ul class="nav side-menu">
                  <li><a><i class="fa fa-home"></i> Home <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="<%=cp %>/community/main/${url}">커뮤니티 바로가기</a>
                      </li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-edit"></i> 회계관리 <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="<%=cp%>/account/main/${url}">입출금 관리</a></li>
                      <li><a href="<%=cp%>/account/state/${url}">회계현황 조회</a></li>
                      <li><a href="<%=cp%>/account/fee/${url}">회비 관리</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-desktop"></i> 그룹관리 <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="<%=cp%>/member/member/${url}">회원 관리</a></li>
                      <li><a href="<%=cp%>/member/stats/${url}">그룹현황 조회</a></li>
                      <li><a href="<%=cp%>/member/proceedList/${url}">그룹 회의록</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-table"></i> 일정관리 <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="<%=cp%>/event/list/${url}">리스트 조회 및 등록</a></li>
                      <li><a href="<%=cp%>/event/sch/${url}">캘린더 조회 및 등록</a></li>
                      <li><a href="<%=cp%>/event/place/${url}">추천 모임 장소</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-bar-chart-o"></i> 커뮤니티 관리 <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="<%=cp%>/manager/picture/${url}">그룹 사진 등록</a></li>
                      <li><a href="<%=cp%>/manager/insertBoard/${url}">게시판 추가</a></li>
                      <li><a href="<%=cp%>/manager/notice/notice/${url}">공지사항 업로드</a></li>
                      <li><a href="<%=cp%>/manager/update/${url}">그룹 정보 수정</a></li>
                      <li><a href="<%=cp%>/manager/interest/${url}">우리 그룹 관심사 </a></li>
                    </ul>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
		<!-- /sidebar menu -->                
