<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">
<link href="<%=cp%>/res/css/admin/green.css" rel="stylesheet">

<style>
	.row{
	margin-left:15%;
	}
	.tabs-left>li>a {
    background: rgba(70, 165, 146, 0.16);
    }
</style>

<script type="text/javascript">

$(function(){
	var firstEventNo = ${firstEventNo};
	loadList(firstEventNo);
});

function loadList(eventNo) {
  	var url="<%=cp%>/account/loadList/${url}";
  	
  	$.post(url, {eventNo:eventNo}, function(data){
  		$("#memberList").html(data);
  		
  		$("input[type=checkbox]").addClass("switchery");
	});	
}

function check() {
    var f = document.addForm;
    f.action="<%=cp%>/account/addFee/${url}";
    return true;
}

</script>
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
					<li class="active"><a onclick="loadList('${dto.eventNo}');" style="cursor:pointer;" 
					data-toggle="tab">${dto.eventName}</a></li>
					</c:if>
					<c:if test="${dto.num!=1}">
					<li><a onclick="loadList('${dto.eventNo}');" style="cursor:pointer;" data-toggle="tab">${dto.eventName}</a></li>
					</c:if>
					</c:forEach>
				</ul>
			</div>
			<div class="col-xs-9">
				<div id="memberList"></div>
			</div>

			<div class="clearfix"></div>

		</div>
	</div>
</div>
			
