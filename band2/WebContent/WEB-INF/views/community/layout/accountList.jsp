<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
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
                          <c:forEach var="dto" items="${accountList}">
                          <tr class="even pointer">
                            <td class=" ">${dto.tranDate}</td>
                            <td class=" ">${dto.tranName}</td>
                            <td class=" ">${dto.tranData}</td>
                            <td class=" ">${dto.withdrawal}</td>
                            <td class=" ">${dto.deposit}</td>
                            <td class=" ">
                            <c:if test="${not empty dto.accountName}">
                            ${dto.accountName}
                            </c:if>
                            <c:if test="${empty dto.accountName}">
                            <i class="yellow"><i class="fa fa-exclamation-triangle"></i></i> 미분류
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
                        </tbody> 
                      </table>