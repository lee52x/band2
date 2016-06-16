<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<!-- 회원정보목록 탭(109 line),  회원등록 탭(186 line),  모달(281 line) -->

<!-- Datatables -->
<link href="<%=cp%>/res/css/admin/dataTables.bootstrap.min.css"
	rel="stylesheet">
<link href="<%=cp%>/res/css/admin/buttons.bootstrap.min.css"
	rel="stylesheet">
<link href="<%=cp%>/res/css/admin/fixedHeader.bootstrap.min.css"
	rel="stylesheet">
<link href="<%=cp%>/res/css/admin/responsive.bootstrap.min.css"
	rel="stylesheet">
<link href="<%=cp%>/res/css/admin/scroller.bootstrap.min.css"
	rel="stylesheet">

<link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">

<script type="text/javascript">
function memberModal(memberNo, name, userId, gender, birth, address, email, tel, joinDate, grade) {	
	$("#modalMemberNo").text(memberNo);
	$("#hiddenMemberNo").val(memberNo);	
	$("#modalName").text(name);
	$("#modalRename").val(name);
	if(userId == "") {
		$("#modalUserId").text("커뮤니티 미가입"); 				
	} else {
		$("#modalUserId").text(userId);
	}	
		
	if(gender == 1) {
		$("#modalHeaderGender").text("남성")
	} else {		
		$("#modalHeaderGender").text("여성")
	}
	
	$("#modalBirth").val(birth);
	$("#modalAddress").val(address);
	$("#modalEmail").val(email);
	$("#modalTel").val(tel);
	$("#modalJoinDate").val(joinDate);	
			
	switch(grade) {
		case '1':
			$("#modalHeaderGrade").text("그룹장");
			break;
		case '2':
			$("#modalHeaderGrade").text("운영진");
			break;
		case '3':
			$("#modalHeaderGrade").text("일반회원");
			break;
		case '4':
			$("#modalHeaderGrade").text("OB회원");
			break;
		case '5':
			$("#modalHeaderGrade").text("비활동회원");
			break;
		default:
			$("#modalHeaderGrade").text("일반회원");
			break;	
	}	
	$("#memberModal").modal("show");
}

function updateMember() {
	var name = $.trim($("#modalRename").val());
	var email = $.trim($("#modalEmail").val());
	var birth = $.trim($("#modalBirth").val());
	var tel = $.trim($("#modalTel").val());
	var address = $("#modalAddress").val();
	var joinDate = $.trim($("#modalJoinDate").val());
	var grade = $("input[name='mgrade']:checked").attr("value");
	var gender = $("input[name='mgender']:checked").attr("value");
	
	var memberNo = $("#hiddenMemberNo").val();
	
	var params = "name=" + name
		+ "&email=" + email
		+ "&birth=" + birth
		+ "&tel=" + tel
		+ "&address=" + address
		+ "&joinDate=" + joinDate
		+ "&grade=" + grade
		+ "&gender=" + gender
		+ "&memberNo=" + memberNo; 
	
	var url = "<%=cp%>/admin/member/update/${url}";
	
	if(confirm("해당 자료를 수정하시겠습니까?")) {
		$.ajax({
			type:"POST"
			,url:url
			,data:params
			,dataType:"json"
			,success:function(data) {
				location.href="<%=cp%>/admin/member/member/${url}";
			}
			,error:function(e) {
				
			}
		});		
	}
	$("#memberModal").modal("hide");
}

function deleteMember() {
    var n = $("#hiddenMemberNo").val();
    if(confirm("해당 자료를 삭제하시겠습니까 ? ")) {
  	    $.post("<%=cp%>/admin/member/delete/${url}", {memberNo:n}, function(data) {
  	    	location.href="<%=cp%>/admin/member/member/${url}";
  	    }, "json");    
    }
    $("#memberModal").modal("hide");
}

</script>

<div class="col-md-12 col-sm-12 col-xs-12">
	<div class="x_panel">
		<!-- 회원관리 패널 제목 시작 -->
		<div class="x_title">
			<h2>
				<i class="fa fa-bars"></i> <small style="font-weight: bold;">회원관리</small>
			</h2>
			<ul class="nav navbar-right panel_toolbox">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false"><i
						class="fa fa-wrench"></i></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">Settings 1</a></li>
						<li><a href="#">Settings 2</a></li>
					</ul></li>
				<li><a class="close-link"><i class="fa fa-file-excel-o"></i></a></li>
				<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
			</ul>
			<div class="clearfix"></div>
		</div>
		<!-- 회원관리 패널 제목 끝 -->

		<div class="x_content">

			<div class="" role="tabpanel" data-example-id="togglable-tabs">
				<!-- 탭 이름 시작 -->
				<ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
					<li role="presentation" class="active"><a href="#tab_content1"
						id="membertab" role="tab" data-toggle="tab" aria-expanded="true">회원정보	목록</a></li>
					<li role="presentation" class="active2"><a
						href="#tab_content2" id="profiletab" role="tab" data-toggle="tab"
						aria-expanded="false">회원 등록</a></li>
				</ul>
				<!-- 탭 이름 끝 -->

				<div id="myTabContent" class="tab-content">
					<!-- 회원정보 목록 탭 시작  -->
					<div role="tabpanel" class="tab-pane fade active in"
						id="tab_content1" aria-labelledby="membertab">
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2><small style="font-weight: bold;">회원 리스트</small></h2>
									<ul class="nav navbar-right panel_toolbox">
										<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
										<li class="dropdown"><a href="#" class="dropdown-toggle"
											data-toggle="dropdown" role="button" aria-expanded="false">
												<i class="fa fa-wrench"></i>
										</a>
											<ul class="dropdown-menu" role="menu">
												<li><a href="#">Settings 1</a></li>
												<li><a href="#">Settings 2</a></li>
											</ul></li>
										<li><a class="close-link"><i class="fa fa-close"></i></a></li>
									</ul>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<table id="datatable"
										class="table table-striped table-bordered">
										<thead>
											<tr>
												<th style="width:30px;">번호</th>
												<th>이름</th>
												<th>아이디</th>
												<th>성별</th>
												<th>생년월일</th>
												<th>주소</th>
												<th>이메일</th>
												<th>전화번호</th>
												<th>가입일</th>
												<th>회원등급</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="dto" items="${list}">
												<tr>
													<td>${dto.memberNo}</td>													
													<td><a href="javascript:memberModal('${dto.memberNo}', '${dto.name}', '${dto.userId}', '${dto.gender}','${dto.birth}', '${dto.address}',
												 										'${dto.email}', '${dto.tel}', '${dto.joinDate}', '${dto.grade}');"
														data-toggle="modal" style="font-weight: bold;">
														<span style="text-decoration: underline;">${dto.name}</span></a></td>
													<td>${dto.userId}</td>
													<td><c:choose>
															<c:when test="${dto.gender == 1}">남성</c:when>
															<c:otherwise>여성</c:otherwise>
														</c:choose></td>
													<td>${dto.birth}</td>
													<td>${dto.address}</td>
													<td>${dto.email}</td>
													<td>${dto.tel}</td>
													<td>${dto.joinDate}</td>
													<td><c:choose>
															<c:when test="${dto.grade == 1}"><div class="btn btn-danger btn-xs">그룹장</div></c:when>
															<c:when test="${dto.grade == 2}"><div class="btn btn-warning btn-xs">운영진</div></c:when>
															<c:when test="${dto.grade == 3}"><div class="btn btn-info btn-xs">일　반</div></c:when>
															<c:when test="${dto.grade == 4}"><div class="btn btn-success btn-xs">O　&nbsp;&nbsp;B</div></c:when>
															<c:when test="${dto.grade == 5}"><div class="btn btn-default btn-xs">미가입</div></c:when>
														</c:choose>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<!-- 회원정보 목록 탭 끝  -->

					<!-- 회원등록 탭 시작 -->
					<div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="profiletab">
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2><small style="font-weight: bold;">회원 등록</small></h2>
									<div class="clearfix"></div>
								</div>
								<div class="x_content">
									<form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left" method="post">
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="name">이름 <span class="required">*</span></label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input type="text" id="name" name="name" required="required"
													class="form-control col-md-7 col-xs-12" autofocus="autofocus">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="birth">생년월일</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input type="date" id="birth" name="birth" class="date-picker form-control col-md-7 col-xs-12">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="address">주소</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input type="text" id="address" name="address" class="form-control col-md-7 col-xs-12">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12">성별</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<div id="gender" class="btn-group" data-toggle="buttons">
													<label class="btn btn-default" data-toggle-class="btn-primary"
														data-toggle-passive-class="btn-default">
														<input type="radio" name="gender" value="1" checked="checked"> &nbsp; 남성 &nbsp;
													</label> <label class="btn btn-primary" data-toggle-class="btn-primary"
														data-toggle-passive-class="btn-default">
														<input type="radio" name="gender" value="2"> &nbsp; 여성 &nbsp;
													</label>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label for="email" class="control-label col-md-3 col-sm-3 col-xs-12">이메일</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input type="email" id="email" name="email" class="form-control col-md-7 col-xs-12">
											</div>
										</div>
										<div class="form-group">
											<label for="tel" class="control-label col-md-3 col-sm-3 col-xs-12">전화번호</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input type="text" id="tel" name="tel" class="form-control col-md-7 col-xs-12">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="joindate">모임가입일</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input type="date" id="joinDate" name="joinDate" class="date-picker form-control col-md-7 col-xs-12">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12">회원등급</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<label class="btn btn-default">
												 <input type="radio" name="grade" value="3" checked="checked"> 일반회원
												</label>
												<label class="btn btn-default">
												 <input type="radio" name="grade" value="2"> 운영진
												</label> <label class="btn btn-default">
												 <input type="radio" name="grade" value="4"> OB회원
												</label> <label class="btn btn-default">
												 <input type="radio" name="grade" value="5"> 비활동회원
												</label>
											</div>
										</div>
										<div class="ln_solid"></div>
										<div class="form-group">
											<div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
												
												<button type="submit" class="btn btn-success btn-sm"
													onclick="javascript:location.href='<%=cp%>/admin/member/member/{url}';">작성완료</button>
												<button type="reset" class="btn btn-default btn-sm">다시작성</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
					<!-- 회원등록 탭  끝 -->

					<!-- 회원 상세정보 모달 시작 -->
					<div class="modal fade bs-example-modal-lg" id="memberModal"
						tabindex="-1" role="dialog" aria-hidden="true">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">×</span>
									</button>
									<h4 class="modal-title" id="myModalLabel">상세 회원 정보</h4>
								</div>
								<div class="modal-body">
									<form class="form-horizontal form-label-left input_mask">
										<div class="x_content">
											<div class="flex">
												<ul class="list-inline count2">
													<li><h1 id="modalMemberNo"></h1> <span>회원번호</span></li>
													<li><h1 id="modalName" style="color:#334e7e ;"></h1><span>이름</span></li>
													<li><h1 id="modalUserId"></h1> <span>아이디</span></li>
													<li><h1 id="modalHeaderGender"></h1> <span>성별</span></li>
													<li><h1 id="modalHeaderGrade"></h1> <span>회원등급</span></li>
												</ul>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12">이름:</label>
											<div class="col-md-6 col-sm-9 col-xs-12">
												<input id="modalRename" type="text" class="form-control">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12">생년월일:</label>
											<div class="col-md-6 col-sm-9 col-xs-12">
												<input id="modalBirth" type="date" class="form-control">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12">주소:</label>
											<div class="col-md-6 col-sm-9 col-xs-12">
												<input id="modalAddress" type="text" class="form-control">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12">이메일:</label>
											<div class="col-md-6 col-sm-9 col-xs-12">
												<input id="modalEmail" type="email" class="form-control">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12">전화번호:</label>
											<div class="col-md-6 col-sm-9 col-xs-12">
												<input id="modalTel" type="text" class="form-control">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12">가입일:</label>
											<div class="col-md-6 col-sm-9 col-xs-12">
												<input id="modalJoinDate" type="date" class="form-control">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12">성별</label>
											<div class="col-md-6 col-sm-9 col-xs-12">
												<div id="modalGender" class="btn-group"	data-toggle="buttons">
													<label class="btn btn-default" data-toggle-class="btn-primary"
														data-toggle-passive-class="btn-default">
														<input type="radio" name="mgender" value="1" checked="checked"> &nbsp; 남성 &nbsp;
													</label> <label class="btn btn-primary" data-toggle-class="btn-primary"
														data-toggle-passive-class="btn-default">
														<input type="radio" name="mgender" value="2"> &nbsp; 여성 &nbsp;
													</label>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12">회원등급:</label>
											<div id="modalGrade" class="col-md-9 col-sm-9 col-xs-12">
												<label class="btn btn-default">
												 <input type="radio" name="mgrade" value="3" checked="checked"> 일반회원
												</label>
												<label class="btn btn-default">
												 <input type="radio" name="mgrade" value="2"> 운영진
												</label>
												<label class="btn btn-default">
												 <input type="radio" name="mgrade" value="4"> OB회원
												</label>
												<label class="btn btn-default">
												 <input type="radio" name="mgrade" value="5"> 비활동회원
												</label>
											</div>
										</div>
										<input type="hidden" name="memberNo" id="hiddenMemberNo">
									</form>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default btn-sm" onclick="deleteMember()">삭제하기</button>
									<button type="button" class="btn btn-default btn-sm" onclick="updateMember()">수정하기</button>
								</div>
							</div>
						</div>
					</div>
					<!-- 회원 상세정보 모달 끝 -->

				</div>
			</div>
		</div>
	</div>
</div>
<div class="clearfix"></div>

<!-- Datatables -->
<script src="<%=cp%>/res/js/admin/jquery.dataTables.min.js"></script>
<script src="<%=cp%>/res/js/admin/dataTables.bootstrap.min.js"></script>
<script src="<%=cp%>/res/js/admin/dataTables.buttons.min.js"></script>
<script src="<%=cp%>/res/js/admin/buttons.bootstrap.min.js"></script>
<script src="<%=cp%>/res/js/admin/dataTables.fixedHeader.min.js"></script>
<script src="<%=cp%>/res/js/admin/dataTables.keyTable.min.js"></script>
<script src="<%=cp%>/res/js/admin/dataTables.responsive.min.js"></script>
<script src="<%=cp%>/res/js/admin/responsive.bootstrap.js"></script>
<script src="<%=cp%>/res/js/admin/dataTables.scroller.min.js"></script>
<script src="<%=cp%>/res/js/admin/vfs_fonts.js"></script>

<!-- 회원상세정보 모달 -->
<script src="<%=cp%>/res/js/jquery.bootstrap.wizard.js"
	type="text/javascript"></script>
<script src="<%=cp%>/res/js/wizard.js"></script>
<!-- 회원상세정보 모달 -->

<!-- Datatables -->
<script>
$(document).ready(function() {
	var handleDataTableButtons = function() {
		if ($("#datatable-buttons").length) {
			$("#datatable-buttons").DataTable({
				dom: "Bfrtip",
				buttons: [
				{
                  extend: "copy",
                  className: "btn-sm"
                },
                {
                  extend: "csv",
                  className: "btn-sm"
                },
                {
                  extend: "excel",
                  className: "btn-sm"
                },
                {
                  extend: "pdfHtml5",
                  className: "btn-sm"
                },
                {
                  extend: "print",
                  className: "btn-sm"
                },
              ],
              responsive: true
            });
          }
        };

        TableManageButtons = function() {
          "use strict";
          return {
            init: function() {
              handleDataTableButtons();
            }
          };
        }();

        $('#datatable').dataTable();
        $('#datatable-keytable').DataTable({
          keys: true
        });

        $('#datatable-responsive').DataTable();

        $('#datatable-scroller').DataTable({
          ajax: "js/datatables/json/scroller-demo.json",
          deferRender: true,
          scrollY: 380,
          scrollCollapse: true,
          scroller: true
        });

        var table = $('#datatable-fixed-header').DataTable({
          fixedHeader: true
        });

        TableManageButtons.init();
      });
</script>
<!-- /Datatables -->