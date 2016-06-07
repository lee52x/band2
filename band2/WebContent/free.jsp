<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>커뮤니티 MAIN TEST1</title>
    
    <!-- Bootstrap core CSS     -->
    <link href="<%=cp%>/res/css/community/bootstrap.css" rel="stylesheet" />
    <!-- Animation library for notifications   -->
     	<!-- ★★notifications이라는 메뉴 안쓸거면 빼도 됨-->
    <link href="<%=cp%>/res/css/community/animate.css" rel="stylesheet"/>
    <!--  Light Bootstrap Table core CSS    -->
    <link href="<%=cp%>/res/css/community/light-bootstrap-dashboard2.css" rel="stylesheet"/>
    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="<%=cp%>/res/css/community/demo.css" rel="stylesheet" />

    <!--     Fonts and icons     -->
    <link href="<%=cp%>/res/css/community/pe-icon-7-stroke.css" rel="stylesheet" />
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    
     <!-- 슬라이드 쇼 CSS by. 성표-->
    <link href="<%=cp%>/res/css/community/slideshow.css" rel="stylesheet" />
    
    <script src="<%=cp%>/res/js/community/jquery-1.10.2.js" type="text/javascript"></script>
    
</head>

<style type="text/css">
.selectField {
	border:1px solid #999;
	padding:3px 6px;
	border-radius:4px;
	font-family: 나눔고딕, 맑은 고딕, 돋움, sans-serif;
	font-size: 9pt;
}
.boxTF {
	border:1px solid #999;
	padding:4px 6px;
	border-radius:4px;
	background-color:#ffffff;
	font-family: 나눔고딕, 맑은 고딕, 돋움, sans-serif;
	font-size: 9pt;
}

.btn {
	 font-size: 12px;
	 color:#333;
 	 font-weight:500;
	 font-family: 나눔고딕, 맑은 고딕, 돋움, sans-serif;
	 border:1px solid #ccc;
	 background-color:#FFF;
	 vertical-align:middle;
	 text-align:text-align;
	 cursor:cursor;
	 padding:4px 8px;
	 border-radius:4px;
	 margin-bottom: 3px;
}
</style>
<body>
<div class="wrapper">

	<!-- Start : nav Bar -->
	<div class="sidebar" data-color="blue" data-image="<%=cp%>/res/img/sidebar-5.jpg">
  	  <!--   you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple" -->
    
    	<div class="sidebar-wrapper">
            <div class="logo">
                <a href="<%=cp %>/community_main.jsp" class="simple-text">
                   			커뮤니티
                </a>
            </div>

            <ul class="nav">
                <li>
                    <a href="#">
                        <i class="pe-7s-graph"></i>
                        <p>그룹정보</p>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="pe-7s-user"></i>
                        <p>자유게시판</p>
                    </a>
                </li>
                <li class="active">
                    <a href="#">
                        <i class="pe-7s-note2"></i>
                        <p>포토게시판</p>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="pe-7s-news-paper"></i>
                        <p>방명록</p>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="pe-7s-science"></i>
                        <p>질문사항</p>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="pe-7s-map-marker"></i>
                        <p>쪽지</p>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="pe-7s-bell"></i>
                        <p>채팅</p>
                    </a>
                </li>
				
            </ul>
    	</div>
    </div>
    <!-- End : nav Bar -->
    
    
    <!-- Start : Main Region -->
    <div class="main-panel">
    

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
                              <ul class="dropdown-menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something</a></li>
                                <li class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                              </ul>
                        </li>
                        
                        
                        
                        <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    홍길동님
                                    <b class="caret"></b>
                              </a>
                              <ul class="dropdown-menu">
                                <li><a href="#">내정보</a></li>
                              
                                <li class="divider"></li>
                                <li><a href="#">로그아웃</a></li>
                              </ul>
                        </li>
                      
                    </ul>
                </div>
            </div>
        </nav>
        <!-- End : header Bar -->
        
        
        
        
        <!-- Start : Board List -->
        <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">질문사항</h4>
                                <p class="category">회원들간 자유롭게 질문과 답변을 남기세요!</p>
                            </div>
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
                                 
                                        <tr>
                                        	<td>1</td>
                                        	<td><a href="#">Subject 1</a></td>
                                        	<td>홍길동</td>
                                        	<td>2016-05-10</td>
                                        	<td align="center">0</td>
                                        	<td><a href="#"></a></td>
                                        </tr>
                                        <tr>
                                        	<td>2</td>
                                        	<td><a href="#">Subject 2</a></td>
                                        	<td>홍길동</td>
                                        	<td>2016-05-10</td>
                                        	<td align="center">0</td>
                                        	<td><a href="#"></a></td>
                                        </tr>
                                        <tr>
                                        	<td>3</td>
                                        	<td><a href="#">Subject 3</a></td>
                                        	<td>홍길동</td>
                                        	<td>2016-05-10</td>
                                        	<td align="center">0</td>
                                        	<td><a href="#"></a></td>
                                        </tr>
                                        <tr>
                                        	<td>4</td>
                                        	<td><a href="#">Subject 4</a></td>
                                        	<td>홍길동</td>
                                        	<td>2016-05-10</td>
                                        	<td align="center">0</td>
                                        	<td><a href="#"></a></td>
                                        </tr>
                                        
                                         <tr>
                                        	<td>4</td>
                                        	<td><a href="#">Subject 4</a></td>
                                        	<td>홍길동</td>
                                        	<td>2016-05-10</td>
                                        	<td align="center">0</td>
                                        	<td><a href="#"></a></td>
                                        </tr>
                                       
                              
                                        
                                    </tbody>
                                </table>
  
                            </div>
                        </div>
                    </div>
                </div>
    
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
          <input type="button" value=" 글올리기 " class="btn" onclick="javascript:location.href='<%=cp%>/bbs/created.do';">
      </td>
   </tr>
</table>

            </div>
            
        </div>
        
        <!-- End : Board List -->


        </div>
        <!-- End : Main Region -->
</div>



</body>



    <!--   Core JS Files   -->
	<script src="<%=cp%>/res/js/community/bootstrap.min.js" type="text/javascript"></script>
	
	<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
	<!-- 사이드 메뉴바에 사진 배경 보이게 하는 역할...?! -->
	<script src="<%=cp%>/res/js/community/light-bootstrap-dashboard.js"></script>
	
	<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->
	<script src="<%=cp%>/res/js/community/demo.js"></script>
</html>