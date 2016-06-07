<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String cp=request.getContextPath();
%>

<c:forEach var="dto" items="${listFriend}">
    <tr height='25' data-tid='${dto.memberNo}'>
          <td align='center' width='30'>
              <input type='checkbox' value='${dto.memberNo}' >
          </td>
          <td align='left' width='200'>
          		<!-- 등급별 라벨 표시하기 -->
				<c:choose>
					<c:when test="${dto.grade == 1}"><div class="btn btn-danger btn-xs">그룹장</div></c:when>
					<c:when test="${dto.grade == 2}"><div class="btn btn-warning btn-xs">운영진</div></c:when>
					<c:when test="${dto.grade == 3}"><div class="btn btn-info btn-xs">일　반</div></c:when>
					<c:when test="${dto.grade == 4}"><div class="btn btn-success btn-xs">O　&nbsp;&nbsp;B</div></c:when>
					<c:when test="${dto.grade == 5}"><div class="btn btn-default btn-xs">미가입</div></c:when>
				</c:choose>
              
              <!-- 이름 뒤에 userId 나오도록! -->
              <c:choose>
					<c:when test="${dto.userId==null}"><span>${dto.name}</span></c:when>
					<c:otherwise><span>${dto.name} (${dto.userId})</span></c:otherwise>
			  </c:choose>
          </td>
     </tr>
</c:forEach>
