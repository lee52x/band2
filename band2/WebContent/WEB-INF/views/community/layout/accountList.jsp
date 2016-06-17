<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<table id="datatable-buttons" class="table table-striped jambo_table bulk_action">
                        <thead style="background-color: #fbdf80;">
                          <tr class="headings">
                            <th class="column-title" style="text-align: center; color:black;">날짜 </th>
                            <th class="column-title" style="text-align: center; color:black;">거래자명 </th>
                            <th class="column-title" style="text-align: center; color:black;">거래내용 </th>
                            <th class="column-title" style="text-align: center; color:black;">출금 </th>
                            <th class="column-title" style="text-align: center; color:black;">입금 </th>
                            <th class="column-title" style="text-align: center; color:black;">분류 </th>
                            <th class="column-title" style="text-align: center; color:black;">관련 일정 </th>
                            <th class="column-title" style="text-align: center; color:black; width:150px;">메모 </th>
                          </tr>
                        </thead>
                        
                        <tbody>
                          <c:forEach var="dto" items="${accountList}">
                          <tr class="even pointer">
                            <td style="text-align: center;">${dto.tranDate}</td>
                            <td style="text-align: center;">${dto.tranName}</td>
                            <td style="text-align: center;">${dto.tranData}</td>
                            <td style="text-align: center;">${dto.withdrawal}</td>
                            <td style="text-align: center;">${dto.deposit}</td>
                            <td style="text-align: center;">
                            <c:if test="${not empty dto.accountName}">
                            ${dto.accountName}
                            </c:if>
                            <c:if test="${empty dto.accountName}">
                            <i class="yellow"><i class="fa fa-exclamation-triangle"></i></i> 미분류
                            </c:if>
                            
                            </td>
                            <td style="text-align: center;">
                            <a href="#">
                            <c:if test="${not empty dto.eventNo}">
                            <i class="fa fa-calendar"></i>
                            </c:if>
                             ${dto.eventNo}</a></td>
                            <td style="text-align: center;">${dto.memo}</td>
                          </tr>
                          <input type="hidden" name="transactionNo" value="${dto.transactionNo}">
						</c:forEach>
                        </tbody> 
                      </table>