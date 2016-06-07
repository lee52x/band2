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
<body>
<div class="wrapper">

	<!-- Start : nav Bar -->
	<div class="sidebar" data-color="blue" data-image="<%=cp%>/res/img/sidebar-5.jpg">
  	  <!--   you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple" -->
    
    	<div class="sidebar-wrapper">
            <div class="logo">
                <a href="<%=cp %>/community_main.jsp" class="simple-text">
                    Creative Tim
                </a>
            </div>

            <ul class="nav">
                <li>
                    <a href="#">
                        <i class="pe-7s-graph"></i>
                        <p>Dashboard</p>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="pe-7s-user"></i>
                        <p>User Profile</p>
                    </a>
                </li>
                <li class="active">
                    <a href="#">
                        <i class="pe-7s-note2"></i>
                        <p>Table List</p>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="pe-7s-news-paper"></i>
                        <p>Typography</p>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="pe-7s-science"></i>
                        <p>Icons</p>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="pe-7s-map-marker"></i>
                        <p>Maps</p>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="pe-7s-bell"></i>
                        <p>Notifications</p>
                    </a>
                </li>
				<li class="active-pro">
                    <a href="#">
                        <i class="pe-7s-rocket"></i>
                        <p>Upgrade to PRO</p>
                    </a>
                </li>
            </ul>
    	</div>
    </div>
    <!-- End : nav Bar -->
    
    
    <!-- Start : Main Region -->
    <div class="main-panel">
    
    <!-- Start : SlideShow -->
	<div id="carousel-example-generic" class="carousel slide carousel-fade" data-ride="carousel">
               <!-- Indicators -->
               <ol class="carousel-indicators">
                  <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                  <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                  <li data-target="#carousel-example-generic" data-slide-to="2"></li>
               </ol>
               <!-- Wrapper for slides -->
               <div class="carousel-inner" role="listbox">
                  <div class="item active">
                     <div class="carousel-caption">
                        <h3>First slide label</h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                     </div>
                  </div>
                  <div class="item">
                     <div class="carousel-caption">
                        <h3>First slide label</h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                     </div>
                  </div>
                  <div class="item">
                     <div class="carousel-caption">
                        <h3>First slide label</h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                     </div>
                  </div>
               </div>
               <!-- Controls -->
               <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
               <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
               <span class="sr-only">Previous</span>
               </a>
               <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
               <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
               <span class="sr-only">Next</span>
               </a>
    </div>
    <!-- End : SlideShow -->
    
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
                        <li>
                           <a href="">
                               Account
                            </a>
                        </li>
                        <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    Dropdown
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
                        <li>
                            <a href="#">
                                Log out
                            </a>
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
                                <h4 class="title">Our Group Bulletin Board</h4>
                                <p class="category">Here is a subtitle for this table</p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                        <th style="width:calc(10%);">Num</th>
                                    	<th style="width:calc(60%);">Subject</th>
                                    	<th style="width:calc(15%);">Date</th>
                                    	<th style="width:calc(10%);">Count</th>
                                    	<th style="width:calc(5%);">File</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                        	<td>1</td>
                                        	<td><a href="#">Subject 1</a></td>
                                        	<td>2016-05-10</td>
                                        	<td>0</td>
                                        	<td><a href="#"></a></td>
                                        </tr>
                                        <tr>
                                        	<td>2</td>
                                        	<td><a href="#">Subject 2</a></td>
                                        	<td>2016-05-10</td>
                                        	<td>10</td>
                                        	<td><a href="#"></a></td>
                                        </tr>
                                        <tr>
                                        	<td>3</td>
                                        	<td><a href="#">Subject 3</a></td>
                                        	<td>2016-05-10</td>
                                        	<td>16</td>
                                        	<td><a href="#"></a></td>
                                        </tr>
                                        <tr>
                                        	<td>4</td>
                                        	<td><a href="#">Subject 4</a></td>
                                        	<td>2016-05-10</td>
                                        	<td>12</td>
                                        	<td><a href="#"></a></td>
                                        </tr>
                                        <tr>
                                        	<td>5</td>
                                        	<td><a href="#">Subject 5</a></td>
                                        	<td>2016-05-10</td>
                                        	<td>10</td>
                                        	<td><a href="#"><img style="width:14px; height:14px;" src="<%=cp%>/res/img/community/disk.png"></a></td>
                                        </tr>
                                        <tr>
                                        	<td>6</td>
                                        	<td><a href="#">Subject 6</a></td>
                                        	<td>2016-05-10</td>
                                        	<td>72</td>
                                        	<td><a href="#"></a></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
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