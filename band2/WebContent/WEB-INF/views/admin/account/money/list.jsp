<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">
<link href="<%=cp%>/res/css/admin/green.css" rel="stylesheet"> <!-- 리스트부분 css임 (색 바꿀 수 있음 css바꾸면) -->

<style>
	table{
		border-collapse:collapse;
		width:100%;
	}
	
	thead{
		float:left; 
		width:1582px; 
	}
	
	tbody{
		overflow-y:auto;
		overflow-x:hidden;
		float:left;
		width:1582px;
		height:400px;
	}
	
	tr{
		display:table;
		width:1582px;
	}
	th{
		width:150px;
		border-right: 1px solid #ddd;
		border-top: 0;
	}
	
	.table > tbody > tr > td{
		width:150px;
		border-right: 1px solid #ddd;
		border-top: 0;
		border-bottom: 1px solid #ddd;
	}
	
	.inputbox{
		width:100%;
		background:transparent;
		border:0;
	}
	
	select{
		width:100%;
		background:transparent;
		border:0;
	}
	
	.update_select{
		background:white;
		border:1px solid #A9A9A9;
		height:24px;
		width:130px;
	}
	
	.upload_select{
		background:white;
		border:1px solid #A9A9A9;
		height:24px;
		width:130px;
	}
	
	.btn{
	  margin-bottom: 0px;
      margin-right: 0px; 
      padding: 4px 10px;
      font-size: 10px;
	}
	.row{
	margin-left:15%;
	}
</style>

<script type="text/javascript">
  function check() {
        var f = document.moneyForm;
        f.action="<%=cp%>/account/main/${url}";
        return true;
 }
  

  function deleteList() {
  	var f=document.moneyForm;
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
  		f.action="<%=cp%>/account/deleteList/${url}";
  		f.submit();
  	}
  }
  

  var arr=new Array();
  function updateMoney(tranNo) {
  	var tds=$("#row_"+tranNo+" td");
  	var size=14;
  	
  	$(tds).each(function(i){
  		if(i!=tds.length-1&&i!=0) {
  			arr[i]=$(this).text();
  			$(this).empty();
  			if(i==6){
  				$(this).append("<select name='accountName_s' class='update_select'><option value='미분류'></option>"+
  				"<option value='회식'>회식</option><option value='행사'>행사</option><option value='비품'>비품</option>"+
  				"<option value='회비'>회비</option><option value='모임'>모임</option><option value='의류'>의류</option>"+
				"<option value='문화'>문화</option><option value='교육'>교육</option><option value='교통'>교통</option>"+
				"<option value='기타'>기타</option></select>");
  			}
  			if(i==7){
  				$(this).append("<select name='eventNo_s' class='update_select'>"
  				+"<option value=''></option>"+
  				<c:forEach var="dto" items="${eventList}">
				"<option value='${dto.eventName}'>${dto.eventName}</option>"+
			    </c:forEach>
  				"</select>");
  			
  			}
  			if(i<=5||i==8){
  				$(this).append("<input type='text' value='"+arr[i]+"' class='boxTF' size='"+size+"'>");
  			}
  		} else if(i==tds.length-1){
  			$(this).empty();
  			$(this).append("<span onclick='updateOk("+tranNo+");' style='cursor:pointer;'>&nbsp;<i class='green'><i class='fa fa-check'></i></i></span>&nbsp;&nbsp;&nbsp;<span onclick='updateCancel("+tranNo+");' style='cursor:pointer;'><i class='red'><i class='fa fa-close'></i></i></span>");
  		}
  	});
  	
  	$("select[name=accountName_s]").val($.trim(arr[6]));
  	$("select[name=eventNo_s]").val($.trim(arr[7]));
  }

  function updateCancel(tranNo) {
  	var tds=$("#row_"+tranNo+" td");
  	
  	$(tds).each(function(i){
  		if(i!=tds.length-1&&i!=0) {
  			$(this).empty();
  			$(this).text(arr[i]);
  		} else if(i==tds.length-1) {
  			$(this).empty();
  			$(this).append("<button type='button' class='btn btn-default btn-sm' onclick='updateMoney("+tranNo+")'>수정</button>");
  		}
  	});
  }

  function updateOk(tranNo) {
  	var tds=$("#row_"+tranNo+" td");
  	var data=new Array();
  	var n=0;
  	var f=document.moneyForm;
  	
  	$(tds).each(function(i){
  		var ob=$(this);
  		if(i!=tds.length-1&&i!=0) {
  			$(this).find("input:text, select").each(function() {
  				ob.empty();
  		        ob.text($(this).val());
  		        data[n++]=$(this).val();
  		    });
  		} else if(i==tds.length-1) {
  			$(this).empty();
  			$(this).append("<button type='button' class='btn btn-default btn-sm' onclick='updateMoney("+tranNo+")'>수정</button>");
  		}
  	});
  	var year=$("#year").val();
  	var month=$("#month").val();
  	var params="transactionNo="+tranNo+"&tranDate="+data[0]+"&tranName="+data[1]+"&tranData="+data[2]+"&withdrawal="+data[3]+
  			"&deposit="+data[4]+"&accountName="+data[5]+"&eventNo="+data[6]+"&memo="+data[7]+"&year="+year+"&month="+month;
  	
  	var url="<%=cp%>/account/update/${url}";
	
  	$.ajax({
  		type:"post"
  		,url:url
  		,data:params
  		,dataType:"json"
  		,success:function(data){
  			document.onLoad = reloadpage();
  		}
  		,error:function(e) {
    		alert(e.responseText);
    	}
  	});	
  }
  
	function check_upload() {
        var f = document.uploadForm;

        f.action="<%=cp%>/account/upload/${url}";
		return true;
	}
	
	function searchList() {
		var start=$("#start").val();
	  	var end=$("#end").val();
	  	
	  	var url="<%=cp%>/account/searchList/${url}";
	  	
	  	$.post(url, {start:start, end:end}, function(data){
	  		$("#searchList").html(data);
		});	
	}
	
	function allList() {
	  	var url="<%=cp%>/account/allList/${url}";
	  	
	  	$.post(url, {}, function(data){
	  		$("#searchList").html(data);
		});	
	}
	
	function eventList(event) {
	  	var url="<%=cp%>/account/eventList/${url}";
	  	
	  	$.post(url, {event:event}, function(data){
	  		$("#searchList").html(data);
		});	
	}
	
	function cateList(category) {
	  	var url="<%=cp%>/account/cateList/${url}";
	  	
	  	$.post(url, {category:category}, function(data){
	  		$("#searchList").html(data);
		});	
	}

	function fn_Print()
	{ 
	 document.body.innerHTML = table.innerHTML; //taskInfoGrid는 출력하고자 하는 table이나 div  id이다. 
	 window.print(); 
	}
	
</script>

  	<!-- top tiles -->
          <div class="row tile_count">
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 지난 달 지출</span>
              <div class="count red">- <fmt:formatNumber value="${preMonthDto.withdrawal}" groupingUsed="true"/></div>
              <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>34% </i> From last Month</span>	
            </div>
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-clock-o"></i> 이번 달 지출</span>
              <div class="count red">- <fmt:formatNumber value="${thisMonthDto.withdrawal}" groupingUsed="true"/></div>
              <span class="count_bottom">
              <c:choose>
              	<c:when test="${preMonthDto.withdrawal >= thisMonthDto.withdrawal}">
              		<i class="green"><i class="fa fa-sort-desc"></i>
              		<fmt:formatNumber value="${preMonthDto.withdrawal/thisMonthDto.withdrawal}" pattern="#"/>%</i>
              	</c:when>
          		<c:when test="${preMonthDto.withdrawal < thisMonthDto.withdrawal}">
              		<i class="red"><i class="fa fa-sort-asc"></i>
              		<fmt:formatNumber value="${thisMonthDto.withdrawal/preMonthDto.withdrawal}" pattern="#"/>%</i>
              	</c:when>
              </c:choose>
               From last Month</span>
            </div>
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 현재 잔액</span>
              <div class="count"><fmt:formatNumber value="${balance}" groupingUsed="true"/></div>
              <span class="count_bottom"><i class="green">${today} </i> Now Balance</span>
            </div>
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 이번 달 수입</span>
              <div class="count green">+ <fmt:formatNumber value="${thisMonthDto.deposit}" groupingUsed="true"/></div>
              <span class="count_bottom">
              <c:choose>
              	<c:when test="${preMonthDto.deposit >= thisMonthDto.deposit}">
              		<i class="red"><i class="fa fa-sort-desc"></i>
              		<fmt:formatNumber value="${preMonthDto.deposit/thisMonthDto.deposit}" pattern="#"/>%</i>
              	</c:when>
          		<c:when test="${preMonthDto.deposit < thisMonthDto.deposit}">
              		<i class="green"><i class="fa fa-sort-asc"></i>
              		<fmt:formatNumber value="${thisMonthDto.deposit/preMonthDto.deposit}" pattern="#"/>%</i>
              	</c:when>
              </c:choose>
              From last Month</span>
            </div>
            <div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
              <span class="count_top"><i class="fa fa-user"></i> 지난 달 수입</span>
              <div class="count green">+ <fmt:formatNumber value="${preMonthDto.deposit}" groupingUsed="true"/></div>
              <span class="count_bottom"><i class="green"><i class="fa fa-sort-asc"></i>34% </i> From last Month</span>
            </div>
          </div>
          <!-- /top tiles -->

    	<div class="left_col" role="main">
              <div class="clearfix"></div>
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Table design <small>Custom design</small></h2>
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
					
                    <h1 style="text-align:center; padding-right:170px;​">
                    <button type="button" class="btn btn-default btn-sm" style="float:left;" data-toggle="modal" data-target="#myModal">사용 내역 엑셀 업로드</button>
                    	<c:if test="${mvo!=1}">
                    	<a href="javascript:location.href='<%=cp%>/account/main/${url}?year=${year}&month=${month-1}';"><i class="glyphicon glyphicon-chevron-left"></i></a>
                    	</c:if>
                    	${year}년 ${month}월
                    	<c:if test="${tvo!=1}">
                    	<a href="javascript:location.href='<%=cp%>/account/main/${url}?year=${year}&month=${month+1}';"><i class="glyphicon glyphicon-chevron-right"></i></a>
                    	</c:if>
                    </h1>
					
				<form name="moneyForm" method="post" onsubmit="return check();">
			
                    <div class="table-responsive">
                     <div id="table">
                      <table  id="datatable" class="table table-striped jambo_table bulk_action">
                        <thead>
                          <tr class="headings">
                            <th class="check" style="width: 35px">
                              <input type="checkbox" id="check-all" class="flat">
                            </th>
                            <th class="column-title" id="">날짜 </th>
                            <th class="column-title" id="">거래자명 </th>
                            <th class="column-title" id="">거래내용 </th>
                            <th class="column-title" id="">출금 </th>
                            <th class="column-title" id="">입금 </th>
                            <th class="column-title" id="">분류 </th>
                            <th class="column-title" id="">관련 일정 </th>
                            <th class="column-title" id="" style="width: 200px">메모 </th>
                            <th class="column-title" id="" style="width: 60px"></th>
                            <th class="bulk-actions" colspan="9">
                              <a class="antoo" style="color:#fff; font-weight:500;">Bulk Actions ( <span class="action-cnt"> </span> ) <i class="fa fa-chevron-down"></i></a>
                            </th>
                          </tr>
                        </thead>
                        
                        <tbody>
                         <tr class="odd pointer">
                            <td class="a-center" style="width: 36px">
                            
                            </td>
                            <td class=" "><input type="text" name="tranDate" class="inputbox"></td>
                            <td class=" "><input type="text" name="tranName" class="inputbox"></td>
                            <td class=" "><input type="text" name="tranData" class="inputbox"></td>
                            <td class=" "><input type="text" name="withdrawal" class="inputbox" value=0></td>
                            <td class=" "><input type="text" name="deposit" class="inputbox" value=0></td>
                            <td class=" "><select name="accountName">
                            				<option value="미분류"></option>
                            				<option value="회식">회식</option>
                            				<option value="행사">행사</option>
                            				<option value="비품">비품</option>
                            				<option value="회비">회비</option>
                            				<option value="모임">모임</option>
                            				<option value="의류">의류</option>
                            				<option value="문화">문화</option>
                            				<option value="교육">교육</option>
                            				<option value="교통">교통</option>
                            				<option value="기타">기타</option></select></td>                				
                            <td class=" "><select name="eventNo">
                                        <option value=""> </option>
                            			<c:forEach var="dto" items="${eventList}">
                            				<option value="${dto.eventName}">${dto.eventName}</option>
                            			</c:forEach>
                            			</select></td>
                            <td class=" " style="width: 200px"><input type="text" name="memo" class="inputbox"></td>
                            <td class=" " style="width: 60px"><button type="submit" class="btn">확인</button></td>
                          </tr>
                          
                          <c:forEach var="dto" items="${list}">
                          <tr class="even pointer" id="row_${dto.transactionNo}">
                            <td class="a-center" style="width: 35px">
                              <input type="checkbox" class="flat" name="table_records" value="${dto.transactionNo}">
                            </td>
                            <td class=" ">${dto.tranDate}</td>
                            <td class=" ">${dto.tranName}</td>
                            <td class=" ">${dto.tranData}</td>
                            <td class=" ">${dto.withdrawal}</td>
                            <td class=" ">${dto.deposit}</td>
                            <td class=" ">
                            <c:if test="${not empty dto.accountName}">
                            <a style="cursor:pointer;" onclick="cateList('${dto.accountName}');">
                            	<c:if test="${dto.accountName=='미분류'}">
                            		<i class="yellow"><i class="fa fa-exclamation-triangle"></i></i>
                            	</c:if>
                            ${dto.accountName}
                            </a>
                            </c:if>
                            </td>
                            <td class=" ">
                            <a style="cursor:pointer;" onclick="eventList('${dto.eventNo}');">
                            <c:if test="${not empty dto.eventNo}">
                            <i class="fa fa-calendar"></i>
                            </c:if>
                             ${dto.eventNo}</a></td>
                            <td class=" " style="width: 200px">${dto.memo}</td>
                            <td class=" " style="width: 60px"><button type="button" class="btn btn-default btn-sm" onclick="updateMoney('${dto.transactionNo}')">수정</button></td>
                          </tr>
                          </c:forEach>
                        </tbody>
                      </table>
                      </div>
                      	<button type="button" class="btn btn-default btn-sm" onclick="deleteList();">선택삭제</button>
                      	<button type="button" class="btn btn-default btn-sm" onclick="fn_Print();"><i class="fa fa-print"></i> 인쇄</button>
                      	<div style="float:right;">
                      		<input type="text" name="start" id="start" placeholder="20160501" style="width:80px;">
                      		<i class="fa fa-ellipsis-h"></i>
                      		<input type="text" name="end" id="end" placeholder="20160531" style="width:80px;">
                      		<button type="button" class="btn btn-default btn-sm" onclick="searchList();"><i class="fa fa-calendar"></i> 일자별 내역 조회</button>
                      		<button type="button" class="btn btn-default btn-sm" onclick="allList();"><i class="fa fa-database"></i> 전체 내역 조회</button>
                      	</div>
                    </div>
                    	<input type="hidden" name="year" id="year" value="${year}">
                    	<input type="hidden" name="month" id="month" value="${month}">
                    	<input type="hidden" name="balance" id="balance" value="${balance}">
                    	
                   </form>
                  </div>
                </div>
              </div>
            </div>
         <!-- /입출금 리스트 -->
         
          <div id="searchList"></div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" style="padding-top:100px;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">
					<i class="fa fa-share-alt"></i> 사용 내역 엑셀 업로드
				</h4>
			</div>
			<div class="modal-body">
				<h5><i class="fa fa-envelope"></i> 금융사, 국세청에서 제공하는 이용 내역 엑셀 파일로 업로드 하실 수 있습니다.</h5>
				<p>※현재는 우리은행만 지원하고 있습니다.</p>

				<form name="uploadForm" method="post" onsubmit="return check_upload();" enctype="multipart/form-data">
					은행사 선택 <select name="bank" class="upload_select">
                            				<option value="form">선택안함</option>
                            				<option value="woori">우리은행</option>
                            				<option value="sinhan" disabled="disabled">신한은행</option>
                            				<option value="kb" disabled="disabled">국민은행</option>
                            				<option value="nh" disabled="disabled">농협은행</option></select>
                    <br />
                    <br />
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-envelope"></i></span>
						<input type="file" name="upload" class="form-control input-sm">
					</div>
					<button type="submit" class="btn btn-primary"> 확인 <span class="glyphicon glyphicon-ok"></span></button>
					<br />
				</form>
				 <br />
				

					<input type="button" class="btn btn-primary" value="엑셀 폼 다운로드" onclick="javascript:location.href='<%=cp%>/account/download/${url}';">
						 폼에 작성하시면 자유롭게 엑셀 업로드로 작성 내역을 불러올 수 있습니다.
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>



<!-- receipt Modal -->
<div class="modal fade" id="receiptModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" style="padding-top:100px;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span><span class="sr-only">Close</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">
					<i class="fa fa-share-alt"></i> 영수증
				</h4>
			</div>
			<div class="modal-body">
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>


<script src="<%=cp%>/res/js/admin/icheck.min.js"></script> <!-- 리스트부분 css임--> 