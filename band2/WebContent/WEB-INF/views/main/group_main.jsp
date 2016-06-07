<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<link href="<%=cp%>/res/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=cp%>/res/css/animate.min.css" rel="stylesheet">
<link href="<%=cp%>/res/css/font-awesome.min.css" rel="stylesheet">
<link href="<%=cp%>/res/css/main.css" rel="stylesheet">
<link href="<%=cp%>/res/css/presets/preset1.css" rel="stylesheet"
	id="css-preset">
<!-- 네비게이션 -->

<link rel="stylesheet" href="<%=cp%>/res/css/form-elements.css">
<link rel="stylesheet" href="<%=cp%>/res/css/style.css">

<style type="text/css">
.row {
    margin-top:-200px;
}
a{
	font-size: 13px;
}
a:focus,
a:hover{
    font-size: 15px;
}

.col-sm-5 {
    width: 50%;  
}

#home-slider .caption h1 span{
	color:#de615e;
}

</style>

<script type="text/javascript" src="<%=cp%>/res/js/jquery-1.10.2.js"></script>

</head>
<body>

	<header id="home">
		<div id="home-slider" class="carousel slide carousel-fade"
			data-ride="carousel">
			<div class="carousel-inner">
				<div class="item active"
					style="background-image: url(<%=cp%>/res/img/slider/3.jpg)">
					<div class="caption">
						<div class="row">
							<div class="col-sm-5 col-sm-offset-3 form-box">
            					<h1 class="animated fadeInLeftBig">쌍용대학교 <span>개발동아리</span></h1>
            					<p class="animated fadeInRightBig">그룹 소개 그룹 소개 그룹 소개</p>
         					 </div>
							<div class="col-sm-5 col-sm-offset-3 form-box">
								<div class="form-top">
									<div class="form-top-left">
										<h3>Login to our site</h3>
										<p>페이지를 이용하시려면 로그인이 필요합니다.</p>
									</div>
									<div class="form-top-right">
										<i class="fa fa-lock"></i>
									</div>
								</div>
								<div class="form-bottom">
									<form role="form" action="<%=cp%>/group/${url}" method="post" class="login-form">
										<div class="form-group">
											<label class="sr-only" for="form-username">아 이 디</label> <input
												type="text" name="userId" placeholder="아 이 디"
												class="form-username form-control" id="userId">
										</div>
										<div class="form-group">
											<label class="sr-only" for="form-password">패 스 워 드</label> <input
												type="password" name="userPwd"
												placeholder="패 스 워 드" class="form-password form-control"
												id="userPwd">
					  				  </div>
										<button type="submit" class="btn">로 그 인</button>
									</form>
								</div>
								<a href="#">회원 가입</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#">아이디 찾기</a>
							</div>
						</div>



					</div>
				</div>

			</div>

		</div>
		<!--/#home-slider-->
	</header>
	<!--/#home-->
</body>


<script type="text/javascript" src="<%=cp%>/res/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=cp%>/res/js/main.js"></script>


</html>