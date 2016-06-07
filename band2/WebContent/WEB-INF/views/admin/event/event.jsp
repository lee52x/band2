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
	
    
    <!-- Custom Theme Style -->
    <link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">
    
    <!-- 참석자 리스트 테이블 출력을 위한 css -->
    <style type="text/css">
		.note-send-listFriend{
			clear:both;
			width:218px;
			height:260px;
			text-align: left;
			padding: 5px 5px 5px 5px;
			overflow: scroll;
			border:1px solid #ccc;
		}
    </style>
    
    
    <script type="text/javascript">
 // 친구 목록 가져오기
$(function(){
    	var url = "<%=cp%>/event/listFriend/{url}";
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
			
		
		/* if(eventType=="1"){
			alert("1번이에요");
			$('input[name="mEventType"]:radio[value="1"]').attr('checked',true);
		}else if(eventType=="2"){
			alert("2번이에요");
			$('input[name="mEventType"]:radio[value="2"]').attr('checked',true);
		}
		 */
		// alert($("#mEventType1"));
		 
		 // 라디오버튼 : 정기/비정기 선택 되도록
		 $("input[name=mEventType]").each(function(){
			//alert($(this).val());
			document.getElementById("mEventType"+eventType).checked=true;
		 });
		 
		 
		 //$("#mEventType1").checked=true;
		// $("#mEventType1").attr({checked: "true"});
		 
		//$('input:radio[name=mEventType]:input[value=eventType]').attr("checked");
		/*  
		switch(eventType) {
		case 1:
			//$('input[name="mEventType"]:radio[value="1"]').prop('checked',true);
			//$('input:radio[name="mEventType"]:radio[value="1"]').attr('checked',true);
			break;
		case 2:
			$('input:radio[name=mEventType]:input[value=eventType]').attr("checked", true);
			//$('input[name="mEventType"]:radio[value="2"]').prop('checked',true);
			//$('input:radio[name="mEventType"]:radio[value="2"]').attr('checked',true);
			break;
		} */

		
		
		/* $("#hiddenMemberNo").val(memberNo);	
    	$("#modalName").text(name);
    	$("#modalRename").val(name);
    	
    	if(userId == "") {
    		$("#modalUserId").text("커뮤니티 미가입"); 				
    	} else {
    		$("#modalUserId").text(userId);
    	}
    	$("#hiddenUserId").val(userId);
    	
    	if(gender == 1) {
    		$("#modalGender").text("남성")
    	} else {
    		$("#modalGender").text("여성")
    	}
    	
    	$("#modalBirth").val(birth);
    	$("#modalAddress").val(address);
    	$("#modalEmail").val(email);
    	$("#modalTel").val(tel);
    	$("#modalJoinDate").val(joinDate);	
    	
    	switch(grade) {
    		case '1':
    			$("#modalGrade").text("그룹장");
    			break;
    		case '2':
    			$("#modalGrade").text("운영진");
    			break;
    		case '3':
    			$("#modalGrade").text("일반회원");
    			break;
    		case '4':
    			$("#modalGrade").text("OB회원");
    			break;
    		case '5':
    			$("#modalGrade").text("비활동회원");
    			break;
    		default:
    			$("#modalGrade").text("일반회원");
    			break;	
    	}
    	 */
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
    
    //선택 일괄 삭제 매퍼 실행을 위한 script by. 은제
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
    
  //선택 완료된 이벤트 처리 매퍼 실행을 위한 script by. 은제
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
   <div class="">
   <div class="col-md-12 col-sm-12 col-xs-12">
      <div class="x_panel">
         <div class="x_title">
            <h2>
               <i class="fa fa-bars"></i> 일정관리 <small>Float left</small>
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
                  <li role="presentation" class=""><a href="#tab_content3"
                     role="tab" id="profile-tab2" data-toggle="tab"
                     aria-expanded="false">일정 상세 관리</a></li>                  
               </ul>
               
               
               <div id="myTabContent" class="tab-content">
                  
                  <div role="tabpanel" class="tab-pane fade active in"
                  id="tab_content1" aria-labelledby="membertab">
                  <div class="col-md-12 col-sm-12 col-xs-12">
                     <div class="x_panel">
                        <div class="x_title">
                           <h2>
                              일정 리스트 <small> (그룹명) 전체 모임 리스트</small>
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
                                 	<th>선택</th>
                                    <th>No.</th>
                                    <th>일정명</th>
                                    <th>날짜</th>
                                    <th>시간</th>
                                    <th>구분</th>
                                    <th>회비관리</th>
                                    <th>참석자 수</th>
                                    <th>수정/삭제</th>
                                    
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
                                    <a href="javascript:eventModal(
                                    		'${dto.eventNo}', '${dto.eventName}', '${dto.content}',
                                    		'${dto.eventPlace}','${dto.fromDate}', '${dto.toDate}', 
                                    		'${dto.fromTime}', '${dto.toTime}', '${dto.eventType}', 
                                    		'${dto.eventFee}');"  data-toggle="modal" style="font-weight: bold; ">
                                    	<span style="text-decoration: underline;">${dto.eventName}</span>
                                    </a>
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
		                                    		'${dto.eventFee}');" data-toggle="modal" class="btn btn-default btn-xs"><i class="fa fa-folder"></i> View </a>
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
                           <button type="button" class="btn btn-danger btn-sm" onclick="deleteList();">Delete</button>
                           <button type="button" class="btn btn-danger btn-sm" onclick="updateEventComplete();">Complete</button>
                        </div>
                        </form>
                     </div>
                  </div>
               </div>
               
               
               		<!-- 이벤트 상세정보 모달 시작 -->					
					<div class="modal fade bs-example-modal-lg" id="eventModal" tabindex="-1" role="dialog" aria-hidden="true">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">

							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span></button>
								<h4 class="modal-title" id="myModalLabel">상세 일정 정보</h4>
							</div>
							
							<div class="modal-body">
								<form class="form-horizontal form-label-left input_mask">																	                          
                          
                          <div class="x_content">                            
                            <div class="flex">
                              <ul class="list-inline count2">
                                <li>
                                  <h1 id="modalName" style="color: #0066ff;"></h1>                                  
                                </li>
                              	<li>
                              		<h3 id="modalEventNo"></h3>
                              		<span>일정번호</span>
                              	</li>
                                <li>
                                  	<h3 id="modalUserId"></h3>                                  	                                  	                                                              
                                  <span>아이디</span>
                                </li>                                
                                <li>                                	
                                </li>
                                <li>
                                  	<h5 id="modalGender"></h5>                                  	                                  	                                                              
                                  <span>성별</span>
                                </li>
                                <li>
                                  	<h5 id="modalGrade"></h5>                                  	                                  	                                                              
                                  <span>회원등급</span>
                                </li>
                              </ul>
                            </div>                         
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
								<button type="button" class="btn btn-danger" onclick="">삭제하기</button>
								<button style="margin-bottom: 5px;" type="button" class="btn btn-primary" onclick="updateEvent()">수정하기</button>
							</div>
						</div>
					</div>
				</div>
				<!-- 이벤트 상세정보 모달 끝 -->					
               
               
               
               
               
               
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
                          <button type="reset" class="btn btn-primary">취소</button>
                          <button type="submit" class="btn btn-success" 
                          	onclick="javascript:location.href='<%=cp%>/event/{url}';">등록</button>
                        </div>
                      </div>

                    </form>
                    
                   
                    
                    
                  </div>
                  </div>
                  
                  
                  
                  
                  
                  
                  
                  
                  <div role="tabpanel" class="tab-pane fade" id="tab_content3"
                     aria-labelledby="profile-tab">
                     <div class="x_content">
                  
                  
                  <!-- 시작 : 캘린더 퍼오기 -->
                      <div class="form-group">
                      	  <label style="width:80px;" class="control-label col-md-3 col-sm-3 col-xs-12">날짜 검색</label>
                      	  <div class="col-md-9 col-sm-9 col-xs-12">
	                           <fieldset>
			                          <div class="control-group">
			                            <div class="controls">
			                              <div style="width: 200px;" class="col-md-11 xdisplay_inputx form-group has-feedback">
			                                <input type="text" class="form-control has-feedback-left" id="single_cal2" placeholder="First Name" aria-describedby="inputSuccess2Status2">
			                                <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
			                                <span id="inputSuccess2Status2" class="sr-only">(success)</span>
			                              </div>
			                              
			                            </div>
			                            <button type="submit" class="btn btn-success">검색</button>
			                          </div>
							  </fieldset>
					      </div>
                      </div>
                      <!-- 끝 : 캘린더 퍼오기 -->
                  
                  
                  
                  
				 
				 <table class="table">
                      <thead>
                        <tr>
                          <th>No.</th>
                          <th>날짜</th>
                          <th>시간</th>
                          <th>일정명</th>
                          <th>회비여부</th>
                          <th>참석자수</th>                     
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <th scope="row">1</th>
                          <td>2016/01/23 ~<br>2016/01/24</td>
                          <td>14:00 ~ 16:00</td>
                          <td>축제</td>
                          <td>●</td>
                          <td>43/50</td>
                        </tr>
                        <tr>
                          <th scope="row">2</th>
                          <td>2016/03/25</td>
                          <td>18:00 ~ 20:00</td>
                          <td>정기모임</td>
                          <td></td>
                          <td>17/50</td>
                        </tr>
                        <tr>
                          <th scope="row">3</th>
                          <td>2016/05/22</td>
                          <td>18:00 ~ 20:00</td>
                          <td>5월 생일 파티</td>
                          <td></td>
                          <td>40/50</td>
                        </tr>
                      </tbody>
                    </table>

                  </div>
                  </div>
               </div>
            </div>

         </div>
      </div>
   </div>
   <div class="clearfix"></div>
</div>   









<!--         	<div style="height: 2000px;"><div class="col-md-6 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>일정등록하기 <small>register schedule form</small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                    <form class="form-horizontal form-label-left">

                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">일정명</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" placeholder="일정명을 입력하세요.">
                        </div>
                      </div>
                      
                      
                      
                      
                      
                      시작 : 캘린더 퍼오기
                      <div class="form-group">
                      	  <label class="control-label col-md-3 col-sm-3 col-xs-12">일정날짜</label>
                      	  <div class="col-md-9 col-sm-9 col-xs-12">
	                          <fieldset>
						       <div class="control-group">
						          <div class="controls">
						               <div class="input-prepend input-group">
						                <span class="add-on input-group-addon"><i class="glyphicon glyphicon-calendar fa fa-calendar"></i></span>
						                    <input type="text" style="width: 200px" name="reservation" id="reservation" class="form-control" value="03/18/2013 - 03/23/2013" />
						               </div>
						          </div>
						       </div>
						      </fieldset>
					      </div>
                      </div>
                      끝 : 캘린더 퍼오기
                      
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-3">시작 시간</label>
                        <div class="col-md-9 col-sm-9 col-xs-9">
                          <input style="width:60px;" type="text" class="form-control" data-inputmask="'mask': '99:99'">
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-3">종료 시간</label>
                        <div class="col-md-9 col-sm-9 col-xs-9">
                          <input style="width:60px;" type="text" class="form-control" data-inputmask="'mask': '99:99'">
                        </div>
                      </div> 
                      
                      
                       <div class="form-group">
                        <label class="col-md-3 col-sm-3 col-xs-12 control-label">구분
                          <br>
                          <small class="text-navy">정기/비정기 모임 선택</small>
                        </label>

                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <div class="radio">
                            <label>
                              <input type="radio" class="flat" checked name="iCheck"> 정기
                            </label>
                          </div>
                          <div class="radio">
                            <label>
                              <input type="radio" class="flat" name="iCheck"> 비정기
                            </label>
                          </div>
                        </div>
                      </div>
                     
                     
                     
                     <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">모임장소</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" placeholder="장소를 입력하세요.">
                        </div>
                      </div>
                     
                     
                     
                     <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-3">회비</label>
                        <div  style="width:200px;" class="col-md-9 col-sm-9 col-xs-9">
                          <input type="text" class="form-control" data-inputmask="'mask': '99,999'">
                          <span class="fa fa-leaf form-control-feedback right" aria-hidden="true"></span>
                        </div>
                      </div>
                     
                      
                      
                      
                     나머지 form_basic 태그들
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Disabled Input </label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" disabled="disabled" placeholder="Disabled Input">
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Read-Only Input</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" class="form-control" readonly="readonly" placeholder="Read-Only Input">
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Date Of Birth <span class="required">*</span>
                        </label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <textarea class="form-control" rows="3" placeholder='rows="3"'></textarea>
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Password</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="password" class="form-control" value="passwordonetwo">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">AutoComplete</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input type="text" name="country" id="autocomplete-custom-append" class="form-control col-md-10" style="float: left;" />
                          <div id="autocomplete-container" style="position: relative; float: left; width: 400px; margin: 10px;"></div>
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Select</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <select class="form-control">
                            <option>Choose option</option>
                            <option>Option one</option>
                            <option>Option two</option>
                            <option>Option three</option>
                            <option>Option four</option>
                          </select>
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Select Custom</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <select class="select2_single form-control" tabindex="-1">
                            <option></option>
                            <option value="AK">Alaska</option>
                            <option value="HI">Hawaii</option>
                            <option value="CA">California</option>
                            <option value="NV">Nevada</option>
                            <option value="OR">Oregon</option>
                            <option value="WA">Washington</option>
                            <option value="AZ">Arizona</option>
                            <option value="CO">Colorado</option>
                            <option value="ID">Idaho</option>
                            <option value="MT">Montana</option>
                            <option value="NE">Nebraska</option>
                            <option value="NM">New Mexico</option>
                            <option value="ND">North Dakota</option>
                            <option value="UT">Utah</option>
                            <option value="WY">Wyoming</option>
                            <option value="AR">Arkansas</option>
                            <option value="IL">Illinois</option>
                            <option value="IA">Iowa</option>
                            <option value="KS">Kansas</option>
                            <option value="KY">Kentucky</option>
                            <option value="LA">Louisiana</option>
                            <option value="MN">Minnesota</option>
                            <option value="MS">Mississippi</option>
                            <option value="MO">Missouri</option>
                            <option value="OK">Oklahoma</option>
                            <option value="SD">South Dakota</option>
                            <option value="TX">Texas</option>
                          </select>
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Select Grouped</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <select class="select2_group form-control">
                            <optgroup label="Alaskan/Hawaiian Time Zone">
                              <option value="AK">Alaska</option>
                              <option value="HI">Hawaii</option>
                            </optgroup>
                            <optgroup label="Pacific Time Zone">
                              <option value="CA">California</option>
                              <option value="NV">Nevada</option>
                              <option value="OR">Oregon</option>
                              <option value="WA">Washington</option>
                            </optgroup>
                            <optgroup label="Mountain Time Zone">
                              <option value="AZ">Arizona</option>
                              <option value="CO">Colorado</option>
                              <option value="ID">Idaho</option>
                              <option value="MT">Montana</option>
                              <option value="NE">Nebraska</option>
                              <option value="NM">New Mexico</option>
                              <option value="ND">North Dakota</option>
                              <option value="UT">Utah</option>
                              <option value="WY">Wyoming</option>
                            </optgroup>
                            <optgroup label="Central Time Zone">
                              <option value="AL">Alabama</option>
                              <option value="AR">Arkansas</option>
                              <option value="IL">Illinois</option>
                              <option value="IA">Iowa</option>
                              <option value="KS">Kansas</option>
                              <option value="KY">Kentucky</option>
                              <option value="LA">Louisiana</option>
                              <option value="MN">Minnesota</option>
                              <option value="MS">Mississippi</option>
                              <option value="MO">Missouri</option>
                              <option value="OK">Oklahoma</option>
                              <option value="SD">South Dakota</option>
                              <option value="TX">Texas</option>
                              <option value="TN">Tennessee</option>
                              <option value="WI">Wisconsin</option>
                            </optgroup>
                            <optgroup label="Eastern Time Zone">
                              <option value="CT">Connecticut</option>
                              <option value="DE">Delaware</option>
                              <option value="FL">Florida</option>
                              <option value="GA">Georgia</option>
                              <option value="IN">Indiana</option>
                              <option value="ME">Maine</option>
                              <option value="MD">Maryland</option>
                              <option value="MA">Massachusetts</option>
                              <option value="MI">Michigan</option>
                              <option value="NH">New Hampshire</option>
                              <option value="NJ">New Jersey</option>
                              <option value="NY">New York</option>
                              <option value="NC">North Carolina</option>
                              <option value="OH">Ohio</option>
                              <option value="PA">Pennsylvania</option>
                              <option value="RI">Rhode Island</option>
                              <option value="SC">South Carolina</option>
                              <option value="VT">Vermont</option>
                              <option value="VA">Virginia</option>
                              <option value="WV">West Virginia</option>
                            </optgroup>
                          </select>
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Select Multiple</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <select class="select2_multiple form-control" multiple="multiple">
                            <option>Choose option</option>
                            <option>Option one</option>
                            <option>Option two</option>
                            <option>Option three</option>
                            <option>Option four</option>
                            <option>Option five</option>
                            <option>Option six</option>
                          </select>
                        </div>
                      </div>

                      <div class="control-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Input Tags</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <input id="tags_1" type="text" class="tags form-control" value="social, adverts, sales" />
                          <div id="suggestions-container" style="position: relative; float: left; width: 250px; margin: 10px;"></div>
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <label class="col-md-3 col-sm-3 col-xs-12 control-label">Checkboxes and radios
                          <br>
                          <small class="text-navy">Normal Bootstrap elements</small>
                        </label>

                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" value=""> Option one. select more than one options
                            </label>
                          </div>
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" value=""> Option two. select more than one options
                            </label>
                          </div>
                          <div class="radio">
                            <label>
                              <input type="radio" checked="" value="option1" id="optionsRadios1" name="optionsRadios"> Option one. only select one option
                            </label>
                          </div>
                          <div class="radio">
                            <label>
                              <input type="radio" value="option2" id="optionsRadios2" name="optionsRadios"> Option two. only select one option
                            </label>
                          </div>
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="col-md-3 col-sm-3 col-xs-12 control-label">Checkboxes and radios
                          <br>
                          <small class="text-navy">Normal Bootstrap elements</small>
                        </label>

                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" class="flat" checked="checked"> Checked
                            </label>
                          </div>
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" class="flat"> Unchecked
                            </label>
                          </div>
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" class="flat" disabled="disabled"> Disabled
                            </label>
                          </div>
                          <div class="checkbox">
                            <label>
                              <input type="checkbox" class="flat" disabled="disabled" checked="checked"> Disabled & checked
                            </label>
                          </div>
                          <div class="radio">
                            <label>
                              <input type="radio" class="flat" checked name="iCheck"> Checked
                            </label>
                          </div>
                          <div class="radio">
                            <label>
                              <input type="radio" class="flat" name="iCheck"> Unchecked
                            </label>
                          </div>
                          <div class="radio">
                            <label>
                              <input type="radio" class="flat" name="iCheck" disabled="disabled"> Disabled
                            </label>
                          </div>
                          <div class="radio">
                            <label>
                              <input type="radio" class="flat" name="iCheck3" disabled="disabled" checked> Disabled & Checked
                            </label>
                          </div>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Switch</label>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                          <div class="">
                            <label>
                              <input type="checkbox" class="js-switch" checked /> Checked
                            </label>
                          </div>
                          <div class="">
                            <label>
                              <input type="checkbox" class="js-switch" /> Unchecked
                            </label>
                          </div>
                          <div class="">
                            <label>
                              <input type="checkbox" class="js-switch" disabled="disabled" /> Disabled
                            </label>
                          </div>
                          <div class="">
                            <label>
                              <input type="checkbox" class="js-switch" disabled="disabled" checked="checked" /> Disabled Checked
                            </label>
                          </div>
                        </div>
                      </div>


                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-3">
                          <button type="submit" class="btn btn-primary">초기화</button>
                          <button type="submit" class="btn btn-success">등록</button>
                        </div>
                      </div>

                    </form>
                  </div>
                </div>
              </div></div> -->
     
    <!-- 시작 : 이벤트 상세정보 모달 -->
	<script src="<%=cp%>/res/js/jquery.bootstrap.wizard.js" type="text/javascript"></script>  
	<script src="<%=cp%>/res/js/wizard.js"></script>
	<!-- 끝 : 이벤트 상세정보 모달 -->
     
 	<!-- 시작 : form 출력 관련 script -->
 	<!-- icheck.min.js 버튼 디자인 된 형태로... -->
	<script src="<%=cp%>/res/js/admin/icheck.min.js"></script>
	
	<!-- 달력 출력을 위한  -->
	<script src="<%=cp%>/res/js/moment.min.js"></script>	
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