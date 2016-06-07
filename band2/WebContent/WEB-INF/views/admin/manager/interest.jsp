<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<link href="<%=cp%>/res/css/communityManager/prettify.min.css" rel="stylesheet">
<link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">

<div class="row">
	<div class="x_content">
		<table class="table">
			<thead>
				<tr>
					<th>관심 순위</th>
					<th>해쉬 이름</th>
					<th>해쉬 개수</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="dto" items="${list}">
				<tr>
					<th scope="row">${dto.listNum}</th>
					<td>${dto.content}</td>
					<td>${dto.created}</td>
					<td>${dto.endDate}</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</div>