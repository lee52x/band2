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
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


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

<script type="text/javascript">

function next(){
	$("#first").hide();
	$("#second").show();
	$("#joinButton").show();
}
function previous(){
	$("#second").hide();
	$("#first").show();
	$("#joinButton").hide();
}	


function dialogJoin(){
	$("#userId").val("");
	$("#pwd").val("");
	$("#confirmPwd").val("");
	$("#name").val("");
	$("#birth").val("");
	$("#email").val("");
	$("#tel").val("");
	$("#address").val("");
	$("#gender").val("");
	$("#modalJoin").show("#first").modal("show");
	$("#second").hide();
	$("#third").hide();
	$("#joinButton").hide();
}


function checkMember() {
	var f = document.modalLoginForm;
	
	
	
	var str = f.name.value;
		str = $.trim(str);
	    if(!str) {
	    	$("#second").hide();
			$("#first").show();
			 $("#joinButton").hide();
	        f.name.focus();
	    	alert("성명을 입력해 주세요.");
	    	
	        return false;
	    }
	
	

	str=f.userId.value;
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) {
		$("#second").hide();
		$("#first").show();
		 $("#joinButton").hide();
		f.userId.focus();
		alert("아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.");
		$("#joinButton").hide();
		return false;
	}
	
	
	
	str = f.pwd.value;
	if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
		$("#second").hide();
		$("#first").show();
		 $("#joinButton").hide();
		f.pwd.focus();
		alert("패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.");
		$("#joinButton").hide();
		return false;
	}
	
	

	if(f.confirmPwd.value != str) {
		$("#confirmPwd + .help-block").html("패스워드가 일치하지 않습니다.");
		$("#second").hide();
		$("#first").show();
		 $("#joinButton").hide();
		f.confirmPwd.focus();
		alert("패스워드가 일치하지 않습니다.");
		$("#joinButton").hide();
		return false;
	} else {
		$("#confirmPwd + .help-block").html("패스워드를 한번 더 입력해주세요.");
	}
	if(f.confirmPwd.value != str) {
		$("#confirmPwd + .help-block").html("패스워드가 일치하지 않습니다.");
		$("#second").hide();
		$("#first").show();
		 $("#joinButton").hide();
		f.userPwdCheck.focus();
		$("#joinButton").hide();
		return false;
	} else {
		$("#confirmPwd + .help-block").html("패스워드를 한번 더 입력해주세요.");
	}
	
	
    str = f.birth.value;
    if(! /^(\d+)[/|\-|\s]+[0|1](\d)[/|\-|\s]+([0|1|2|3]\d)$/i.test(str)) {
        f.birth.focus();
        alert("생년월일은 2000-01-01 형식으로 입력 합니다.");
        return false;
    }

    str = f.email.value;
    if(! /^(\w+)(((\.?)(\w+))*)[@](((\w+)[.])+)(\w{2,3})$/i.test(str)) {
        f.email.focus();
        alert("이메일은 test@test.com 형식으로 입력 합니다");
        return false;
    }
    
    str = f.tel.value;
    if(!str) {
        f.tel.focus();
        alert("전화번호를 입력해 주세요.");
        return false;
    }
    
    str = f.address.value;
    if(!str) {
        f.address.focus();
        alert("주소를 입력해 주세요.");
        return false;
    }
    
    str = f.gender.value;
    if(!str) {
        f.gender.focus();
        alert("성별을 선택해 주세요.");
        return false;
    }
    
    alert("회원가입이 완료되었습니다!! 로그인 후 이용해 주세요");
   
    

   
    
    	f.action = "<%=cp%>/insertMember/${url}";

  		f.submit();
}

</script>
<body>
	<header id="home">
		<div id="home-slider" class="carousel slide carousel-fade"
			data-ride="carousel">
			<div class="carousel-inner">
				<div class="item active"
					style="background-image: url(<%=cp%>/uploads/management/${pdto.saveFilename})">
					<div class="caption">
						<div class="row">
						  
							<div class="col-sm-5 col-sm-offset-3 form-box">
            					<h1 class="animated fadeInLeftBig"><span>${pdto.groupName}</span></h1>
            					<p class="animated fadeInRightBig">${pdto.introduce}</p>
         					 </div>
							<div class="col-sm-5 col-sm-offset-3 form-box">
								<div class="form-top">
									<div class="form-top-left">
										<h3>Login to our site</h3>
										<p>${message}</p>
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
								<a href="javascript:dialogJoin();">회원 가입</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#">아이디 찾기</a>
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

<div id="modalJoin" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 700px">
		<div class="modal-content">
			<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h2 id="myModalLabel" class="modal-title text-center fc-orange" style="font-family: sans-serif,나눔고딕, 맑은 고딕; font-weight: bold;">회원 가입</h2>
			</div>
			<div class="modal-body" style="background-color: #FFD8D8;">
			    <form name="modalLoginForm" method="post">
			 
			         <div class="form-group" id="first">
			           <label class="control-label" for="name">성명</label>
			            <input class="form-control" id="name" name="name" type="text" placeholder="이름">
			       
			         
			            <label class="control-label" for="uesrId">아이디</label>
			            <input class="form-control" id="uesrId" name="userId" type="text" placeholder="아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.">
			            
			       
			         
			            <label class="control-label" for="pwd">패스워드</label>
			            <input class="form-control" id="pwd" name="pwd" type="password" placeholder="패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.">
			      
			        
			            <label class="control-label" for="confirmPwd">패스워드확인</label>
			            <input class="form-control" id="confirmPwd" name="confirmPwd" type="password" placeholder="패스워드를 한번 더 입력해주세요.">
			        
			        
			        </div>
			        	         
			        	         
			        	         
			         <div class="form-group" id="second">
			           			        	         
			            <label class="control-label" for="birth">생년월일</label>
			            <input class="form-control" id="birth" name="birth" type="text" placeholder="생년월일은 2000-01-01 형식으로 입력 합니다.">
			      
			        	       
			            <label class="control-label" for="email">이메일</label>
			            <input class="form-control" id="email" name="email" type="text" placeholder="이메일은 test@test.com 형식으로 입력 합니다">
			            
			              <label class="control-label" for="tel">전화번호</label>
			            <input class="form-control" id="tel" name="tel" type="text" placeholder="전화번호">
			    
			        	      
			            <label class="control-label" for="address">주소</label>
			            <input class="form-control" id="address" name="address" type="text" placeholder="주소">
			     
			        	       
      					<label class="control-label" for="gender">성별</label>
             			<select name="gender" id="gender" class="form-control" style="background-color: white">
               					<option value="1">남성 </option>
               					<option value="2">여성 </option>
            			</select>
			        </div>
			        	         
			        	         
			 
        
			     

			        <div class="form-group" id="joinButton">
			            <button class="btn btn-lg btn-primary btn-block" type="button" onclick="checkMember();">가입하기 <span class="glyphicon glyphicon-ok"></span></button>
                    </div>
                       <div class="form-group">
			            <button type="button" onclick="previous();">이전</button>
             
			            <button type="button" onclick="next();">다음</button>
              			</div>
               
                    
			        
			    </form>
			</div>
		</div>
	</div>
	
</div>



</html>