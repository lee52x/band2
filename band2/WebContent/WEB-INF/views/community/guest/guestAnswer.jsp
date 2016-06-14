<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<c:if test="${not empty listReplyAnswer}">
    <c:forEach var="dto" items="${listReplyAnswer}">
								<div class="stream-respond" align="center" id="response">
												<div class="media stream" align="left">
													<a href="#" class="media-avatar small pull-left">
														<img src="<%=cp%>/res/img/user.png">
													</a>
													<div class="media-body">
														<div class="stream-headline">
															<h5 class="stream-author">
																${dto.name}
																<small>${dto.created}</small>
															</h5>
															<div class="stream-text">
																${dto.content}
															</div>
														</div><!--/.stream-headline-->
													</div>
												</div><!--/.media .stream-->
										
											</div><!--/.stream-respond-->
											
											  </c:forEach>
											  </c:if>
								