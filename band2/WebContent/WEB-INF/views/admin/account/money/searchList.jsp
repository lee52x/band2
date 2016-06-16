<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style>
	table{
		border-collapse:collapse;
		width:100%;
	}
	
	thead{
		float:left; 
		width:1574px; 
	}
	
	tbody{
		overflow-y:auto;
		overflow-x:hidden;
		float:left;
		width:1574px;
		height:400px;
	}
	
	tr{
		display:table;
		width:1574px;
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
	#x_panel{
		height:400px;
	}
</style>


<script type="text/javascript">
  
  function search_Print()
	{ 
	 document.body.innerHTML = s_table.innerHTML;   //taskInfoGrid는 출력하고자 하는 table이나 div  id이다.
	 window.print(); 
	}
  
  function check() {
      var f = document.listForm;
      f.action="<%=cp%>/account/noticeAccount/${url}";
      return true;
	}
 </script>
    	<div class="left_col" role="main" style="min-height:1300px;"> 
              <div class="clearfix"></div>
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <small style="font-weight: bold;">상세 조회 내역</small>
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
                      <li><a href="<%=cp%>/account/main/${url}"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>

                  <div class="x_content">
					<form name="listForm" method="post" onsubmit="return check();">
                    <h1 style="text-align:center; padding-right:170px;">
                     	<button type="button" class="btn btn-default btn-sm" onclick="search_Print();" style="float:left;"><i class="fa fa-print"></i> 인쇄</button>
                     	<button type="submit" class="btn btn-default btn-sm" style="float:left;"><i class="fa fa-share-square-o"></i> 커뮤니티 게시</button>
                    	<c:if test="${not empty start}">
                    	${start}~${end}
                    	</c:if>
                    	<c:if test="${not empty category}">
                    	${category}
                    	</c:if>
                    	<c:if test="${not empty event}">
                    	${event}
                    	</c:if>
                    	<c:if test="${not empty all}">
                    	${all}
                    	</c:if>
                    </h1>
			
                    <div class="table-responsive">
                     <div id="s_table">
                      <table id="datatable-buttons" class="table table-striped jambo_table bulk_action">
                        <thead>
                          <tr class="headings">
                            <th class="column-title" id="">날짜 </th>
                            <th class="column-title" id="">거래자명 </th>
                            <th class="column-title" id="">거래내용 </th>
                            <th class="column-title" id="">출금 </th>
                            <th class="column-title" id="">입금 </th>
                            <th class="column-title" id="">분류 </th>
                            <th class="column-title" id="">관련 일정 </th>
                            <th class="column-title" id="" style="width: 200px">메모 </th>
                          </tr>
                        </thead>
                        
                        <tbody>
                          <c:forEach var="dto" items="${list}">
                          <tr class="even pointer">
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
                            <a href="#">
                            <c:if test="${not empty dto.eventNo}">
                            <i class="fa fa-calendar"></i>
                            </c:if>
                             ${dto.eventNo}</a></td>
                            <td class=" " style="width: 200px">${dto.memo}</td>
                          </tr>
                          <input type="hidden" name="transactionNo" value="${dto.transactionNo}">
						</c:forEach>
							<c:if test="${not empty start}">
                    		<input type="hidden" name="listName" value="${start}~${end}">
                    		</c:if>
							<c:if test="${not empty category}">
                    		<input type="hidden" name="listName" value="${category}">
                    		</c:if>
							<c:if test="${not empty event}">
                    		<input type="hidden" name="listName" value="${event}">
                    		</c:if>
							<c:if test="${not empty all}">
                    		<input type="hidden" name="listName" value="${all}">
                    		</c:if>
                        </tbody> 
                      </table>
                     </div>
                    </div>
                   </form>
                  </div>
                </div>
              </div>
            </div>
         <!-- /입출금 리스트 -->