<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
 <script type="text/javascript">
function submitUpdate() {

	var f=document.updateForm;
	
	var str = f.name.value;
    if(!str) {
        f.name.focus();
        alert("미입력 자료가 있습니다.");
        return false;
    }
    
    str = f.area.value;
    if(!str) {
        f.area.focus();
        alert("미입력 자료가 있습니다.");
        return false;
    }
    
    str = f.verification.value;
    if(!str) {
        f.verification.focus();
        alert("미입력 자료가 있습니다.");
        return false;
    }
    
    str = f.bankName.value;
    if(!str) {
        f.bankName.focus();
        alert("미입력 자료가 있습니다.");
        return false;
    }
    
    str = f.accountNumber.value;
    if(!str) {
        f.accountNumber.focus();
        alert("미입력 자료가 있습니다.");
        return false;
    }
    
    str = f.accountHolder.value;
    if(!str) {
        f.accountHolder.focus();
        alert("미입력 자료가 있습니다.");
        return false;
    }
    
    if(confirm("수정하시겠습니까?")){
    	
    	f.action = "<%=cp%>/admin/manager/update/${url}";
    	return true;
    }
    
    return false;
	
}
</script>
 
    
<link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">
        
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Form Basic Elements <small>different form elements</small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                    <form class="form-horizontal form-label-left" name="updateForm" onsubmit="return submitUpdate();" method="post">

                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">그룹코드 URL </label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" readonly="readonly" value="${dto.groupURL}">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">그룹 이름</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" name="name" value="${dto.name}">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">주 활동 지역</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" name="area" value="${dto.area}">
                        </div>
                      </div>
                      <div class="form-group">  
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">인증 코드</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" name="verification" value="${dto.verification}">
                        </div>
                      </div>
                       <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">거래 은행</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <select class="form-control" name="bankName">
                            <option>${dto.bankName}</option>
                            <option>신한은행</option>
                            <option>우리은행</option>
                            <option>산업은행</option>
                            <option>국민은행</option>
                          </select>
                        </div>
                      </div>
                      <div class="form-group">  
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">계좌 번호</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" name="accountNumber" value="${dto.accountNumber}">
                        </div>
                      </div>
                      <div class="form-group">  
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">예금주</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" name="accountHolder" value="${dto.accountHolder}">
                        </div>
                      </div>
                      <div class="form-group">  
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">그룹장 아이디</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" name="userId" value="${dto.userId}">
                        </div>
                      </div>

                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3">
                        	<button type="submit" class="btn btn-success">수정 완료</button>
                        	<button type="reset" class="btn btn-primary">다시 작성</button>
                        </div>
                      </div>

                    </form>
                  </div>
                </div>
        <!-- /page content -->

   