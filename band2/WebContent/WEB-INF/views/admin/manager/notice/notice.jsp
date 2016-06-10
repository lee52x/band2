<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<!-- bootstrap-wysiwyg -->
<link href="<%=cp%>/res/css/communityManager/prettify.min.css" rel="stylesheet">
<link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">

<script type="text/javascript">
var tabs=1;

$(function(){
	listPage(1);	
});

function listPage(page) {
    url="<%=cp%>/manager/notice/list/${url}";

	var params="pageNo="+page;
	$.ajax({
		type:"post"
		,url:url
		,data:params
		,success:function(data) {
			var id="#tab_content"+tabs;
			$(id).html(data);
		}
	    ,error:function(e) {
	    	alert(e.responseText);
	    }
	});

}

$(function(){
	$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
		tabs=$(this).attr("aria-controls");
		
		$("[id^=tabContent]").each(function(){
			// $(this).html(""); // 전체를 출력하는 부분과 카테고리별 출력하는부분의 id가 같으므로 기존 정보 지움
		});
		
		if(tabs=="1") {
			listPage(1);
		}
		
		if(tabs=="3"){
			
		}
		
	});	
});


function createCheck() {
    var f = document.noticeForm;

	str = f.content.value;
    if(!str) {
        f.content.focus();
        return false;
    }
    
	var str = f.noticeDate.value;
    if(!str) {
        f.noticeDate.focus();
        return false;
    }
  
	f.action="<%=cp%>/manager/notice/created/${url}";
	
    return true;
}

function createCheck2() {
    var f = document.noticeForm;

	str = f.content.value;
    if(!str) {
        f.content.focus();
        return false;
    }
    
	var str = f.noticeDate.value;
    if(!str) {
        f.noticeDate.focus();
        return false;
    }
  
	f.action="<%=cp%>/manager/notice/update/${url}";
	
    return true;
}


function noticeModal(noticeNo, content, endDate) {	
	$("#modalNoticeNo").val(noticeNo);	
	$("#modalContent").val(content);
	$("#modalEndDate").val(endDate);
	$("#noticeModal").modal("show");
}

function updateNotice() {
	var content = $.trim($("#modalContent").val());
	var noticeNo = $("#modalNoticeNo").val();
	var endDate = $.trim($("#modalEndDate").val());
	
	var params = "content=" + content
		+ "&endDate=" + endDate
		+ "&noticeNo=" + noticeNo;
	
	var url = "<%=cp%>/manager/notice/update/${url}";
	
	if(confirm("해당 공지를 수정하시겠습니까?")) {
		$.ajax({
			type:"POST"
			,url:url
			,data:params
			,dataType:"json"
			,success:function(data) {
				location.href="<%=cp%>/manager/notice/notice/${url}";
			}
			,error:function(e) {
				
			}
		});		
	}
	$("#memberModal").modal("hide");
}

function deleteNotice() {
    var n = $("#modalNoticeNo").val();
    
    if(confirm("해당 공지를 삭제하시겠습니까 ? ")) {
    	/*
  	    $.post("<%=cp%>/manager/notice/delete/${url}", {noticeNo:n}, function(data) {
  	    	location.href="<%=cp%>/manager/notice/notice/${url}";
  	    }, "json");
    	*/
    	
		$.ajax({
			type:"POST"
			,url:"<%=cp%>/manager/notice/delete/${url}"
			,data:"noticeNo="+n
			,dataType:"json"
			,success:function(data) {
				location.href="<%=cp%>/manager/notice/notice/${url}";
			}
			,error:function(e) {
				alert(e.responseText);
			}
		});		    	
    }
    $("#memberModal").modal("hide");
}


</script>



	<div class="x_panel">
		<div class="x_title">
			<h2>
				<i class="fa fa-bars"></i> Tabs <small>Float left</small>
			</h2>
			<div class="clearfix"></div>
		</div>
		<div class="x_content">
			<div class="" role="tabpanel" data-example-id="togglable-tabs">
				<ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
					<li role="presentation" class="active"><a href="#tab_content1"
						id="home-tab" role="tab" aria-controls="1" data-toggle="tab" aria-expanded="true">공지사항</a>
					</li>
					<li role="presentation" class=""><a href="#tab_content2"
						role="tab" id="profile-tab"  aria-controls="2" data-toggle="tab"
						aria-expanded="false">공지사항 등록</a></li>
				</ul>
				<div id="myTabContent" class="tab-content">
					<!-- 첫번째 탭 -->
					<div role="tabpanel" class="tab-pane fade active in"
						id="tab_content1" aria-labelledby="home-tab">
						
					</div>


					<!-- 두번째 탭 -->
					<div role="tabpanel" class="tab-pane fade" id="tab_content2"
						aria-labelledby="profile-tab">

						<!-- 공지사항 등록 폼 -->
						<form class="form-horizontal" name="noticeForm" method="post" onsubmit="return createCheck()">
							<div class="form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12">공지사항 게시기간</label>
								<div class="col-md-9 col-sm-9 col-xs-12">
									<fieldset>
										<div class="control-group">
											<div class="controls">
												<div class="input-prepend input-group">
													<span class="add-on input-group-addon"> <i
														class="glyphicon glyphicon-calendar fa fa-calendar"></i>
													</span> <input type="text" style="width: 200px" name="noticeDate"
														id="reservation" class="form-control"
														value="${today}-${today}"/>
												</div>
											</div>
										</div>
									</fieldset>
								</div>

								<label class="control-label col-md-3 col-sm-3 col-xs-12">공지사항 내용</label>
								<div class="col-md-9 col-sm-9 col-xs-12">
									<textarea class="resizable_textarea form-control" id="content" name="content" required="required"></textarea>
								</div>
							</div>

							<div class="form-group">
								<div class="col-md-6 col-md-offset-3">
									<button type="button" class="btn btn-primary">등록취소</button>
									<button id="send" type="submit" class="btn btn-success">등록완료</button>
								</div>
							</div>
						</form>
						<!-- 공지사항 등록 폼 끝-->
					</div>
					<!-- 두번째 탭 끝-->

				</div>
			</div>

		</div>
	</div>
<!-- /page content -->

					


<!-- bootstrap-daterangepicker -->
<script src="<%=cp%>/res/js/moment.min.js"></script>
<script src="<%=cp%>/res/js/daterangepicker.js"></script>

<!-- Autosize -->
<script src="<%=cp%>/res/js/communityManager/autosize.js"></script>

<!-- 회원상세정보 모달 -->
<script src="<%=cp%>/res/js/jquery.bootstrap.wizard.js"
	type="text/javascript"></script>
<script src="<%=cp%>/res/js/wizard.js"></script>
<!-- 회원상세정보 모달 -->

<!-- bootstrap-daterangepicker -->
<script>
	$(document)
			.ready(
					function() {
						var cb = function(start, end, label) {
							console.log(start.toISOString(), end.toISOString(),
									label);
							$('#reportrange_right span').html(
									start.format('MMMM D, YYYY') + ' - '
											+ end.format('MMMM D, YYYY'));
						};

						var optionSet1 = {
							startDate : moment().subtract(29, 'days'),
							endDate : moment(),
							minDate : '01/01/2012',
							maxDate : '12/31/2015',
							dateLimit : {
								days : 60
							},
							showDropdowns : true,
							showWeekNumbers : true,
							timePicker : false,
							timePickerIncrement : 1,
							timePicker12Hour : true,
							ranges : {
								'Today' : [ moment(), moment() ],
								'Yesterday' : [ moment().subtract(1, 'days'),
										moment().subtract(1, 'days') ],
								'Last 7 Days' : [ moment().subtract(6, 'days'),
										moment() ],
								'Last 30 Days' : [
										moment().subtract(29, 'days'), moment() ],
								'This Month' : [ moment().startOf('month'),
										moment().endOf('month') ],
								'Last Month' : [
										moment().subtract(1, 'month').startOf(
												'month'),
										moment().subtract(1, 'month').endOf(
												'month') ]
							},
							opens : 'right',
							buttonClasses : [ 'btn btn-default' ],
							applyClass : 'btn-small btn-primary',
							cancelClass : 'btn-small',
							format : 'MM/DD/YYYY',
							separator : ' to ',
							locale : {
								applyLabel : 'Submit',
								cancelLabel : 'Clear',
								fromLabel : 'From',
								toLabel : 'To',
								customRangeLabel : 'Custom',
								daysOfWeek : [ 'Su', 'Mo', 'Tu', 'We', 'Th',
										'Fr', 'Sa' ],
								monthNames : [ 'January', 'February', 'March',
										'April', 'May', 'June', 'July',
										'August', 'September', 'October',
										'November', 'December' ],
								firstDay : 1
							}
						};

						$('#reportrange_right span').html(
								moment().subtract(29, 'days').format(
										'MMMM D, YYYY')
										+ ' - '
										+ moment().format('MMMM D, YYYY'));

						$('#reportrange_right').daterangepicker(optionSet1, cb);

						$('#reportrange_right').on('show.daterangepicker',
								function() {
									console.log("show event fired");
								});
						$('#reportrange_right').on('hide.daterangepicker',
								function() {
									console.log("hide event fired");
								});
						$('#reportrange_right')
								.on(
										'apply.daterangepicker',
										function(ev, picker) {
											console
													.log("apply event fired, start/end dates are "
															+ picker.startDate
																	.format('MMMM D, YYYY')
															+ " to "
															+ picker.endDate
																	.format('MMMM D, YYYY'));
										});
						$('#reportrange_right').on('cancel.daterangepicker',
								function(ev, picker) {
									console.log("cancel event fired");
								});

						$('#options1').click(
								function() {
									$('#reportrange_right').data(
											'daterangepicker').setOptions(
											optionSet1, cb);
								});

						$('#options2').click(
								function() {
									$('#reportrange_right').data(
											'daterangepicker').setOptions(
											optionSet2, cb);
								});

						$('#destroy').click(
								function() {
									$('#reportrange_right').data(
											'daterangepicker').remove();
								});

					});
</script>

<script>
	$(document)
			.ready(
					function() {
						var cb = function(start, end, label) {
							console.log(start.toISOString(), end.toISOString(),
									label);
							$('#reportrange span').html(
									start.format('MMMM D, YYYY') + ' - '
											+ end.format('MMMM D, YYYY'));
						};

						var optionSet1 = {
							startDate : moment().subtract(29, 'days'),
							endDate : moment(),
							minDate : '01/01/2012',
							maxDate : '12/31/2015',
							dateLimit : {
								days : 60
							},
							showDropdowns : true,
							showWeekNumbers : true,
							timePicker : false,
							timePickerIncrement : 1,
							timePicker12Hour : true,
							ranges : {
								'Today' : [ moment(), moment() ],
								'Yesterday' : [ moment().subtract(1, 'days'),
										moment().subtract(1, 'days') ],
								'Last 7 Days' : [ moment().subtract(6, 'days'),
										moment() ],
								'Last 30 Days' : [
										moment().subtract(29, 'days'), moment() ],
								'This Month' : [ moment().startOf('month'),
										moment().endOf('month') ],
								'Last Month' : [
										moment().subtract(1, 'month').startOf(
												'month'),
										moment().subtract(1, 'month').endOf(
												'month') ]
							},
							opens : 'left',
							buttonClasses : [ 'btn btn-default' ],
							applyClass : 'btn-small btn-primary',
							cancelClass : 'btn-small',
							format : 'MM/DD/YYYY',
							separator : ' to ',
							locale : {
								applyLabel : 'Submit',
								cancelLabel : 'Clear',
								fromLabel : 'From',
								toLabel : 'To',
								customRangeLabel : 'Custom',
								daysOfWeek : [ 'Su', 'Mo', 'Tu', 'We', 'Th',
										'Fr', 'Sa' ],
								monthNames : [ 'January', 'February', 'March',
										'April', 'May', 'June', 'July',
										'August', 'September', 'October',
										'November', 'December' ],
								firstDay : 1
							}
						};
						$('#reportrange span').html(
								moment().subtract(29, 'days').format(
										'MMMM D, YYYY')
										+ ' - '
										+ moment().format('MMMM D, YYYY'));
						$('#reportrange').daterangepicker(optionSet1, cb);
						$('#reportrange').on('show.daterangepicker',
								function() {
									console.log("show event fired");
								});
						$('#reportrange').on('hide.daterangepicker',
								function() {
									console.log("hide event fired");
								});
						$('#reportrange')
								.on(
										'apply.daterangepicker',
										function(ev, picker) {
											console
													.log("apply event fired, start/end dates are "
															+ picker.startDate
																	.format('MMMM D, YYYY')
															+ " to "
															+ picker.endDate
																	.format('MMMM D, YYYY'));
										});
						$('#reportrange').on('cancel.daterangepicker',
								function(ev, picker) {
									console.log("cancel event fired");
								});
						$('#options1').click(
								function() {
									$('#reportrange').data('daterangepicker')
											.setOptions(optionSet1, cb);
								});
						$('#options2').click(
								function() {
									$('#reportrange').data('daterangepicker')
											.setOptions(optionSet2, cb);
								});
						$('#destroy').click(function() {
							$('#reportrange').data('daterangepicker').remove();
						});
					});
</script>

<script>
	$(document).ready(function() {
		$('#single_cal1').daterangepicker({
			singleDatePicker : true,
			calender_style : "picker_1"
		}, function(start, end, label) {
			console.log(start.toISOString(), end.toISOString(), label);
		});
		$('#single_cal2').daterangepicker({
			singleDatePicker : true,
			calender_style : "picker_2"
		}, function(start, end, label) {
			console.log(start.toISOString(), end.toISOString(), label);
		});
		$('#single_cal3').daterangepicker({
			singleDatePicker : true,
			calender_style : "picker_3"
		}, function(start, end, label) {
			console.log(start.toISOString(), end.toISOString(), label);
		});
		$('#single_cal4').daterangepicker({
			singleDatePicker : true,
			calender_style : "picker_4"
		}, function(start, end, label) {
			console.log(start.toISOString(), end.toISOString(), label);
		});
	});
</script>

<script>
	$(document).ready(function() {
		$('#reservation').daterangepicker(null, function(start, end, label) {
			console.log(start.toISOString(), end.toISOString(), label);
		});
	});
</script>
<!-- /bootstrap-daterangepicker -->

<!-- Autosize -->
<script>
	$(document).ready(function() {
		autosize($('.resizable_textarea'));
	});
</script>
<!-- /Autosize -->
