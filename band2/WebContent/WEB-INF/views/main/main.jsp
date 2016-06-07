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
            <h1 class="animated fadeInLeftBig">Welcome to <span>BAND</span></h1>
            <p class="animated fadeInRightBig">그룹 관리 서비스로 체계적인 모임 운영을!</p>
            <a data-scroll class="btn btn-start animated fadeInUpBig" data-toggle="modal" data-target="#groupModal">그룹 생성하기</a>
          </div>
        </div>
        <div class="item" style="background-image: url(<%=cp%>/res/img/slider/2.jpg)">
          <div class="caption">
            <h1 class="animated fadeInLeftBig">Say Hello to <span>BAND</span></h1>
            <p class="animated fadeInRightBig">우리 그룹만의 커뮤니티를 누려보세요!</p>
            <a data-scroll class="btn btn-start animated fadeInUpBig" data-toggle="modal" data-target="#groupModal">그룹 생성하기</a>
          </div>
        </div>
        <div class="item" style="background-image: url(<%=cp%>/res/img/slider/3.jpg)">
          <div class="caption">
            <h1 class="animated fadeInLeftBig">We are <span>BAND</span></h1>
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
          <a class="navbar-brand" href="index.jsp">
            <h1><img class="img-responsive" src="<%=cp%>/res/img/logo.png" alt="logo"></h1>
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
            <h2>Our Services</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam</p>
          </div>
        </div> 
      </div>
      <div class="text-center our-services">
        <div class="row">
          <div class="col-sm-4 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms">
            <div class="service-icon">
              <i class="fa fa-flask"></i>
            </div>
            <div class="service-info">
              <h3>Brand Identity</h3>
              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore</p>
            </div>
          </div>
          <div class="col-sm-4 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="450ms">
            <div class="service-icon">
              <i class="fa fa-umbrella"></i>
            </div>
            <div class="service-info">
              <h3>Creative Idea</h3>
              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore</p>
            </div>
          </div>
          <div class="col-sm-4 wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="550ms">
            <div class="service-icon">
              <i class="fa fa-cloud"></i>
            </div>
            <div class="service-info">
              <h3>Awesome Support</h3>
              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore</p>
            </div>
          </div>
          <div class="col-sm-4 wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="650ms">
            <div class="service-icon">
              <i class="fa fa-coffee"></i>
            </div>
            <div class="service-info">
              <h3>Professional Design</h3>
              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore</p>
            </div>
          </div>
          <div class="col-sm-4 wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="750ms">
            <div class="service-icon">
              <i class="fa fa-bitbucket"></i>
            </div>
            <div class="service-info">
              <h3>App Development</h3>
              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore</p>
            </div>
          </div>
          <div class="col-sm-4 wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="850ms">
            <div class="service-icon">
              <i class="fa fa-gift"></i>
            </div>
            <div class="service-info">
              <h3>Clean Code</h3>
              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore</p>
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
            <h2>Contact Us</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ut enim ad minim veniam</p>
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
                  <button type="submit" class="btn-submit">Send Now</button>
                </div>
              </form>   
            </div>
            <div class="col-sm-6">
              <div class="contact-info wow fadeInUp" data-wow-duration="1000ms" data-wow-delay="300ms">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.</p>
                <ul class="address">
                  <li><i class="fa fa-map-marker"></i> <span> Address:</span> 2400 South Avenue A </li>
                  <li><i class="fa fa-phone"></i> <span> Phone:</span> +928 336 2000  </li>
                  <li><i class="fa fa-envelope"></i> <span> Email:</span><a href="mailto:someone@yoursite.com"> support@oxygen.com</a></li>
                  <li><i class="fa fa-globe"></i> <span> Website:</span> <a href="#">www.sitename.com</a></li>
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
        <div class="footer-logo">
          <a href="index.html"><img class="img-responsive" src="<%=cp%>/res/img/logo.png" alt=""></a>
        </div>
        <div class="social-icons">
          <ul>
            <li><a class="envelope" href="#"><i class="fa fa-envelope"></i></a></li>
            <li><a class="twitter" href="#"><i class="fa fa-twitter"></i></a></li> 
            <li><a class="dribbble" href="#"><i class="fa fa-dribbble"></i></a></li>
            <li><a class="facebook" href="#"><i class="fa fa-facebook"></i></a></li>
            <li><a class="linkedin" href="#"><i class="fa fa-linkedin"></i></a></li>
            <li><a class="tumblr" href="#"><i class="fa fa-tumblr-square"></i></a></li>
          </ul>
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
                    <form action="" method="">
                
                
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
                                        <label>그 룹 명 <small>(required)</small></label>
                                        <input name="groupName" type="text" class="mform-control">
                                      </div>
                                      <div class="form-group">
                                        <label>그 룹 아 이 디 <small>(required)</small></label>
                                        <input name="groupId" type="text" class="mform-control">
                                      </div>
                                      <div class="form-group">
                                        <label>그 룹 창 립 일 <small>(required)</small></label>
                                        <input name="groupCreated" type="date" class="mform-control">
                                      </div>
                                  </div>
                                  <div class="col-sm-10 col-sm-offset-1">
                                      <div class="form-group">
                                           <label>활 동 지 역</label><br>
                                             <select name="area" class="mform-control">
                                                <option value="서울"> 서울 </option>
                                                <option value="경기"> 경기 </option>
                                                <option value="인천"> 인천 </option>
                                                <option value="강원 "> 강원 </option>
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
                                        <label>그 룹 계 좌 <small></small></label>
                                        <input name="groupAccount" type="text" class="mform-control">
                                      </div>
                                      <div class="form-group">
                                        <label>은 행 명<small></small></label>
                                        <select name="bank" class="mform-control">
                                                <option value="우리"> 우리은행 </option>
                                                <option value="신한"> 신한은행 </option>
                                        </select>
                                      </div>
                                      <div class="form-group">
                                        <label>예 금 주<small></small></label>
                                        <input name="AccountName" type="text" class="mform-control">
                                      </div>
                                  </div>

                                    
                                </div>
                            </div>
                            
                            <div class="tab-pane" id="represent">
                                <div class="row">
                                     <div class="col-sm-10 col-sm-offset-1">
                                     <br>
                                      <div class="form-group">
                                        <label>아 이 디 <small></small></label>
                                        <input name="" type="text" class="mform-control">
                                      </div>
                                      <div class="form-group">
                                        <label>비 밀 번 호<small></small></label>
                                        <input name="" type="text" class="mform-control">
                                      </div>
                                      <div class="form-group">
                                        <label>이 름<small></small></label>
                                        <input name="" type="text" class="mform-control">
                                      </div>
                                      <div class="form-group">
                                        <label>생 년 월 일<small></small></label>
                                        <input name="" type="text" class="mform-control">
                                      </div>
                                  </div>
                                    
                                </div>
                            </div>
                        </div>
                        <div class="wizard-footer">
                            <div class="pull-right">
                                <input type='button' class='btn btn-next btn-fill btn-warning btn-wd btn-sm' name='next' value='Next' />
                                <input type='button' class='btn btn-finish btn-fill btn-warning btn-wd btn-sm' name='finish' value='Finish' />
        
                            </div>
                            
                            <div class="pull-left">
                                <input type='button' class='btn btn-previous btn-fill btn-default btn-wd btn-sm' name='previous' value='Previous' />
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