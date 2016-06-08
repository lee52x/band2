<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">
<link href="<%=cp%>/res/css/admin/green.css" rel="stylesheet">
<link href="<%=cp%>/res/css/admin/switchery.min.css" rel="stylesheet">

<style>
	.row{
	margin-left:15%;
	}
	
	.tabs-left>li>a {
    background: rgba(70, 165, 146, 0.16);
    }
    .switchery>small {
    height: 20px;
    width: 20px;
    }
    .switchery {
    height: 20px;
    width: 40px;
    }
</style>


<div class="col-md-12 col-sm-12 col-xs-12">
	<div class="x_panel">
		<div class="x_title">
			<h2>
				<i class="fa fa-bars"></i><small>회비 관리</small>
			</h2>
			<ul class="nav navbar-right panel_toolbox">
				<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
				</li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false"><i
						class="fa fa-wrench"></i></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">Settings 1</a></li>
						<li><a href="#">Settings 2</a></li>
					</ul></li>
				<li><a class="close-link"><i class="fa fa-close"></i></a></li>
			</ul>
			<div class="clearfix"></div>
		</div>
		<div class="x_content">

			<div class="col-xs-3">
				<ul class="nav nav-tabs tabs-left">
					<c:forEach var="dto" items="${eventList}">
					<c:if test="${dto.num==1}">
					<li class="active"><a href="#event_${dto.eventNo}" data-toggle="tab">${dto.eventName}</a></li>
					</c:if>
					<c:if test="${dto.num!=1}">
					<li><a href="#event_${dto.eventNo}" data-toggle="tab">${dto.eventName}</a></li>
					</c:if>
					</c:forEach>
					<li><a href="#addFee" data-toggle="tab" style="background: rgba(42, 63, 84, 0.08);">정기회비 추가
					<i class="fa fa-plus" style="float:right;"></i></a></li>
				</ul>
			</div>

			<div class="col-xs-9">
				<!-- Tab panes -->
				<div class="tab-content">
				<c:forEach var="dto" items="${eventList}">
					<c:if test="${dto.num==1}">
					<div class="tab-pane active" id="event_${dto.eventNo}">
					<p>[${dto.eventName}] 회비 납부율</p>
                      <div class="">
                        <div class="progress progress_sm" style="width: 100%;">
                          <div class="progress-bar bg-green" role="progressbar" data-transitiongoal="50"></div>
                        </div>
                      </div>
					<table class="table table-bordered">
                      <thead>
                        <tr>
                          <th>이름(아이디)</th>
                          <th>회원등급</th>
                          <th>전화번호</th>
                          <th>메일주소</th>
                          <th>납부여부</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>Mark</td>
                          <td>Otto</td>
                          <td>@mdo</td>
                          <td>@mdo</td>
                          <td><input type="checkbox" class="js-switch"/></td>
                        </tr>
                      </tbody>
                    </table>
                    
					</div>
					</c:if>
					
					<!-- 두번째부터 -->
					<c:if test="${dto.num!=1}">
					<div class="tab-pane" id="event_${dto.eventNo}">
					<p>Facebook Campaign</p>
                      <div class="">
                        <div class="progress progress_sm" style="width: 100%;">
                          <div class="progress-bar bg-green" role="progressbar" data-transitiongoal="50"></div>
                        </div>
                      </div>
					<table class="table table-bordered">
                      <thead>
                        <tr>
                          <th>이름(아이디)</th>
                          <th>회원등급</th>
                          <th>전화번호</th>
                          <th>메일주소</th>
                          <th>납부여부</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>Mark</td>
                          <td>Otto</td>
                          <td>@mdo</td>
                          <td>@mdo</td>
                          <td>@mdo</td>
                        </tr>
                      </tbody>
                    </table>
                    
					</div>
					</c:if>
					
					</c:forEach>
					<!-- 회비추가 -->
					<div class="tab-pane" id="addFee">
					<form class="form-horizontal form-label-left">

                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">회비 이름</label>
                        <div class="col-md-5 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" placeholder="정기회비1">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">금액</label>
                        <div class="col-md-5 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" placeholder="50,000">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">설명</label>
                        <div class="col-md-5 col-sm-9 col-xs-12">
                          <textarea class="form-control" rows="3" placeholder="2016년 1학기 회비입니다."></textarea>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">납부 마감일
                        </label>
                        <div class="col-md-5 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" placeholder="2016-06-08">
                        </div>
                      </div>
                      <div class="form-group">
                        <div class="col-md-5 col-sm-9 col-xs-12 col-md-offset-3">
                          <button type="submit" class="btn btn-primary">Cancel</button>
                          <button type="submit" class="btn btn-success">Submit</button>
                        </div>
                      </div>

                    </form>
					</div>
				</div>
			</div>

			<div class="clearfix"></div>

		</div>
	</div>
</div>


<script src="<%=cp%>/res/js/admin/icheck.min.js"></script> <!-- 리스트부분 css임--> 
<!-- bootstrap-progressbar -->
<script src="<%=cp%>/res/js/admin/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
<script src="<%=cp%>/res/js/admin/switchery.min.js"></script>