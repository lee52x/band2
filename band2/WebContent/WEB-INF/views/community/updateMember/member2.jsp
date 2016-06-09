<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>
<head>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<script type="text/javascript" src="<%=cp%>/res/js/util.js"></script>
<script type="text/javascript">
// 아이디 중복 검사
function userIdCheck() {
	var userId=$("#userId").val();
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(userId)) { 
		var str="아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.";
		$("#userId").focus();
		$("#userId + .help-block").html(str);
		return false;
	}
	
	var url="<%=cp%>/member/userIdCheck";
	var params="userId="+userId;
	$.ajax({
		type:"POST"
		,url:url
		,data:params
		,dataType:"JSON"
		,success:function(data) {
			var passed=data.passed;
			if(passed=="true") {
				var str="<span style='color:blue;font-weight: bold;'>"+userId+"</span> 아이디는 사용가능 합니다.";
				$("#userId + .help-block").html(str);
			} else {
				var str="<span style='color:red;font-weight: bold;'>"+userId+"</span> 아이디는 사용할수 없습니다.";
				$("#userId + .help-block").html(str);
				$("#userId").val("");
				$("#userId").focus();
			}
		}
	});
}

function check() {
	var f = document.memberForm;
	var str;
	
	str=f.userId.value;
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) {
		f.userId.focus();
		return false;
	}
	
	str = f.pwd.value;
	if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
		f.userPwd.focus();
		return false;
	}
	
	if(f.userPwdCheck.value != str) {
		$("#userPwdCheck + .help-block").html("패스워드가 일치하지 않습니다.");
		f.userPwdCheck.focus();
		return false;
	} else {
		$("#userPwdCheck + .help-block").html("패스워드를 한번 더 입력해주세요.");
	}
	
    str = f.name.value;
	str = $.trim(str);
    if(!str) {
        f.name.focus();
        return false;
    }
    f.name.value = str;
	
    str = f.birth.value;
    if(!isValidDateFormat(str)) {
        f.birth.focus();
        return false;
    }

    str = f.email.value;
    if(!isValidEmail) {
        f.email.focus();
        return false;
    }
    
    str = f.tel.value;
    if(!str) {
        f.tel.focus();
        return false;
    }

   
    
    var mode="${mode}";
  
    if(mode=="created") {
    	f.action = "<%=cp%>/insertMember/${url}";
    } else if(mode=="update") {
    	f.action = "<%=cp%>/updateMember/${url}";
    }
    
    return true;
}
</script>

<div class="carousel-inner"
style="background-image: url(<%=cp%>/res/img/slider/3.jpg)">
<div class="container">

    <h1><span class="glyphicon glyphicon-user"></span> ${mode=="created"?"회원 가입":"회원 정보 수정"}</h1>
    <p>SPRING의 회원이 되시면 회원님만의 유익한 정보를 만날수 있습니다.</p>


<div class="bodyFrame">

 <form class="form-horizontal" name="memberForm" method="post" onsubmit="return check();">
    <div class="form-group">
        <label class="col-sm-2 control-label" for="userId">아이디</label>
        <div class="col-sm-7">
            <input class="form-control" id="userId" name="userId" type="text" placeholder="아이디"
                       onchange="userIdCheck();"
                       value="${dto.userId}"
                       ${mode=="update" ? "readonly='readonly' style='border:none;'":""}>
            <p class="help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</p>
        </div>
    </div>
 
    <div class="form-group">
        <label class="col-sm-2 control-label" for="pwd">패스워드</label>
        <div class="col-sm-7">
            <input class="form-control" id="pwd" name="pwd" type="password" placeholder="비밀번호">
            <p class="help-block">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</p>
        </div>
    </div>
    
        <div class="form-group">
        <label class="col-sm-2 control-label" for="userPwdCheck">패스워드 확인</label>
        <div class="col-sm-7">
            <input class="form-control" id="userPwdCheck" name="userPwdCheck" type="password" placeholder="비밀번호 확인">
            <p class="help-block">패스워드를 한번 더 입력해주세요.</p>
        </div>
    </div>
    

 
    <div class="form-group">
        <label class="col-sm-2 control-label" for="name">이름</label>
        <div class="col-sm-7">
            <input class="form-control" id="name" name="name" type="text" placeholder="이름"
                       value="${dto.name}" ${mode=="update" ? "readonly='readonly' style='border:none;' ":""}>
        </div>
    </div>
 
    <div class="form-group">
        <label class="col-sm-2 control-label" for="birth">생년월일</label>
        <div class="col-sm-7">
            <input class="form-control" id="birth" name="birth" type="text" placeholder="생년월일" value="${dto.birth}">
            <p class="help-block">생년월일은 2000-01-01 형식으로 입력 합니다.</p>
        </div>
    </div>

    <div class="form-group">
        <label class="col-sm-2 control-label" for="email">이메일</label>
        <div class="col-sm-7">
            <input class="form-control" id="email" name="email" type="email" placeholder="이메일" value="${dto.email}">
        </div>
    </div>
    
   <div class="form-group">
        <label class="col-sm-2 control-label" for="tel">전화번호</label>
        <div class="col-sm-7">
            <input class="form-control" id="tel" name="tel" type="text" placeholder="전화번호" value="${dto.tel}">
        </div>
    </div>
    
       <div class="form-group">
        <label class="col-sm-2 control-label" for="address">주소</label>
        <div class="col-sm-7">
            <input class="form-control" id="address" name="address" type="text" placeholder="주소" value="${dto.address}">
        </div>
    </div>
    
         <div class="form-group">
      		<label class="col-sm-2 control-label" for="gender">성별</label>
             <div class="col-sm-7">
             <select name="gender" id="gender" class="form-control">
               <option value="1">남성 </option>
               <option value="2">여성 </option>
            </select>
            </div>
          </div>
                             
        
        
        
        
<c:if test="${mode=='created'}">
    <div class="form-group">
        <label class="col-sm-2 control-label" for="agree">약관 동의</label>
        <div class="col-sm-7 checkbox">
            <label>
                <input id="agree" name="agree" type="checkbox" checked="checked"
                         onchange="form.sendButton.disabled = !checked"> <a href="#">이용약관</a>에 동의합니다.
            </label>
        </div>
    </div>
</c:if>
     
    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
<c:if test="${mode=='created'}">
            <button type="submit" name="sendButton" class="btn btn-primary">회원가입 <span class="glyphicon glyphicon-ok"></span></button>
            <button type="button" class="btn btn-danger" onclick="javascript:location.href='<%=cp%>/';">가입취소 <span class="glyphicon glyphicon-remove"></span></button>
</c:if>            
<c:if test="${mode=='update'}">
            <button type="submit" class="btn btn-primary">정보수정 <span class="glyphicon glyphicon-ok"></span></button>
            <button type="button" class="btn btn-danger" onclick="javascript:location.href='<%=cp%>/community/${url}';">수정취소 <span class="glyphicon glyphicon-remove"></span></button>
</c:if>            
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
                <p class="form-control-static">${message}</p>
        </div>
    </div>
    
    
     
  </form>
 
</div>
</div>
</div>





