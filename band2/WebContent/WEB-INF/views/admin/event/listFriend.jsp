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
              ${dto.name}
				<c:choose>
					<c:when test="${dto.grade == 1}">그룹장</c:when>
					<c:when test="${dto.grade == 2}">운영진</c:when>
					<c:when test="${dto.grade == 3}">일반회원</c:when>
					<c:when test="${dto.grade == 4}">OB회원</c:when>
					<c:when test="${dto.grade == 5}">비활동회원</c:when>
				</c:choose>
          </td>
     </tr>
</c:forEach>
