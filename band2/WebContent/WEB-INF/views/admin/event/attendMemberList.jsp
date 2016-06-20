<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>



		<table class="table table-bordered">
			<thead>
				<tr>
					<th>이름</th>
					<th>회원등급</th>
					<th>전화번호</th>
					<th>메일주소</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="dto" items="${attendMemberList}">
					<tr>
						<td>${dto.name}</td>
						<td>				
						<c:choose>
							<c:when test="${dto.grade == 1}"><div class="btn btn-danger btn-xs">그룹장</div></c:when>
							<c:when test="${dto.grade == 2}"><div class="btn btn-warning btn-xs">운영진</div></c:when>
							<c:when test="${dto.grade == 3}"><div class="btn btn-info btn-xs">일　반</div></c:when>
							<c:when test="${dto.grade == 4}"><div class="btn btn-success btn-xs">O　&nbsp;&nbsp;B</div></c:when>
							<c:when test="${dto.grade == 5}"><div class="btn btn-default btn-xs">미가입</div></c:when>
						</c:choose></td>
						<td>${dto.tel}</td>
						<td>${dto.email}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#mailModal"><i class="fa fa-envelope-o"></i> 참석자 알림 메일 전송</button>
