<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String cp=request.getContextPath();
%>

<c:forEach var="dto" items="${listFriend}">
    <tr height='25' data-tid='${dto.userId}'>
          <td align='center' width='30'>
              <input type='checkbox' value='${dto.userId}' >
          </td>
          <td align='left' width='200'>
              ${dto.name}(${dto.userId})
          </td>
     </tr>
</c:forEach>
