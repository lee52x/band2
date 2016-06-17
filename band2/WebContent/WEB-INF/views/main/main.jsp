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
 
  <script type="text/javascript" src="<%=cp%>/res/js/util.js"></script>
  <script type="text/javascript">
  function check() {
      var f = document.groupForm;
      f.action="<%=cp%>/group/create";
      
	  	if(confirm("그룹을 생성하시겠습니까?")) {
	  		 return true;
	  	}
	  }
  
  
  function groupUrlCheck(){
	  var groupUrl=$("#groupUrl").val();
	  if(!/^[a-z][a-z0-9_]{4,9}$/i.test(groupUrl)) { 
		  var str= "<span style='color:red;'>5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</span>";
  		  $("#groupUrl").focus();
		  $("#groupUrl + .help-block").html(str);
		  return false;
		}
	  
	  var str= "<span style='color:#028fcc; font-weight: bold; '>사용 가능합니다.</span>";
	  $("#groupUrl + .help-block").html(str);
	  
	  
	  <%-- // 그룹URL 중복 검사 하기
	  var url="<%=cp%>/member/groupUrlCheck";
	  var params = "groupUrl"+groupUrl;
	  $.ajax({
			type:"POST"
			,url:url
			,data:params
			,dataType:"JSON"
			,success:function(data) {
				var passed=data.passed;
				if(passed=="true") {
					var str="<span style='color:blue;font-weight: bold;'>"+groupUrl+"</span> 아이디는 사용가능 합니다.";
					$("#groupUrl + .help-block").html(str);
				} else {
					var str="<span style='color:red;font-weight: bold;'>"+groupUrl+"</span> 아이디는 사용할수 없습니다.";
					$("#groupUrl + .help-block").html(str);
					$("#groupUrl").val("");
					$("#groupUrl").focus();
				}
			}
		}); --%>
  }
  
  
  function userIdCheck(){
	  var userId=$("#userId").val();
	  if(!/^[a-z][a-z0-9_]{4,9}$/i.test(userId)) { 
		  var str= "<span style='color:red;font-weight: bold;'>5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</span>";
  		  $("#userId").focus();
		  $("#userId + .help-block").html(str);
		  return false;
		}
	  
	  var str= "<span style='color:#028fcc; font-weight: bold; '>사용 가능합니다.</span>";
	  $("#userId + .help-block").html(str);
	  
	  
	<%--   // 그룹장 아이디 중복 검사 하기
	  var url="<%=cp%>/member/userIdCheck";
		var params = "userId" + userId;
		$.ajax({
			type : "POST",
			url : url,
			data : params,
			dataType : "JSON",
			success : function(data) {
				var passed = data.passed;
				if (passed == "true") {
					var str = "<span style='color:blue;font-weight: bold;'>"
							+ userId + "</span> 아이디는 사용가능 합니다.";
					$("#userId + .help-block").html(str);
				} else {
					var str = "<span style='color:red;font-weight: bold;'>"
							+ userId + "</span> 아이디는 사용할수 없습니다.";
					$("#userId + .help-block").html(str);
					$("#userId").val("");
					$("#userId").focus();
				}
			}
		}); --%>
	}

	function check01() {
		var f=document.groupForm;
		var str;
		var msg;
		
		str=f.groupName.value;
		if(str==""){
			msg="필수 항목 입니다.";
			$("#groupName + .help-block").html("<span style='color:red;font-weight: bold;'>" +msg+ "</span>");
		} else{
			msg="";
			$("#groupName + .help-block").html("<span style='color:red;font-weight: bold;'>" +msg+ "</span>");
		}
	}
		
		function check02(){
			var f=document.groupForm;
			var str;
			var msg;
			
			str=f.introduce.value;
			if(str==""){
				msg="필수 항목 입니다.";
				$("#introduce + .help-block").html("<span style='color:red;font-weight: bold;'>" +msg+ "</span>");
			} else{
				msg="";
				$("#introduce + .help-block").html("<span style='color:red;font-weight: bold;'>" +msg+ "</span>");
			}
		}
		
		
		function check03(){
			var f=document.groupForm;
			var str;
			var msg;

			str=f.foundationDay.value;
			if(!isValidDateFormat(str)){
				msg="날짜 형식이 맞지 않습니다.";
				$("#foundationDay + .help-block").html("<span style='color:red;font-weight: bold;'>" +msg+ "</span>");
			} else{
				msg="";
				$("#foundationDay + .help-block").html("<span style='color:red;font-weight: bold;'>" +msg+ "</span>");
			}
		}
		
		function check04(){
			var f=document.groupForm;
			var str;
			var msg;
			
			str=f.accountNumber.value;
			if(!isValidNumber(str)){
				msg="계좌번호는 숫자만 입력 가능합니다.";
			} else{
				msg="";
			}
				$("#accountNumber + .help-block").html("<span style='color:red;font-weight: bold;'>" +msg+ "</span>");
		}
		
		function check05(){
			var f=document.groupForm;
			var str;
			var msg;
			
			str=f.bankName.value;
			if(str==""){
				msg="필수 선택 항목입니다.";
			} else{
				msg="";
			}
				$("#bankName + .help-block").html("<span style='color:red;font-weight: bold;'>" +msg+ "</span>");
		}
		
		
		function check06(){
			var f=document.groupForm;
			var str;
			var msg;
			
			str=f.accountHolder.value;
			if(!isValidKorean(str)){
				msg="예금주명을 올바르게 입력하세요.";
			} else{
				msg="";
			}
				$("#accountHolder + .help-block").html("<span style='color:red;font-weight: bold;'>" +msg+ "</span>");
		}
		
		function check07(){
			var f=document.groupForm;
			var str;
			var msg;
			
			str=f.pwd.value;
			if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)){
				msg="패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.";
			} else{
				msg="";
			}
			$("#pwd + .help-block").html("<span style='color:red;font-weight: bold;'>" +msg+ "</span>");
		}
		
		function check08(){
			var f=document.groupForm;
			var str;
			var msg;
			
			str=f.pwd.value;
			if(f.pwdCheck.value != str) {
				$("#pwdCheck + .help-block").html("패스워드가 일치하지 않습니다.");
				f.pwdCheck.focus();
				return false;
			} else {
				$("#pwdCheck + .help-block").html("패스워드를 일치합니다.");
			}
		}
		
		
		function check09(){
			var f=document.groupForm;
			var str;
			var msg;
			
			str=f.name.value;
			if(!isValidKorean(str)){
				msg="이름을 올바르게 입력하세요.";
			} else{
				msg="";
			}
				$("#name + .help-block").html("<span style='color:red;font-weight: bold;'>" +msg+ "</span>");
		}
		
		function check10(){
			var f=document.groupForm;
			var str;
			var msg;

			str=f.birth.value;
			if(!isValidDateFormat(str)){
				msg="날짜 형식이 맞지 않습니다.";
				$("#birth + .help-block").html("<span style='color:red;font-weight: bold;'>" +msg+ "</span>");
			} else{
				msg="";
				$("#birth + .help-block").html("<span style='color:red;font-weight: bold;'>" +msg+ "</span>");
			}
		}
		
		function check11(){
			var f=document.groupForm;
			var str;
			var msg;
			
			str=f.tel.value;
			if(!isValidPhoneNumber(str)){
				msg="연락처의 형식을 확인해주십시오.";
			} else{
				msg="";
			}
				$("#tel + .help-block").html("<span style='color:red;font-weight: bold;'>" +msg+ "</span>");
		}
		

		 
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
            <h1 class="animated fadeInLeftBig">Welcome to <span>NURIDA</span></h1>
            <p class="animated fadeInRightBig">그룹 관리 서비스로 체계적인 모임 운영을!</p>
            <a data-scroll class="btn btn-start animated fadeInUpBig" data-toggle="modal" data-target="#groupModal">그룹 생성하기</a>
          </div>
        </div>
        <div class="item" style="background-image: url(<%=cp%>/res/img/slider/2.jpg)">
          <div class="caption">
            <h1 class="animated fadeInLeftBig">Say Hello to <span>NURIDA</span></h1>
            <p class="animated fadeInRightBig">우리 그룹만의 커뮤니티를 누려보세요!</p>
            <a data-scroll class="btn btn-start animated fadeInUpBig" data-toggle="modal" data-target="#groupModal">그룹 생성하기</a>
          </div>
        </div>
        <div class="item" style="background-image: url(<%=cp%>/res/img/slider/3.jpg)">
          <div class="caption">
            <h1 class="animated fadeInLeftBig">We are <span>NURIDA</span></h1>
            <p class="animated fadeInRightBig">간단한 가입으로 계정을 생성할 수 있습니다. 지금 바로 그룹을 만들어 보세요!</p>
            <a data-scroll class="btn btn-start animated fadeInUpBig" data-toggle="modal" data-target="#groupModal">그룹 생성하기</a>
          </div>
        </div>
      </div>
      <a class="left-control" href="#home-slider" data-slide="prev"><i class="fa fa-angle-left"></i></a>
      <a class="right-control" href="#home-slider" data-slide="next"><i class="fa fa-angle-right"></i></a>

      <a id="tohash" href="#services"><i class="fa fa-angle-down"></i></a>

    </div><!--/#home-slider-->
    <div class="main-nav">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="<%=cp%>/">
            <img class="img-responsive" src="<%=cp%>/res/img/logo/nuridalogo.png" alt="logo" width="35%" height="35%" style="padding-top:10px;">
          </a>                    
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav navbar-right">                 
            <li class="scroll active"><a href="#home">Home</a></li>
            <li class="scroll"><a href="#services">Service</a></li>                    
            <li class="scroll"><a href="#contact">Contact</a></li>       
          </ul>
        </div>
      </div>
    </div><!--/#main-nav-->
  </header><!--/#home-->
  
  <section id="services">
    <div class="container">
      <div class="heading wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
        <div class="row">
          <div class="text-center col-sm-8 col-sm-offset-2">
            <h2 style="font-weight: bold;">
            <span style="color:#028fcc;">누</span>구나 <span style="color:#028fcc;">리</span>더가 
            	될 수 있<span style="color:#028fcc;">다</span></h2>
            <p>'누리다'는 동호회, 동아리와 같은 모임을 효과적이고 체계적으로 운영할 수 있도록 조직 관리 기능을 추가한 소셜 네트워크 서비스입니다. </p>
          </div>
        </div> 
      </div>
      <div class="text-center our-services">
        <div class="row">
          <div class="col-sm-4 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
            <div class="service-icon">
              <i class="fa fa-cogs"></i>
            </div>
            <div class="service-info">
              <h3>그룹 서비스</h3>
              <p>우리 그룹만의 Private한 사이트를 개설해 <br> 드립니다. 그룹만의 공간에서 효율적인  <br>모임 운영을 시작해보세요!</p>
            </div>
          </div>
          <div class="col-sm-4 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="450ms">
            <div class="service-icon">
              <i class="fa fa-credit-card"></i>
            </div>
            <div class="service-info">
              <h3>회계 관리 서비스</h3>
              <p>그룹 계좌의 입/출금 내역 및 회비를 관리하고 <br>내역을 분석한 결과를 통해 Smart한 회계 관리를 <br>도와드립니다.</p>
            </div>
          </div>
          <div class="col-sm-4 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="550ms">
            <div class="service-icon">
              <i class="fa fa-user"></i>
            </div> 
            <div class="service-info">
              <h3>회원 관리 서비스</h3>
              <p>회원들의 연락망을 한 눈에!<br>효과적인 회원 관리를 통해 우리 그룹을 활성화 <br>시켜보세요.</p>
            </div>
          </div>
          <div class="col-sm-4 wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="650ms">
            <div class="service-icon">
              <i class="fa fa-calendar"></i>
            </div>
            <div class="service-info">
              <h3>일정 관리 서비스</h3>
              <p>우리 그룹의 일정을 Online에서 관리하세요. <br>체계적인 모임 운영을 도와드립니다.</p>
            </div>
          </div>
          <div class="col-sm-4 wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="750ms">
            <div class="service-icon">
              <i class="fa fa-eye"></i>
            </div>
            <div class="service-info">
              <h3>커뮤니티 서비스</h3>
              <p>회원들의 최근 관심사는? <br>커뮤니티를 분석하여 우리 그룹 회원들의 <br>관심사를 알려드립니다.</p>
            </div>
          </div>
          <div class="col-sm-4 wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="850ms">
            <div class="service-icon">
              <i class="fa fa-comments-o"></i>
            </div>
            <div class="service-info">
              <h3>소셜 네트워크</h3>
              <p>우리 그룹만의 커뮤니티 공간에서 <br>Social 서비스를 제공합니다.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section><!--/#services-->

  <section id="contact">
    <div id="contact-us" class="parallax">
      <div class="container">
        <div class="row">
          <div class="heading text-center col-sm-8 col-sm-offset-2 wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
            <h1>Contact <span>NURIDA</span></h1>
            <p>누리다에 문의사항이 있으신가요? 누리다 개발진에게 문의사항을 남겨주세요!</p>
            </div>
          </div>
        <div class="contact-form wow fadeIn" data-wow-duration="1000ms" data-wow-delay="600ms">
          <div class="row">
            <div class="col-sm-6">
              <form id="main-contact-form" name="contact-form" method="post" action="#">
                <div class="row  wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
                  <div class="col-sm-6">
                    <div class="form-group">
                      <input type="text" name="name" class="form-control" placeholder="Name" required="required">
                    </div>
                  </div>
                  <div class="col-sm-6">
                    <div class="form-group">
                      <input type="email" name="email" class="form-control" placeholder="Email Address" required="required">
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <input type="text" name="subject" class="form-control" placeholder="Subject" required="required">
                </div>
                <div class="form-group">
                  <textarea name="message" id="message" class="form-control" rows="4" placeholder="Enter your message" required="required"></textarea>
                </div>                        
                <div class="form-group">
                  <button type="submit" class="btn-submit">문의하기</button>
                </div>
              </form>   
            </div>
            <div class="col-sm-6">
              <div class="contact-info wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
                <p>사이트를 이용하시는데 불만사항이나 건의사항이 있으시면 아래의 연락처로 문의주세요.</p>
                <ul class="address">
                  <li><i class="fa fa-envelope"></i> <span> Email:</span><a href="#"> nuridaservice@gmail.com</a></li>
                  <li><i class="fa fa-globe"></i> <span> Website:</span> <a href="#"> www.nurida.com</a></li>
                </ul>
              </div>                            
            </div>
          </div>
        </div>
      </div>
    </div>        
  </section><!--/#contact-->
  <footer id="footer">
    <div class="footer-top wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
      <div class="container text-center">
        <div class="footer-logo" style="margin-left: 210px;">
          <a href="<%=cp%>/"><img class="img-responsive" src="<%=cp%>/res/img/logo/nuridalogo.png" width="60%" height="60%" alt=""></a>
        </div>
        <div class="social-icons">
          	<p style="font-size:14px;">만든 사람들 : 김도형 김우현 백은제 이성욱 이성표 이현규</p>
        </div>
      </div>
    </div>
  </footer>
  
  <!-- 그룹 생성 모달 -->

   <div class="modal fade" id="groupModal" tabindex="-1"
      role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal">
                  <span aria-hidden="true">×</span><span class="sr-only">Close</span>
               </button>
            </div>
            <div class="modal-body">

         <!-- content goes here -->
         <div class="wizard-container"> 
                <!-- You can switch "ct-wizard-orange"  with one of the next bright colors: "ct-wizard-blue", "ct-wizard-green", "ct-wizard-orange", "ct-wizard-red" -->
                <div class="card wizard-card ct-wizard-blue" id="wizardProfile">
                    <form name="groupForm" method="post" onsubmit="check();">
                       <div class="wizard-header">
                           <h3>
                              <b>그룹</b> 생성하기 <br>
                              <small>간단한 회원가입으로 그룹이 생성됩니다!</small>
                           </h3>
                       </div>
                       <ul>
                            <li><a href="#group" data-toggle="tab">group</a></li>
                            <li><a href="#account" data-toggle="tab">account</a></li>
                            <li><a href="#represent" data-toggle="tab">represent</a></li>
                        </ul>
                        
                        <div class="tab-content">
                            <div class="tab-pane" id="group">
                              <div class="row">
                                  <div class="col-sm-10 col-sm-offset-1">
                                     <br>
                                      <div class="form-group">
										 <label>그 룹 명 <small>(required)</small></label> <input
										 	id="groupName" name="groupName" type="text" class="mform-control"
										    oninput="check01();">
										 	<p class="help-block">그룹명을 입력하세요.</p>
                                      </div>
                                      <div class="form-group">
										 <label>그 룹 아 이 디 <small>(required)</small></label> <input
										 	id="groupUrl" name="groupUrl" type="text"
											 class="mform-control" onchange="groupUrlCheck();">
										 	<p class="help-block">그룹 아이디는 5~10자 이내이며, 소문자만 사용 가능합니다.</p>
                                      </div>
                                      <div class="form-group">
										 <label>그 룹 소 개<small>(required)</small></label>
										 	<textarea id="introduce" name="introduce" class="mform-control" 
										 	oninput="check02();"></textarea>
										 	<p class="help-block">그룹 소개글을 입력하세요.</p>
                                      </div>
                                      <div class="form-group">
										 <label>그 룹 창 립 일 <small>(required)</small></label> <input
										 	id="foundationDay" name="foundationDay" type="date" class="mform-control"
										 	onchange="check03();">
										 	<p class="help-block">그룹 창립일은 YYYY-MM-DD 형식으로 입력 합니다.</p>
                                      </div>
                                  </div>
                                  <div class="col-sm-10 col-sm-offset-1">
                                      <div class="form-group">
                                           <label>활 동 지 역</label><br>
                                             <select name="area" class="mform-control">
                                                <option value="서울"> 서울 </option>
                                                <option value="경기"> 경기 </option>
                                                <option value="인천"> 인천 </option>
                                                <option value="강원"> 강원 </option>
                                                <option value="강원"> 충청 </option>
                                                <option value="강원"> 전라 </option>
                                                <option value="강원"> 경상 </option>
                                                <option value="강원"> 제주 </option>
                                                <option value="기타"> 기타 </option>
                                            </select>
                                      </div>
                                  </div>
                             
                              </div>
                            </div>
                            <div class="tab-pane" id="account">
                                <div class="row">
                                   <div class="col-sm-10 col-sm-offset-1">
                                     <br>
                                      <div class="form-group">
										<label>그 룹 계 좌 <small>(required)</small></label> <input
											id="accountNumber" name="accountNumber" type="text" class="mform-control"
											oninput="check04();">
										<p class="help-block">- 없이 숫자로만 입력하세요.</p>
                                      </div>
                                      <div class="form-group">
										<label>은 행 명<small>(required)</small></label> <select
											id="bankName" name="bankName" class="mform-control"
											oninput="check05();">
											<option value="">선택하기</option>
											<option value="우리은행">우리은행</option>
											<option value="신한은행">신한은행</option>
											<option value="국민은행">국민은행</option>
											<option value="하나은행">하나은행</option>
											<option value="기타">기타</option>
											</select>
										<p class="help-block">계좌 은행을 선택하세요.</p>
                                      </div>
                                      <div class="form-group">
										<label>예 금 주<small>(required)</small></label> <input
											id="accountHolder" name="accountHolder" type="text" class="mform-control"
											oninput="check06();">
											<p class="help-block">예금주를 입력하세요.</p>
                                      </div>
                                  </div>

                                    
                                </div>
                            </div>
                            
                            <div class="tab-pane" id="represent">
                                <div class="row">
                                     <div class="col-sm-10 col-sm-offset-1">
                                     <br>
												<div class="form-group">
													<label>그 룹 장 아 이 디 <small>(required)</small></label> <input
														id="userId" name="userId" type="text"
														class="mform-control" onchange="userIdCheck();">
													<p class="help-block">그룹장 아이디는 5~10자 이내이며, 소문자만 사용 가능합니다.</p>
												</div>
												<div class="form-group">
													<label>그 룹 장 비 밀 번 호<small>(required)</small></label> <input
														id="pwd" name="pwd" type="password" class="mform-control"
														oninput="check07();">
													<p class="help-block">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</p>
												</div>

												<div class="form-group">
													<label>그 룹 장 비 밀 번 호 확 인<small>(required)</small></label> <input
														id="pwdCheck" name="pwdCheck" type="password"
														class="mform-control"
														oninput="check08();">
													<p class="help-block">패스워드를 한번 더 입력해주세요.</p>
												</div>

												<div class="form-group">
													<label>그 룹 장 이 름<small>(required)</small></label> <input
														id="name" name="name" type="text" class="mform-control"
														oninput="check09();">
													<p class="help-block">이름을 입력하세요.</p>
												</div>
												<div class="form-group">
													<label>생 년 월 일<small>(required)</small></label> <input
														id="birth" name="birth" type="text" class="mform-control"
														oninput="check10();">
													<p class="help-block">생년월일은 2000-01-01 형식으로 입력 합니다.</p>
												</div>
												<div class="form-group">
													<label>성 별<small>(required)</small></label> <select
														id="gender" name="gender" class="mform-control">
														<option value="1">남성</option>
														<option value="2">여성</option>
													</select>
													<p class="help-block">성별을 선택하세요.</p>
												</div>
												<div class="form-group">
													<label>전 화 번 호<small>(required)</small></label> <input
														id="tel" name="tel" type="text" class="mform-control"
														oninput="check11();">
														
													<p class="help-block">전화번호는은 010-0000-0000 형식으로 입력 합니다.</p>
												</div>
												<div class="form-group">
													<label>이 메 일<small>(required)</small></label> <input
														id="email" name="email" type="email" class="mform-control"
														oninput="check12();">
													<p class="help-block">id@email.com 형식으로 입력하세요.</p>
												</div>
                                  </div>
                                    
                                </div>
                            </div>
                        </div>
                        <div class="wizard-footer">
                            <div class="pull-right">
                                <input type="button" class="btn btn-next btn-fill btn-warning btn-wd btn-sm" name="next" value="Next" />
                                <input type="submit" class="btn btn-finish btn-fill btn-warning btn-wd btn-sm" name="finish" value="Finish" />
        
                            </div>
                            
                            <div class="pull-left">
                                <input type="button" class="btn btn-previous btn-fill btn-default btn-wd btn-sm" name="previous" value="Previous" />
                            </div>
                            <div class="clearfix"></div>
                        </div>   
                    </form>
                </div>
            </div> <!-- wizard container -->
            

                  </div>
                </div>
              </div>
            </div>

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