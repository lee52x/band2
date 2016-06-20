	<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<!-- Datatables -->
<link href="<%=cp%>/res/css/admin/dataTables.bootstrap.min.css" rel="stylesheet">
<link href="<%=cp%>/res/css/admin/buttons.bootstrap.min.css" rel="stylesheet">
<link href="<%=cp%>/res/css/admin/fixedHeader.bootstrap.min.css" rel="stylesheet">
<link href="<%=cp%>/res/css/admin/responsive.bootstrap.min.css" rel="stylesheet">
<link href="<%=cp%>/res/css/admin/scroller.bootstrap.min.css" rel="stylesheet">
<link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">

<div class="col-md-12 col-sm-12 col-xs-12">
	<div class="x_panel">
		<!-- 회의록 패널 제목 시작 -->
		<div class="x_title">
			<h2>
				<i class="fa fa-bars"></i> 회의록
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
		<!-- 회의록 패널 제목 끝 -->

		<div class="x_content">
			<div class="" role="tabpanel" data-example-id="togglable-tabs">
				<!-- 탭 이름 시작 -->
				<ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
					<li role="presentation" class="active">
						<a href="#tab_content1"	id="membertab" role="tab" data-toggle="tab" aria-expanded="true">회의록 리스트</a></li>					
					<li role="presentation" class="active2">
						<a href="#tab_content2" id="profiletab" role="tab"  data-toggle="tab" aria-expanded="false">회의록 작성</a></li>
				</ul>
				<!-- 탭 이름 끝 -->
				
				<div id="myTabContent" class="tab-content">
					<div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="membertab">
						<div class="row">
		<div class="col-md-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>
						회의록 <small> 우리 모임 회의록 </small>
					</h2>
					<ul class="nav navbar-right panel_toolbox">
						<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
						</li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false"><i
								class="fa fa-wrenc	h"></i></a>
							<ul class="dropdown-menu" role="menu">
								<li><a href="#">Settings 1</a></li>
								<li><a href="#">Settings 2</a></li>
							</ul></li>
						<li><a class="close-link"><i class="fa fa-close"></i></a></li>
					</ul>
					<div class="clearfix"></div>
				</div>
				<div class="x_content">
					<div class="row">						
						<div class="col-md-55">
							<div class="thumbnail">
								<div class="image view view-first">
									<img style="width: 100%; display: block;" src="<%=cp%>/res/img/4.jpg"
										alt="image" />
									<div class="mask">
										<p>2016/05/12</p>
										<div class="tools tools-bottom">
											<a href="#"><i class="fa fa-link"></i></a> <a href="#"><i
												class="fa fa-pencil"></i></a> <a href="#"><i
												class="fa fa-times"></i></a>
										</div>
									</div>
								</div>
								<div class="caption">
									<p>재미없는 회의</p>
								</div>
							</div>
						</div>
						<div class="col-md-55">
							<div class="thumbnail">
								<div class="image view view-first">
									<img style="width: 100%; display: block;" src="<%=cp%>/res/img/8.jpg"
										alt="image" />
									<div class="mask">
										<p>Your Text</p>
										<div class="tools tools-bottom">
											<a href="#"><i class="fa fa-link"></i></a> <a href="#"><i
												class="fa fa-pencil"></i></a> <a href="#"><i
												class="fa fa-times"></i></a>
										</div>
									</div>
								</div>
								<div class="caption">
									<p>독서토론회 1월 모임</p>
								</div>
							</div>
						</div>
						<div class="col-md-55">
							<div class="thumbnail">
								<div class="image view view-first">
									<img style="width: 100%; display: block;" src="<%=cp%>/res/img/1.jpg"
										alt="image" />
									<div class="mask">
										<p>Your Text</p>
										<div class="tools tools-bottom">
											<a href="#"><i class="fa fa-link"></i></a> <a href="#"><i
												class="fa fa-pencil"></i></a> <a href="#"><i
												class="fa fa-times"></i></a>
										</div>
									</div>
								</div>
								<div class="caption">
									<p>Web 세미나</p>
								</div>
							</div>
						</div>
						<div class="col-md-55">
							<div class="thumbnail">
								<div class="image view view-first">
									<img style="width: 100%; display: block;" src="<%=cp%>/res/img/3.jpg"
										alt="image" />
									<div class="mask">
										<p>Your Text</p>
										<div class="tools tools-bottom">
											<a href="#"><i class="fa fa-link"></i></a> <a href="#"><i
												class="fa fa-pencil"></i></a> <a href="#"><i
												class="fa fa-times"></i></a>
										</div>
									</div>
								</div>
								<div class="caption">
									<p>정기회의(6월4주)</p>
								</div>
							</div>
						</div>
						<div class="col-md-55">
							<div class="thumbnail">
								<div class="image view view-first">
									<img style="width: 100%; display: block;" src="<%=cp%>/res/img/9.jpg"
										alt="image" />
									<div class="mask">
										<p>Your Text</p>
										<div class="tools tools-bottom">
											<a href="#"><i class="fa fa-link"></i></a> <a href="#"><i
												class="fa fa-pencil"></i></a> <a href="#"><i
												class="fa fa-times"></i></a>
										</div>
									</div>
								</div>
								<div class="caption">
									<p>정기회의(6월2주)</p>
								</div>
							</div>
						</div>


						<div class="col-md-55">
							<div class="thumbnail">
								<div class="image view view-first">
									<img style="width: 100%; display: block;" src="<%=cp%>/res/img/5.jpg"
										alt="image" />
									<div class="mask no-caption">
										<div class="tools tools-bottom">
											<a href="#"><i class="fa fa-link"></i></a> <a href="#"><i
												class="fa fa-pencil"></i></a> <a href="#"><i
												class="fa fa-times"></i></a>
										</div>
									</div>
								</div>
								<div class="caption">									
									<p>잔디밭 저녁 나들이</p>
								</div>
							</div>
						</div>
						<div class="col-md-55">
							<div class="thumbnail">
								<div class="image view view-first">
									<img style="width: 100%; display: block;" src="<%=cp%>/res/img/6.jpg"
										alt="image" />
									<div class="mask no-caption">
										<div class="tools tools-bottom">
											<a href="#"><i class="fa fa-link"></i></a> <a href="#"><i
												class="fa fa-pencil"></i></a> <a href="#"><i
												class="fa fa-times"></i></a>
										</div>
									</div>
								</div>
								<div class="caption">								
									<p>	여름MT</p>
								</div>
							</div>
						</div>
						<div class="col-md-55">
							<div class="thumbnail">
								<div class="image view view-first">
									<img style="width: 100%; display: block;" src="<%=cp%>/res/img/7.jpg"
										alt="image" />
									<div class="mask no-caption">
										<div class="tools tools-bottom">
											<a href="#"><i class="fa fa-link"></i></a> <a href="#"><i
												class="fa fa-pencil"></i></a> <a href="#"><i
												class="fa fa-times"></i></a>
										</div>
									</div>
								</div>
								<div class="caption">
									<p>	첫번째 특별 모임</p>
								</div>
							</div>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
					</div>														
										
					<div role="tabpanel" class="tab-pane fade" id="tab_content2"
						aria-labelledby="profiletab">
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_title">
									<h2>
										회의록 작성 <small>회의록 작성폼</small>
									</h2>
									<ul class="nav navbar-right panel_toolbox">
										<li><a class="collapse-link"><i
												class="fa fa-chevron-up"></i></a></li>
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
									<form id="demo-form2" data-parsley-validate
										class="form-horizontal form-label-left">
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="date">일시 <span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input type="date" id="date" class="date-picker form-control col-md-7 col-xs-12" required="required" >
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="place">장소
											</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input type="text" id="place" class="form-control col-md-7 col-xs-12">
											</div>
										</div>										
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12" for="attendee">참석자 <span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input type="text" id="attendee" required="required" class="form-control col-md-7 col-xs-12">
											</div>
										</div>										
										<div class="form-group">
											<label for="subject" class="control-label col-md-3 col-sm-3 col-xs-12">주제 <span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input type="text" id="subject" class="form-control col-md-7 col-xs-12">
											</div>
										</div>
										<div class="form-group">
											<label for="contents" class="control-label col-md-3 col-sm-3 col-xs-12">상세내용 <span class="required">*</span>
											</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<textarea id="contents" class="form-control" rows="15"></textarea>
											</div>
										</div>										
										<div class="form-group">
											<label for="note" class="control-label col-md-3 col-sm-3 col-xs-12">비고</label>
											<div class="col-md-6 col-sm-6 col-xs-12">
												<input type="text" id="note" class="form-control col-md-7 col-xs-12">
											</div>
										</div>
										<div class="ln_solid"></div>
										<div class="form-group">
											<div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
												<button type="reset" class="btn btn-primary">다시작성</button>
												<button type="submit" class="btn btn-success">작성완료</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="clearfix"></div>

<!-- jQuery -->
<script src="<%=cp%>/res/js/admin/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="<%=cp%>/res/js/admin/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="<%=cp%>/res/js/admin/fastclick.js"></script>
<!-- NProgress -->
<script src="<%=cp%>/res/js/admin/nprogress.js"></script>
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