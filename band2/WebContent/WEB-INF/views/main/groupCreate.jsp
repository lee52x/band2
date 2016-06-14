<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
   String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<title>메인페이지</title>

  <link href="<%=cp%>/res/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%=cp%>/res/css/animate.min.css" rel="stylesheet"> 
  <link href="<%=cp%>/res/css/font-awesome.min.css" rel="stylesheet">
  <link href="<%=cp%>/res/css/lightbox.css" rel="stylesheet">
  <link href="<%=cp%>/res/css/main.css" rel="stylesheet">
  <link href="<%=cp%>/res/css/presets/preset1.css" rel="stylesheet" id="css-preset"> <!-- 네비게이션 -->
  <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700' rel='stylesheet' type='text/css'>
  <link href="<%=cp%>/res/img/favicon.ico" rel="shortcut icon" >
  <link href="<%=cp%>/res/css/gsdk-base.css" rel="stylesheet" />
 
  <script type="text/javascript">
  </script>
</head>
<body>

  <!--.preloader-->
  <div class="preloader"> <i class="fa fa-circle-o-notch fa-spin"></i></div>
  <!--/.preloader-->

  <header id="home">
    <div id="home-slider" class="carousel slide carousel-fade" data-ride="carousel">
      <div class="carousel-inner">
        <div class="item active" style="background-image: url(<%=cp%>/res/img/slider/1.jpg)">
          <div class="caption">
            <h1 class="animated fadeInLeftBig">이제 <span>NURIDA</span> 서비스를 이용해보세요!</h1>
            <p class="animated fadeInRightBig">그룹 주소 ( http://localhost:9090/nurida/group/${url} )</p>
            <a data-scroll class="btn btn-start animated fadeInUpBig" href="http://localhost:9090/nurida/group/${url}">생성한 사이트로 이동하기</a>
            <a data-scroll class="btn btn-start animated fadeInUpBig" href="http://localhost:9090/nurida/">누리다 홈으로 가기</a>
          </div>
        </div>
     </div>
    </div>
  </header>


  <script type="text/javascript" src="<%=cp%>/res/js/jquery-1.10.2.js"></script>
  <script type="text/javascript" src="<%=cp%>/res/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="<%=cp%>/res/js/wow.min.js"></script>
  <script type="text/javascript" src="<%=cp%>/res/js/mousescroll.js"></script>
  <script type="text/javascript" src="<%=cp%>/res/js/smoothscroll.js"></script>
  <script type="text/javascript" src="<%=cp%>/res/js/main.js"></script>
  
  <!-- 회원가입모달 -->
  <script src="<%=cp%>/res/js/jquery.bootstrap.wizard.js" type="text/javascript"></script>
  <script src="<%=cp%>/res/js/jquery.validate.min.js"></script>
  <script src="<%=cp%>/res/js/wizard.js"></script>
  <!-- /회원가입모달 -->
 
</body>
</html>