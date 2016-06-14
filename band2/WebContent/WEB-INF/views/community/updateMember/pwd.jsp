<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<head>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">


</head>


<style type="text/css">
.form-signin {
  max-width: 440px;
  padding: 15px;
  margin: 0 auto;
}

@media (min-width: 768px) {
  .form-signin {
    padding-top: 70px;
  }
}

.form-signin-heading {
  text-align: center;
  font-weight:bold;
  font-family: NanumGothic, 나눔고딕, "Malgun Gothic", "맑은 고딕", sans-serif;
  margin-bottom: 30px;
}

.lbl {
   position:absolute; 
   margin-left:15px; margin-top: 13px;
   color: #999999;
   font-family: NanumGothic, 나눔고딕, "Malgun Gothic", "맑은 고딕", 돋움, sans-serif;
}

.loginTF {
  max-width: 370px; height:45px;
  padding: 5px;
  padding-left: 15px;
  margin-top:5px; margin-bottom:15px;
}

.boxLayout {
    max-width:420px;
    padding:20px;
    border: 1px solid #DAD9FF;
}
</style>

<script type="text/javascript">
function bgLabel(ob, id) {
	    if(!ob.value) {
		    document.getElementById(id).style.display="";
	    } else {
		    document.getElementById(id).style.display="none";
	    }
}



function checkMember(){
var f = document.modalLoginForm;
	
	
	
	var str = f.name.value;
		str = $.trim(str);
	    if(!str) {
	        f.name.focus();
	    	alert("성명을 입력해 주세요.");
	    	
	        return false;
	    }
	
	

	str=f.userId.value;
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) {
		f.userId.focus();
		alert("아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.");
		return false;
	}
	
	
	
	str = f.pwd.value;
	if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
		f.pwd.focus();
		alert("패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.");
		return false;
	}
	
	

	if(f.confirmPwd.value != str) {
		f.confirmPwd.focus();
		alert("패스워드가 일치하지 않습니다.");
		return false;
	} else {
		$("#confirmPwd + .help-block").html("패스워드를 한번 더 입력해주세요.");
	}
	if(f.confirmPwd.value != str) {
		$("#confirmPwd + .help-block").html("패스워드가 일치하지 않습니다.");
		f.userPwdCheck.focus();
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
    
    alert("수정하시겠습니까?");
   
    

   
    
    	f.action = "<%=cp%>/update/information/${url}";

  		f.submit();
	
}

function sendOk() {
	var f=document.confirmForm;

	var str=f.pwd.value;
	if(!str){
		f.pwd.focus();
		return false;
	}	
	
	var params="memberNo=${sessionScope.main.memberNo}&pwd="+str;
		$.ajax({
			type:"POST"
			,url:"<%=cp%>/comfirmMember/pwd/${url}"
			,data:params
			,dataType:"json"
			,success:function(data){
				
				var state=data.state;
				if(state=="true"){
					$("#name").val(data.dto.name);
					$("#userId").val(data.dto.userId);
					$("#birth").val(data.dto.birth);
					$("#email").val(data.dto.email);
					$("#tel").val(data.dto.tel);
					$("#address").val(data.dto.address);
					
					$("#modalJoin").modal("show");
				}else if(state=="false"){
					alert("패스워드가 일치하지 않습니다.");
				}
			}
			,error:function(e){
				alert(e.responseText);
			}
		});
}

</script>
<div class="bodyFrame">

    <form class="form-signin" name="confirmForm" method="post">
        <h2 class="form-signin-heading">패스워드 재확인</h2>
        <div class="boxLayout">
            <div style="text-align: left; padding-bottom: 10px; ">정보보호를 위해 패스워드를 다시 한 번 입력해주세요.</div>
            <input type="text" id="userId" name="userId" class="form-control loginTF"
	              value="${sessionScope.main.userId}"
                  readonly="readonly"
	              >
	              <input type="hidden" id="memberNo" name="memberNo"
	              value="${sessionScope.main.memberNo}">
	              
            <label for="pwd" id="pwd" class="lbl">패스워드</label>
            <input type="password" id="pwd" name="pwd" class="form-control loginTF" autofocus="autofocus"
                  onfocus="document.getElementById('lblpwd').style.display='none';"
	              onblur="bgLabel(this, 'lblpwd');">
            <button class="btn btn-lg btn-primary btn-block" type="button" onclick="sendOk();">확인 <span class="glyphicon glyphicon-ok"></span></button>
            <input type="hidden" name="mode" value="${mode}">
        </div>
        <div style="margin-top:10px; text-align: center;">${message}</div>
        
    </form>

</div>






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
			            <input class="form-control" id="uesrId" name="userId" type="text" readonly="readonly" value="${sessionScope.main.userId}">
			            
			       
			         
			            <label class="control-label" for="pwd">패스워드</label>
			            <input class="form-control" id="pwd" name="pwd" type="password" placeholder="패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.">
			      
			        
			            <label class="control-label" for="confirmPwd">패스워드확인</label>
			            <input class="form-control" id="confirmPwd" name="confirmPwd" type="password" placeholder="패스워드를 한번 더 입력해주세요.">
			        
			        
			        </div>
			        	         
			        	         
			        	         
			         <div class="form-group" id="second">
			           			        	         
			            <label class="control-label" for="birth">생년월일</label>
			            <input class="form-control" id="birth" name="birth" type="text"  placeholder="생년월일은 2000-01-01 형식으로 입력 합니다.">
			      
			        	       
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
			            <button class="btn btn-lg btn-primary btn-block" type="button" onclick="checkMember();">수정하기 <span class="glyphicon glyphicon-ok"></span></button>
                    </div>
                    
               
                    
			        
			    </form>
			</div>
		</div>
	</div>
	
</div>
