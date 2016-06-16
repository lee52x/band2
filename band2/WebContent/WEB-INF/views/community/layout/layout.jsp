<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%
   String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community Main Sample</title>
    
    <!-- Bootstrap core CSS     -->
    <link href="<%=cp%>/res/css/community/bootstrap.css" rel="stylesheet" />
    <!-- Animation library for notifications-->
     	<!-- ★Header의 notifications이라는 메뉴 안쓸거면 빼도 됨-->
    <link href="<%=cp%>/res/css/community/animate.css" rel="stylesheet"/>
    <!--  Light Bootstrap Table core CSS    -->
    <link href="<%=cp%>/res/css/community/light-bootstrap-dashboard2.css" rel="stylesheet"/>
    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="<%=cp%>/res/css/community/demo.css" rel="stylesheet" />

    <!--     Fonts and icons     -->
    <link href="<%=cp%>/res/css/community/pe-icon-7-stroke.css" rel="stylesheet" />
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    
     <!-- 슬라이드 쇼 CSS ★by성표-->
    <link href="<%=cp%>/res/css/community/slideshow.css" rel="stylesheet" />
    
    <!-- Jquery -->
    <script src="<%=cp%>/res/js/community/jquery-1.10.2.js" type="text/javascript"></script>
    
</head>
<body>
<div class="wrapper">
	<div>
		<tiles:insertAttribute name="navbar" />
	</div>
    
    
    <!-- Start : Main Region -->
    <div class="main-panel">
    
	    <div>
	    	<tiles:insertAttribute name="slideshow" />
	    </div>
	    
	    <div>
	    	<tiles:insertAttribute name="header" />
	    </div>
	    
	    <div class="content">
		    <div>
		    	<tiles:insertAttribute name="body" />
		    </div>
	    </div>
        
    </div>
    <!-- End : Main Region -->
</div>

</body>



    <!--   Core JS Files   -->
	<script src="<%=cp%>/res/js/community/bootstrap.min.js"></script>
	
	<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
	<!-- 사이드 메뉴바에 사진 배경 보이게 하는 역할...?! -->
	<script src="<%=cp%>/res/js/community/light-bootstrap-dashboard.js"></script>
	
	<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->
	<script src="<%=cp%>/res/js/community/demo.js"></script>
</html>