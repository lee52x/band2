<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<style>

</style>
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="<%=cp%>/account/main/${url}" class="site_title" style="text-align: center;padding-left: 0px;"><span style="font-weight: bold;">${sessionScope.main.groupName}</span></a>
            </div>

            <div class="clearfix"></div>
            <a class="navbar-brand" href="<%=cp%>/" style="padding-left: 58px;"> 
			<img class="img-responsive" src="<%=cp%>/res/img/logo/nuridalogo_y.png"
				 alt="logo" width="60%" height="60%">
			</a>

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
                  <li><a><i class="fa fa-group"></i> 그룹관리 <span class="fa fa-chevron-down"></span></a>
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
