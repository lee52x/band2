<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
 <script type="text/javascript">
function submit() {

	
	
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
                    <form class="form-horizontal form-label-left" onsubmit="return submit();">

                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">그룹코드 URL </label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" readonly="readonly" placeholder="${dto.groupURL}">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">그룹 이름</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" placeholder="${dto.name}">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">주 활동 지역</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" placeholder="${dto.area}">
                        </div>
                      </div>
                      <div class="form-group">  
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">인증 코드</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" placeholder="${dto.verification}">
                        </div>
                      </div>
                       <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">거래 은행</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <select class="form-control">
                            <option>${dto.bankName}</option>
                            <option>Option one</option>
                            <option>Option two</option>
                            <option>Option three</option>
                            <option>Option four</option>
                          </select>
                        </div>
                      </div>
                      <div class="form-group">  
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">계좌 번호</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" placeholder="${dto.accountNumber}">
                        </div>
                      </div>
                      <div class="form-group">  
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">예금주</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" placeholder="${dto.accountHolder}">
                        </div>
                      </div>
                      <div class="form-group">  
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">그룹장 아이디</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" placeholder="${dto.userId}">
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

   