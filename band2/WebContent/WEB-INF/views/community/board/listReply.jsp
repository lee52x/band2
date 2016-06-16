<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<table style='width: 800px; border-spacing: 0px; border-collapse: collapse; margin: 0px auto;'>

<c:forEach var="dto" items="${list}">
<tr height='50' style='border: 1px solid #DBDBDB; background-color: rgba(251, 223, 128, 0.28);'>
    <td width='50%' style='padding-left: 5px;'>
        ${sessionScope.main.userId}
    </td>
    <td width='50%' align='right' style='padding-right: 5px;'>
        ${dto.created}
        <c:if test="${sessionScope.main.userId==dto.userId}">
		<a onclick='deleteReply("${dto.replyNum}", "${pageNo}");'
		   style="color:red; cursor: pointer;" >&nbsp;삭제</a>
		</c:if>
    </td>
</tr>
<tr height='50' style="border: 1px solid #DBDBDB;">
    <td colspan='2' style='padding: 10px;' valign='top'>
       ${dto.content}
    </td>
</tr>
</c:forEach> 
</table>
<br><br><br>