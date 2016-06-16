<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
    <!-- form  (일정 등록) 출력 관련 css -->
    <link href="<%=cp%>/res/css/schedule/green.css" rel="stylesheet">
    <link href="<%=cp%>/res/css/schedule/prettify.min.css" rel="stylesheet">
    <%-- <link href="<%=cp%>/res/css/schedule/select2.min.css" rel="stylesheet"> --%>
    <%-- <link href="<%=cp%>/res/css/schedule/switchery.min.css" rel="stylesheet"> --%>
    <%-- <link href="<%=cp%>/res/css/schedule/starrr.css" rel="stylesheet"> --%>
    <%-- <link href="<%=cp%>/res/css/schedule/normalize.css" rel="stylesheet"> --%>
    
    <!-- list (일정 조회/ 상세 조회) 출력 관련 css -->
    <link href="<%=cp%>/res/css/admin/dataTables.bootstrap.css" rel="stylesheet">
	<link href="<%=cp%>/res/css/admin/buttons.bootstrap.css" rel="stylesheet">
	<link href="<%=cp%>/res/css/admin/fixedHeader.bootstrap.min.css" rel="stylesheet">
	<link href="<%=cp%>/res/css/admin/responsive.bootstrap.min.css" rel="stylesheet">
	<link href="<%=cp%>/res/css/admin/scroller.bootstrap.min.css" rel="stylesheet">
	
   
    <link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">
    
    <style type="text/css">
    	/* 참석자 리스트 테이블 출력을 위한 css */
		.note-send-listFriend{
			clear:both;
			width:218px;
			height:260px;
			text-align: left;
			padding: 5px 5px 5px 5px;
			overflow: scroll;
			border:1px solid #ccc;
		}
		
		#map { height: 350px; width: 100%; }
		
		    html, body {
		        height: 100%;
		        margin: 0;
		        padding: 0;
		      }
		      #map {
		        height: 100%;
		      }
		.controls {
		  margin-top: 10px;
		  border: 1px solid transparent;
		  border-radius: 2px 0 0 2px;
		  box-sizing: border-box;
		  -moz-box-sizing: border-box;
		  height: 32px;
		  outline: none;
		  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
		}
		
		#pac-input {
		  background-color: #fff;
		  font-family: Roboto;
		  font-size: 15px;
		  font-weight: 300;
		  margin-left: 12px;
		  padding: 0 11px 0 13px;
		  text-overflow: ellipsis;
		  width: 300px;
		}
		
		#pac-input:focus {
		  border-color: #4d90fe;
		}
		
		.pac-container {
		  font-family: Roboto;
		}
		
		#type-selector {
		  color: #fff;
		  background-color: #4d90fe;
		  padding: 5px 11px 0px 11px;
		}
		
		#type-selector label {
		  font-family: Roboto;
		  font-size: 13px;
		  font-weight: 300;
		}
				
    </style>
    
    <style>
      #target {
        width: 345px;
      }
	</style>

    <script type="text/javascript">
 // 친구 목록 가져오기
$(function(){
    	var url = "<%=cp%>/event/listFriend/${url}";
    	// now의 역할 : 계속적인 새로고침에도 전송이 가능하도록 하는 장치
    	var now=new Date();
    	$.post(url,{dumi:now.getTime()},function(data){
        	var s=$.trim(data);
            $('#noteListFriend').html(s);
      });
    });
    
 // 선택 항목 오른쪽으로 보내기 ------------
    $(function(){
    	$("#noteRightMoveButton").click(function(){
    		var str;
    	    var chks = $("#noteListFriend input:checked");
    		var cnt = chks.length;
    		if(cnt==0) {
    			alert("보낼 친구를 먼저 선택하세요...")
    			return;
    		}

    	    $.each(chks, function(e, ch) {
    	        var userId= $(ch).val();
    	        
    	        $.each($("#noteListFriend tr"), function() {
    		        if($(this).attr("data-tid")==userId) {
    		        	str="<tr height='25' data-tid='"+userId+"'>";
    		        	str+=$("#noteListFriend tr[data-tid='"+userId+"']").html();
    		        	str+="</tr>";
    		        	$("#noteListReceive").append(str);
    		        	$("#noteListFriend tr[data-tid='"+userId+"']").remove();
    		        }
    	        });
    	    });
    		
    	});
    });

    // 오른쪽으로 모두 보내기
    $(function(){
    	$("#noteRightAllMoveButton").click(function(){
    		var str, userId;
            $.each($("#noteListFriend tr"), function() {
            	userId=$(this).attr("data-tid");
            	str="<tr height='25' data-tid='"+userId+"'>";
            	str+=$("#noteListFriend tr[data-tid='"+userId+"']").html();
            	str+="</tr>";
            	$("#noteListReceive").append(str);
            	$("#noteListFriend tr[data-tid='"+userId+"']").remove();
            });
    	});
    });

    // 선택 항목 왼쪽으로 보내기 ------------
    $(function(){
    	$("#noteLeftMoveButton").click(function(){
    		var str;
    	    var chks = $("#noteListReceive input:checked");
    		var cnt = chks.length;
    		if(cnt==0) {
    			alert("보내기를 해제할 친구를 먼저 선택하세요...")
    			return false;
    		}
    		
    	    $.each(chks, function(e, ch) {
    	        var userId= $(ch).val();
    	        $.each($("#noteListReceive tr"), function() {
    		        if($(this).attr("data-tid")==userId) {
    		        	str="<tr height='25' data-tid='"+userId+"'>";
    		        	str+=$("#noteListReceive tr[data-tid='"+userId+"']").html();
    		        	str+="</tr>";
    		        	$("#noteListFriend").append(str);
    		        	$("#noteListReceive tr[data-tid='"+userId+"']").remove();
    		        }
    	        });
    	    });
    	});
    });

    // 왼쪽으로 모두 보내기 ------------
    $(function(){
    	$("#noteLeftAllMoveButton").click(function(){
    		var str, userId;
            $.each($("#noteListReceive tr"), function() {
            	userId=$(this).attr("data-tid");
            	str="<tr height='25' data-tid='"+userId+"'>";
            	str+=$("#noteListReceive tr[data-tid='"+userId+"']").html();
            	str+="</tr>";
            	$("#noteListFriend").append(str);
            	$("#noteListReceive tr[data-tid='"+userId+"']").remove();
            });
    	});
    });

    
    
    //동적으로 참석자 리스트 보내주기
    function submitEvent(){
    	var f = document.tab_content2;
    	    	
    	var str;
    	$.each($("#noteListReceive tr"), function() {
    		memberNo=$(this).attr("data-tid");
    		str="<input type='hidden' name='memberNos' value='"+memberNo+"'>"
    		$("form[name=tab_content2]").append(str);
        });
    	
    	 f.action="<%=cp%>/event/${url}";
    	 f.submit();
    }
    
    
 // 참석자 리스트 추가하기
    function sendNoteOk() {
    	var chks = $("#noteListReceive input[type=checkbox]");
    	if(chks.length==0) {
    		alert("선택한 참석자가 없습니다.");
    		return;
    	}
    	
    	var url="<%=cp%>/event/insertAttend/${url}";
    	var params="eventNo="+eventNo;
    	$.each($(chks), function() {
    		params += "&memberNos="+$(this).val();
    	});
      	
        $.ajax({
        	type:"POST",
        	url:url,
        	data:params,
        	dataType:"json",
        	success:function(data){
           
        		$("#noteContent").val("");
        		$('#noteLeftAllMoveButton').trigger('click');
        		alert("메시지를 전송 했습니다.");
        	},
        	error:function(e) {
        		alert(e.responseText);
        	}
        });
    }
    
    function eventModal(eventNo, eventName, content, eventPlace, fromDate, toDate, fromTime, toTime, eventType, eventFee) {	
    	$("#modalEventNo").text(eventNo);
    	$("#hiddenEventNo").val(eventNo);	
    	
    	$("#modalEventName").val(eventName);
		$("#modalContent").val(content);
		$("#modalEventPlace").val(eventPlace);
		$("#modalFromTime").val(fromTime);
		$("#modalToTime").val(toTime);
		
		$("input[name=modalFullDate]").val(fromDate+" - "+toDate);
		$("#modalEventFee").val(eventFee);
		
	
		
		if(toTime==""){
			//alert("toTime 없음");
			//document.getElementById("mtoTimeCheck").checked="checked";
			$('input:checkbox[id="mtoTimeCheck"]').attr({checked:true});
			$('input:text[id="modalToTime"]').attr({disabled:"disabled"});
		} else{
			//alert("toTime 있음");
			$('input:checkbox[id="mtoTimeCheck"]').removeAttr('checked');
			$('input:text[id="modalToTime"]').removeAttr('disabled');
		}
		
		
		if(eventFee==""){
			//alert("eventFee 없음");
			//document.getElementById("mfeeCheck").checked="checked";
			$('input:checkbox[id="mfeeCheck"]').attr({checked:true});
			$('input:text[id="modalEventFee"]').attr({disabled:"disabled"});
		}else {
			//alert("eventFee 있음");
			$('input:checkbox[id="mfeeCheck"]').removeAttr('checked');
			$('input:text[id="modalEventFee"]').removeAttr('disabled');
		}
			
		 
		 // 라디오버튼 : 정기/비정기 선택 되도록
		 $("input[name=mEventType]").each(function(){
			//alert($(this).val());
			document.getElementById("mEventType"+eventType).checked=true;
		 });
		 
		 
		
    	$("#eventModal").modal("show");
    }
    
    // eventNo, eventName, content, eventPlace, 
    // fromDate, toDate, fromTime, toTime, eventType, eventFee
    function updateEvent(){
    	var eventNo=$("#hiddenEventNo").val();
    	
    	var eventName=$.trim($("#modalEventName").val());
    	var content=$("#modalContent").val();
    	var eventPlace=$.trim($("#modalEventPlace").val());
    	var fromTime=$.trim($("#modalFromTime").val());
    	var toTime=$.trim($("#modalToTime").val());
    	var eventType=$("input[name=mEventType]:checked").val();
    	var eventFee=$.trim($("#modalEventFee").val());
    	var fullDate=$("input[name=modalFullDate]").val();
    	
    	var params="eventNo="+eventNo
    		+"&eventName="+eventName
    		+"&content="+content
    		+"&eventPlace="+eventPlace
    		+"&fromTime="+fromTime
    		+"&toTime="+toTime
    		+"&eventType="+eventType
    		+"&eventFee="+eventFee
    		+"&fullDate="+fullDate;
    	
    	var url = "<%=cp%>/event/updateEvent/${url}";
    	
    	if(confirm("해당 일정을 수정하시겠습니까?")){
    		$.ajax({
    			type:"POST"
    				,url:url
    				,data:params
    				,dataType:"json"
    				,success:function(data) {
    					location.href="<%=cp%>/event/${url}";
    				}
    				,error:function(e) {
    					
    				}
    		});
    		
    	}
 
    	$("#eventModal").modal("hide");
    }
    
    
    
    
  //선택 완료된 이벤트 처리 매퍼 실행을 위한
    function updateEventComplete() {
      	var f=document.eventForm;
      	var cnt=0;
      	
      	if(f.table_records==undefined) {
      		return false;		
      	}
      	
      	
      	
      	if(f.table_records.length!=undefined) {// 체크박스가 둘 이상인 경우
      		for(var i=0; i<f.table_records.length; i++) {
      			if(f.table_records[i].checked)
      				cnt++;
      		}
      	} else {
      		// 체크박스가 하나인 경우
      		if(f.table_records.checked)
      			cnt++;
      	}
      	
      	
      	if(cnt==0) {
      		alert("선택한 내역이 없습니다.");
      		return false;
      	}
      	
      	
      	if(confirm("선택한 내역을 완료 시키시겠습니까 ? 삭제 후에는 복구가 불가능합니다.")) {
      		f.action="<%=cp%>/event/updateEventComplete/${url}";
      		f.submit();
      	}
      	
      }
    
//선택 일괄 삭제 매퍼 실행을 위한 script by. 은제
    function deleteList() {
      	var f=document.eventForm;
      	var cnt=0;
      	
      	if(f.table_records==undefined) {
      		return false;		
      	}
      	
      	
      	
      	if(f.table_records.length!=undefined) {// 체크박스가 둘 이상인 경우
      		for(var i=0; i<f.table_records.length; i++) {
      			if(f.table_records[i].checked)
      				cnt++;
      		}
      	} else {
      		// 체크박스가 하나인 경우
      		if(f.table_records.checked)
      			cnt++;
      	}
      	
      	
      	if(cnt==0) {
      		alert("선택한 내역이 없습니다.");
      		return false;
      	}
      	
      	if(confirm("선택한 내역을 삭제하시겠습니까 ? 삭제 후에는 복구가 불가능합니다.")) {
      		f.action="<%=cp%>/event/deleteEvent/${url}";
      		f.submit();
      	}
      }
    
    //종료 시간 미정 체크박스 클릭시 input 창 비활성화
    function timeEmpty(){
    	if(document.tab_content2.toTimeCheck.checked==true){
    		document.tab_content2.toTime.value=null;
    		document.tab_content2.toTime.disabled = true;
    	}else{
    		document.tab_content2.toTime.disabled = false;
    		copyTime();
    	}
    }
    
    
	//종료 시간 미정 체크박스 클릭시 input 창 비활성화 (모달버전)
    function timeEmptyModal(){
	   	if($('input:checkbox[id="mtoTimeCheck"]').is(":checked") == true)
    	{
	   		$('input:text[id="modalToTime"]').attr({disabled:"disabled"});
	   		$("#modalToTime").val(null);
    	}else{
    		$('input:text[id="modalToTime"]').attr({disabled:false});
    	}
    }
    
    
    //회비 없음 체크박스 클릭 시 input 창 비활성화
    function feeEmpty(){
    	if(document.tab_content2.feeCheck.checked==true){
    		document.tab_content2.eventFee.disabled = true;
    		document.tab_content2.eventFee.value=null;
    	}else{
    		document.tab_content2.eventFee.disabled = false;
    		document.tab_content2.eventFee.value=null;
    	}
    }
    
    
    //회비 없음 체크박스 클릭 시 input 창 비활성화 (모달버전)
    function feeEmptyModal(){
    	if($('input:checkbox[id="mfeeCheck"]').is(":checked") == true)
    	{
    		$('input:text[id="modalEventFee"]').attr({disabled:"disabled"});
    		$("#modalEventFee").val(null);
    	}else{
    		$('input:text[id="modalEventFee"]').attr({disabled:false});
    	}
    }
    
    // toTime에 캐롯이 가면 fromTime과 시간 동일하게 해주기	
    function copyTime(){
    	document.tab_content2.toTime.value=document.tab_content2.fromTime.value;
    } 
    
    </script>
    
    
    
    
    
    
    
    
    
    


   <div class="col-md-12 col-sm-12 col-xs-12">
      <div class="x_panel">
         <div class="x_title">
            <h2>
               <i class="fa fa-bars"></i> <small>리스트 조회 및 등록</small>
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
         <div class="x_content">


            <div class="" role="tabpanel" data-example-id="togglable-tabs">
               <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                  <li role="presentation" class="active"><a
                     href="#tab_content1" id="home-tab" role="tab" data-toggle="tab"
                     aria-expanded="true">일정 조회</a></li>
                  <li role="presentation" class=""><a href="#tab_content2"
                     role="tab" id="profile-tab" data-toggle="tab"
                     aria-expanded="false">일정 등록</a></li>
               </ul>
               
               
               <div id="myTabContent" class="tab-content">
                  
                  
<!-- 탭1 시작 -->
                  <div role="tabpanel" class="tab-pane fade active in"
                  id="tab_content1" aria-labelledby="membertab">
                  <div class="col-md-12 col-sm-12 col-xs-12">
                     <div class="x_panel">
                        <div class="x_title">
                           <h2>
                              <small style="font-weight: bold;">전체 일정 리스트</small>
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
                        
                        
                        <form name="eventForm" method="post" onsubmit="return check();">
                        <div class="x_content">
                           <table id="datatable"
                              class="table table-striped table-bordered">
                              <thead>
                                 <tr>
                                 	<th style="width:30px;">선택</th>
                                    <th>No.</th>
                                    <th>일정명</th>
                                    <th>날짜</th>
                                    <th>시간</th>
                                    <th>구분</th>
                                    <th>회비관리</th>
                                    <th>참석자 수</th>
                                    <th style="width:50px;">수정</th>
                                    
                                 </tr>
                              </thead>
                              <tbody>
                              <c:forEach var="dto" items="${list}">
                                 <tr class="even pointer" id="row_${dto.eventNo}">
                              
                                    <td><input type="checkbox" class="flat" name="table_records" value="${dto.eventNo }"></td>
                                    <td><span>${dto.eventNo }</span></td>
                                    
                                    <%-- <td><a href="" data-toggle="modal" data-target="#eventModal" style="font-weight: bold;">${dto.eventName}</a></td> --%>
                                    <!-- eventNo, eventName, content, eventPlace, fromDate, toDate, fromTime, toTime, eventType, eventFee; -->
                                    <td>
                                    <span>${dto.eventName}</span>
                                    </td>
												 
                                    
                                    <td>
                                    	<c:choose>
											<c:when test="${dto.fromDate == dto.toDate}"><span>${dto.fromDate}</span></c:when>
											<c:otherwise><span>${dto.fromDate} - ${dto.toDate}</span></c:otherwise>
										</c:choose>
									</td>
                                    
                                    <td>
                                    	<c:choose>
											<c:when test="${dto.toTime==null}"><span>${dto.fromTime} 부터</span></c:when>
											<c:otherwise><span>${dto.fromTime} 부터 ${dto.toTime} 까지</span></c:otherwise>
										</c:choose>
									</td>
                                    
                                    <td>
                                    	<c:choose>
											<c:when test="${dto.eventType == 1}"><div class="btn btn-info btn-xs">Regular</div></c:when>
											<c:otherwise><div style="margin: 0px;" class="btn btn-success btn-xs">Special</div></c:otherwise>
										</c:choose>
									</td>
                                    
                                    <td>
                                    	<c:choose>
												<c:when test="${dto.eventFee!=null}"><div class="btn btn-warning btn-xs">납부자 명단</div></c:when>
                                    	</c:choose>
                                    </td>
                                    
                                    <td><span>(테스트중)</span></td>
                                    
                                    <td>
                                    	<c:choose>
											<c:when test="${dto.eventComplete=='Y'}"><span style="color:#ec971f;"><b>This schedule has been completed.</b></span></c:when>
											<c:otherwise>
					                            <a href="javascript:eventModal(
		                                    		'${dto.eventNo}', '${dto.eventName}', '${dto.content}',
		                                    		'${dto.eventPlace}','${dto.fromDate}', '${dto.toDate}', 
		                                    		'${dto.fromTime}', '${dto.toTime}', '${dto.eventType}', 
		                                    		'${dto.eventFee}');" data-toggle="modal" class="btn btn-default btn-xs"><i class="fa fa-pencil"></i> Edit </a>
		                                    </c:otherwise>
                                    	</c:choose>
	                                    <!-- <button type="button" class="btn btn-default btn-xs">Edit</button> -->
	                                    <!-- <button type="button" class="btn btn-danger btn-xs">삭제</button> -->
                                    </td>
                                 </tr>    
                              </c:forEach>
                              </tbody>
                           </table>
                           <button type="button" class="btn btn-default btn-sm" onclick="deleteList();">Delete</button>
                           <button type="button" class="btn btn-default btn-sm" onclick="updateEventComplete();">Complete</button>
                        </div>
                        </form>
                     </div>
                  </div>
               </div>
<!-- 탭1 끝 -->
               
<!-- 탭1 부속 이벤트 상세정보 모달 시작 -->					
					<div class="modal fade bs-example-modal-lg" id="eventModal" tabindex="-1" role="dialog" aria-hidden="true">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">

							<div class="modal-header" style="background-color: #334e7e;">
								<button type="button" class="close" data-dismiss="modal" style="font-weight: normal;">
									<span aria-hidden="true" style="color: white;">×</span>
								</button>
							<h4 class="modal-title" id="myModalLabel">
								<small id="myModalLabel" style="color: #e1e2e3;">상세 일정 정보</small>
							</h4>
							</div>
							
							<div class="modal-body">
								<form class="form-horizontal form-label-left input_mask">																	                          
                          
                          <div class="x_content">                                                    
                          </div>    
                      <div class="form-group">
	                    <label class="control-label col-md-3 col-sm-3 col-xs-12">일정명</label>
	                    <div class="col-md-9 col-sm-9 col-xs-12" style="width:40%;">
	                      <input id="modalEventName" type="text" class="form-control" placeholder="일정명을 입력하세요.">
	                    </div>
	                  </div>

                      <!-- 시작 : 모달용 캘린더 퍼오기 -->
                      <div class="form-group">
                      	  <label class="control-label col-md-3 col-sm-3 col-xs-12">일정날짜</label>
                      	  <div class="col-md-9 col-sm-9 col-xs-12">
	                          <fieldset>
						       <div class="control-group">
						          <div class="controls">
						               <div class="input-prepend input-group">
						                <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
						                    <input type="text" style="width: 200px" name="modalFullDate"  class="form-control" value="" />
						               </div>
						          </div>
						       </div>
						      </fieldset>
					      </div>
                      </div>
                      <!-- 끝 : 모달용 캘린더 퍼오기 -->

                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-3">일정 시간</label>
                        <div style="width:80px;" class="col-md-9 col-sm-9 col-xs-9">
                          <input id="modalFromTime" type="text" class="form-control" data-inputmask="'mask': '99:99'">
                        </div>
                        <label style="width:50px; text-align: left;" class="control-label col-md-3 col-sm-3 col-xs-3">부터</label>
                        <div  style="width:80px;" class="col-md-9 col-sm-9 col-xs-9">
                          
                           <!--아래  onfocus="copyTime()" 빠짐--> 
                          <input id="modalToTime" onfocus="copyTime()" type="text" class="form-control" data-inputmask="'mask': '99:99'">
                        </div>
                        <label style="width:50px; text-align: left;" class="control-label col-md-3 col-sm-3 col-xs-3">까지</label>
                        <input id="mtoTimeCheck" type="checkbox" value="123" onclick='timeEmptyModal()'> 종료 시간 미정
                      </div>
                                                              
                       <div class="form-group">
                        <label class="col-md-3 col-sm-3 col-xs-12 control-label">구분
                          <br>
                          <small class="text-navy">정기/비정기 모임 선택</small>
                        </label>

                        <div id="modalEventType" class="col-md-9 col-sm-9 col-xs-12">
                          <div class="radio">
                            <label>
                              <input id="mEventType1" name="mEventType" value="1" type="radio"> 정기
                            </label>
                          </div>
                          <div class="radio">
                            <label>
                              <input id="mEventType2" name="mEventType" value="2" type="radio"> 비정기
                            </label>
                          </div>
                        </div>
                      </div>
                     
                     
                     
                     <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">모임장소</label>
                        <div class="col-md-9 col-sm-9 col-xs-12" style="width: 40%;">
                          <input id="modalEventPlace" type="text" class="form-control" placeholder="장소를 입력하세요.">
                        </div>
                      </div>
                     
                     
                     
                     <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-3">회비</label>
                        <div  style="width:258px;" class="col-md-9 col-sm-9 col-xs-9">
                          <input id="modalEventFee" type="text" class="form-control" data-inputmask="'mask': '99,999'">
                          <span class="fa fa-eur form-control-feedback right" aria-hidden="true"></span>
                        </div>
                        <input id="mfeeCheck" type="checkbox" value="" onclick="feeEmptyModal()"> 회비 없음
                      </div>
                     
                     
                     <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">상세 내용</label>
                        <div class="col-md-9 col-sm-9 col-xs-12" style="width: 40%;">
                          <textarea id="modalContent" class="form-control" rows="5" placeholder='일정에 대한 상세 내용을 입력하세요.'></textarea>
                        </div>
                      </div>
										<input type="hidden" name="eventNo" id="hiddenEventNo">     										
										<!-- <input type="hidden" name="userId" id="hiddenUserId"> -->
								</form>										                         
							</div>
							<div class="modal-footer">								
								<button type="button" class="btn btn-default btn-sm" onclick="">삭제하기</button>
								<button type="button" class="btn btn-success btn-sm" onclick="updateEvent()">수정하기</button>
							</div>
						</div>
					</div>
				</div>
<!--탭1 부속 이벤트 상세정보 모달 끝 -->					
               
               
               
               
               
<!-- 탭2 시작 -->
                  <div role="tabpanel" class="tab-pane fade" id="tab_content2"
                     aria-labelledby="profile-tab">
                     <div class="x_content">
                    <br />
                    
                    <form name="tab_content2" class="form-horizontal form-label-left" method="post">

                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">일정명</label>
                        <div class="col-md-9 col-sm-9 col-xs-12" style="width:40%;">
                          <input name="eventName" type="text" class="form-control" placeholder="일정명을 입력하세요.">
                        </div>
                      </div>
                      
                      
                      
                      
                      
                      <!-- 시작 : 캘린더 퍼오기 -->
                      <div class="form-group">
                      	  <label class="control-label col-md-3 col-sm-3 col-xs-12">일정날짜</label>
                      	  <div class="col-md-9 col-sm-9 col-xs-12">
	                          <fieldset>
						       <div class="control-group">
						          <div class="controls">
						               <div class="input-prepend input-group">
						                <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
						                    <input type="text" style="width: 200px" name="fullDate" id="reservation" class="form-control" value="${today} - ${today}" />
						               </div>
						          </div>
						       </div>
						      </fieldset>
					      </div>
                      </div>
                      <!-- 끝 : 캘린더 퍼오기 -->
                      
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-3">일정 시간</label>
                        <div style="width:80px;" class="col-md-9 col-sm-9 col-xs-9">
                          <input name="fromTime" type="text" class="form-control" data-inputmask="'mask': '99:99'">
                        </div>
                        <label style="width:50px; text-align: left;" class="control-label col-md-3 col-sm-3 col-xs-3">부터</label>
                        <div  style="width:80px;" class="col-md-9 col-sm-9 col-xs-9">
                         
                         <!-- onfocus="copyTime()" -->
                          <input  id="toTime" onfocus="copyTime()" name="toTime" type="text" class="form-control" data-inputmask="'mask': '99:99'">
                        </div>
                        <label style="width:50px; text-align: left;" class="control-label col-md-3 col-sm-3 col-xs-3">까지</label>
                        <input name="toTimeCheck" type="checkbox" value="" onclick='timeEmpty()'> 종료 시간 미정
                      </div>
                      
                      <!-- 
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-3">종료 시간</label>
                        <div  style="width:80px;" class="col-md-9 col-sm-9 col-xs-9">
                          <input type="text" class="form-control" data-inputmask="'mask': '99:99'">
                        </div>
                        <input type="checkbox" value=""> 종료 시간 미정
                      </div> 
                       -->
                      
                       <div class="form-group">
                        <label class="col-md-3 col-sm-3 col-xs-12 control-label">구분
                          <br>
                          <small class="text-navy">정기/비정기 모임 선택</small>
                        </label>

                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <div class="radio">
                            <label>
                              <input name="eventType" value="1" type="radio" class="flat" name="iCheck"> 정기
                            </label>
                          </div>
                          <div class="radio">
                            <label>
                              <input name="eventType" value="2" type="radio" class="flat" checked="checked" name="iCheck"> 비정기
                            </label>
                          </div>
                        </div>
                      </div>
                     
                     
                     
                     <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">모임장소</label>
                        <div class="col-md-9 col-sm-9 col-xs-12" style="width: 40%;">
                          <input name="eventPlace" type="text" class="form-control" placeholder="장소를 입력하세요.">
                        </div>
                      </div>
                     
                     <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">모임장소</label>
                        <div class="col-md-9 col-sm-9 col-xs-12" style="width: 40%;">
                            <input id="pac-input" class="controls" type="text"  placeholder="검색할 지역을 입력하세요." />
	    					<div id="map"></div>
	    					<script type="text/javascript">
							
								function initMap() {
							  		var map = new google.maps.Map(document.getElementById('map'), {
							    	center: {lat: 37.555131, lng: 126.937401},  
							    	zoom: 16
							  	});
							
							  	var input = document.getElementById('pac-input');
							
							  	var autocomplete = new google.maps.places.Autocomplete(input);
							  	autocomplete.bindTo('bounds', map);
							
							  	map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
							
							  	var infowindow = new google.maps.InfoWindow();
							  	var marker = new google.maps.Marker({
							    	map: map
							  	});
							  	
							  	marker.addListener('click', function() {
								    infowindow.open(map, marker);
							  	});
							
							  autocomplete.addListener('place_changed', function() {
							    infowindow.close();
							    var place = autocomplete.getPlace();
							    if (!place.geometry) {
							      return;
							    }
							
							    if (place.geometry.viewport) {
							      map.fitBounds(place.geometry.viewport);
							    } else {
							      map.setCenter(place.geometry.location);
							      map.setZoom(17);
							    }
							
							    // Set the position of the marker using the place ID and location.
							    marker.setPlace({
							      placeId: place.place_id,
							      location: place.geometry.location
							    });
							    marker.setVisible(true);
							    $("#latitude").val(place.geometry.location.lat());
							    $("#longitude").val(place.geometry.location.lng());
							    $("#place").val(place.name);
							    
							    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + '<br>' + place.formatted_address);
							    infowindow.open(map, marker);
							  });
							}
								
		    					</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB13zlChxv2VHCovCQxUTxlCKelolePigk&libraries=places&signed_in=true&callback=initMap"  async defer></script>
                        </div>
                      </div>
                     
                     <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-3">회비</label>
                        <div  style="width:258px;" class="col-md-9 col-sm-9 col-xs-9">
                          <input name="eventFee" type="text" class="form-control" data-inputmask="'mask': '99,999'">
                          <span class="fa fa-eur form-control-feedback right" aria-hidden="true"></span>
                        </div>
                        <input name="feeCheck" type="checkbox" value="" onclick="feeEmpty()"> 회비 없음
                      </div>
                     
                     
                     <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">상세 내용</label>
                        <div class="col-md-9 col-sm-9 col-xs-12" style="width: 40%;">
                          <textarea name="content" class="form-control" rows="5" placeholder='일정에 대한 상세 내용을 입력하세요.'></textarea>
                        </div>
                      </div>
                      
                      <br>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">참석자 리스트</label>
                        <div class="col-md-9 col-sm-9 col-xs-12" >
                        
						    <div style="clear: both;">
						         <div style="float: left; width: 220px;">
						             <div style="clear: both; padding-bottom: 5px;">
						                 <span>회원 목록</span>
						             </div>
						             <div class="note-send-listFriend">
						                 <table style="border-spacing: 0px;">
						                     <tbody id="noteListFriend"></tbody>
						                 </table>
						             </div>
						         </div>
						         <div style="float: left; width: 80px;  padding: 0px 20px; line-height: 260px; height: 260px; text-align: ">
						           <div class="btn-group-vertical" role="group" aria-label="Vertical button group">
						             <button type="button" class="btn btn-success btn-sm" style="width: 40px;" id="noteRightAllMoveButton">&gt;&gt;</button>
						             <button type="button" class="btn btn-success btn-sm" style="width: 40px;" id="noteRightMoveButton">&gt;</button>
						             <button type="button" class="btn btn-success btn-sm" style="width: 40px;" id="noteLeftMoveButton">&lt;</button>
						             <button type="button" class="btn btn-success btn-sm" style="width: 40px;" id="noteLeftAllMoveButton">&lt;&lt;</button>
						            </div>
						         </div>
						         <div style="float: left; width: 220px;">
						             <div style="clear: both; padding-bottom: 5px;">
						                 <span>참석 회원</span>
						             </div>
						             <div class="note-send-listFriend">
						                 <table style="border-spacing: 0px;">
						                     <tbody id="noteListReceive"></tbody>
						                 </table>
						             </div>             
						         </div>
						    </div>
                        </div>
                      </div>

                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3">
                          <button type="reset" class="btn btn-default btn-sm">취소</button>
                          <button type="button" class="btn btn-success btn-sm" 
                          	onclick="submitEvent();">등록</button>
                        </div>
                      </div>

                    </form>
                    
                   
                    
                    
                  </div>
                  </div>
<!-- 탭2 끝 -->
                  
                  

               </div>
            </div>
         </div>
      </div>
   </div>
<div class="clearfix"></div>

     
    <!-- 시작 : 이벤트 상세정보 모달 -->
	<script src="<%=cp%>/res/js/jquery.bootstrap.wizard.js" type="text/javascript"></script>  
	<script src="<%=cp%>/res/js/wizard.js"></script>
	<!-- 끝 : 이벤트 상세정보 모달 -->
     
 	<!-- 시작 : form 출력 관련 script -->
 	<!-- icheck.min.js 버튼 디자인 된 형태로... -->
	<script src="<%=cp%>/res/js/admin/icheck.min.js"></script>
	
	<!-- 달력 출력을 위한  -->
	<script src="<%=cp%>/res/js/admin/moment.min.js"></script>
	<script src="<%=cp%>/res/js/admin/daterangepicker.js"></script>
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
	<!-- 끝! 달력 출력을 위한 스크립트 -->
	
	
	
	<!-- inputmask (내가 원하는 포맷으로 나오도록) -->
	<script src="<%=cp%>/res/js/schedule/jquery.inputmask.bundle.min.js"></script>
	<script>
      $(document).ready(function() {
        $(":input").inputmask();
      });
    </script>

    <!-- Autosize -->
	<script src="<%=cp%>/res/js/communityManager/autosize.js"></script>
 	<!-- 끝 : form 출력 관련 script -->



  	<!-- 시작 : list 출력 관련 script -->
    <script src="<%=cp%>/res/js/admin/jquery.dataTables.js"></script>
	<script src="<%=cp%>/res/js/admin/dataTables.bootstrap.js"></script>
	<script src="<%=cp%>/res/js/admin/dataTables.buttons.js"></script>
	<script src="<%=cp%>/res/js/admin/buttons.bootstrap.js"></script>
	<script src="<%=cp%>/res/js/admin/dataTables.fixedHeader.min.js"></script>
	<script src="<%=cp%>/res/js/admin/dataTables.keyTable.min.js"></script>
	<script src="<%=cp%>/res/js/admin/dataTables.responsive.min.js"></script>
	<script src="<%=cp%>/res/js/admin/responsive.bootstrap.js"></script>
	<script src="<%=cp%>/res/js/admin/dataTables.scroller.min.js"></script>
	<script src="<%=cp%>/res/js/admin/vfs_fonts.js"></script>
	
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
    <!-- 끝 : list 출력 관련 script -->
    
