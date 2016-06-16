<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>



<!-- 공지사항 목록 -->
<div class="row">
	<div class="x_content">
		<table class="table jambo_table bulk_action">
			<thead>
				<tr>
					<th>글 번호</th>
					<th>공지사항 내용</th>
					<th>게시한 날짜</th>
					<th>게시 종료 날짜</th>
					<th>게시 현황</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="dto" items="${list}">
				<tr>
					<th scope="row">${dto.listNum}</th>
					<td>
					<a href="javascript:noticeModal('${dto.noticeNo}', '${dto.content}', '${dto.endDate}');"
					data-toggle="modal" style="font-weight: bold;">
					<span style="text-decoration: underline;">${dto.content}</span>
					</a>
					</td>
					<td>${dto.created}</td>
					<td>${dto.endDate}</td>
					<td>
						<c:if test="${dto.isNotice==1}">
							<a style="color:#1ABB9C;">게시 중</a>
						</c:if>
						<c:if test="${dto.isNotice==0}">
							<a style="color:red;">게시 종료</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</div>


					<!-- 회원 상세정보 모달 시작 -->
					<div class="modal fade bs-example-modal-lg" id="noticeModal"
						tabindex="-1" role="dialog" aria-hidden="true"  style="padding-top:100px;">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
								<div class="modal-header" style="background-color: #334e7e;">
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true"  style="color: white;">×</span>
									</button>
									<h4 class="modal-title" id="myModalLabel">
									<small style="font-weight: bold; color: #e1e2e3;">공지사항 수정</small></h4>
								</div>
								<div class="modal-body">
								<small style="color: grey;">※공지사항을 수정하고 삭제할 수 있습니다.</small><br>
									<form class="form-horizontal form-label-left input_mask">
									<br><br>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12">글 번호:</label>
											<div class="col-md-6 col-sm-9 col-xs-12">
												<input id="modalNoticeNo" type="text" class="form-control" readonly="readonly">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12">글 내용:</label>
											<div class="col-md-6 col-sm-9 col-xs-12">
												<input id="modalContent" type="text" class="form-control">
											</div>
										</div>
										<div class="form-group">
											<label class="control-label col-md-3 col-sm-3 col-xs-12">게시 종료일:</label>
											<div class="col-md-6 col-sm-9 col-xs-12">
												<input id="modalEndDate" type="date" class="form-control">
											</div>
										</div>
										<br><br>
									</form>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default btn-sm" onclick="deleteNotice()">삭제하기</button>
									<button type="button" class="btn btn-success btn-sm" onclick="updateNotice()">수정하기</button>
								</div>
							</div>
						</div>
					</div>
					<!-- 회원 상세정보 모달 끝 -->
					
					
