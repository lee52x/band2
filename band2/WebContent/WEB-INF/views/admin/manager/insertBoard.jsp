<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">

<style>
.tabs-left>li>a {
    background: rgba(105, 139, 199, 0.15);
}
</style>
<script type="text/javascript">

function deleteBoard(f){
	var str=f.boCateName.value;
	if(!str){
		f.boCateName.focus();
        alert("미입력 자료가 있습니다.");
	}
	
	var n=f.boCateNum.value;
	if(!n) {
        f.boCateNum.focus();
        alert("미입력 자료가 있습니다.");
    }
	
	str=f.boCateType.value;
	if(!str){
		f.boCateType.focus();
        alert("미입력 자료가 있습니다.");
	}
	
	
	if(confirm("지우시겠습니까?")){
		f.action="<%=cp%>/manager/insertBoard/delete2/${url}";
		f.submit();
	}
	
	
}

function updateSubmit(f){
	
	
	var n=f.boCateNum.value;
	
	if(!n) {
        f.boCateNum.focus();
        alert("미입력 자료가 있습니다.");
    }
	
	var str=f.boCateName.value;
	
	if(!str){
		f.boCateName.focus();
        alert("미입력 자료가 있습니다.");
	}
	
	str=f.boCateType.value;
	if(!str){
		f.boCateType.focus();
        alert("미입력 자료가 있습니다.");
	}
	
	if(confirm("수정하시겠습니까?")){
		f.action="<%=cp%>/manager/insertBoard/update/${url}";
		f.submit();
	}
	
}

function insertSubmit(){
	
	var f=document.insertBoard;
	
	
	var str=f.boCateName.value;
	if(!str){
		f.boCateName.focus();
        alert("미입력 자료가 있습니다.");
        return false;
	}
	
	str=f.boCateType.value;
	if(!str){
		f.boCateType.focus();
        alert("미입력 자료가 있습니다.");
        return false;
	}
	
	if(confirm("게시판을 추가하시겠습니까?")){
		f.action="<%=cp%>/manager/insertBoard/insert/${url}";
		return true;
	}
	
	return false;
	
}

</script>

<div class="col-md-8 col-sm-12 col-xs-12 col-md-offset-2">
<div class="x_panel">
	<div class="x_title">
		<h2><i class="fa fa-bars"></i><small style="font-weight: bold;">
			 게시판 관리
			</small>
		</h2>
		<div class="clearfix"></div>
	</div>

	<div class="x_content">

		<div class="col-xs-3">
			<!-- required for floating -->
			<!-- Nav tabs -->
			<ul class="nav nav-tabs tabs-left">
				<c:forEach items="${list}" var="dto" varStatus="state">
					<li ${state.index==0?"class='active'":""}>
					<a href="#tab${dto.boCateNum}" data-toggle="tab">${dto.boCateName}(${dto.boCateType})</a>
					</li>
				</c:forEach>
					<li>
					<a href="#tab_insert" data-toggle="tab" style="background-color: rgba(173, 179, 189, 0.15);">게시판 추가</a>
					</li>

			</ul>
		</div>

		<div class="col-xs-9">
			<!-- Tab panes -->
			<div class="tab-content">
				<c:forEach items="${list}" var="vo" varStatus="state">
					<div ${state.index==0?"class='tab-pane active'":"class='tab-pane'"} id="tab${vo.boCateNum}">

						<div class="x_content">
							<br />
							<br><br><br>
							<form class="form-horizontal form-label-left" name="updateBoard${vo.boCateNum}" method="post">
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">
										게시판 이름
									</label>
									<div class="col-md-6 col-sm-9 col-xs-12">
										<input type="text" class="form-control" name="boCateName"
											value="${vo.boCateName}">
									</div>
								</div>
								<div class="form-group">
									<div class="col-md-6 col-sm-9 col-xs-12">
										<input type="hidden" class="form-control" name="boCateNum"
											value="${vo.boCateNum}">
									</div>
								</div>
								
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">
										게시판 유형
									</label>
									<div class="col-md-6 col-sm-9 col-xs-12">
										<select class="form-control" name="boCateType">
											<option>사진</option>
											<option>자유</option>
											<option>방명록</option>
										</select>
									</div>
								</div>
								<div class="ln_solid"></div>
								<div class="form-group">
									<div class="col-md-9 col-sm-9 col-xs-12 col-md-offset-4">
									<br><br>
										<button type="button" class="btn btn-success btn-sm" onclick="updateSubmit(form);">수정 완료</button>
										<button type="button" class="btn btn-default btn-sm" onclick="deleteBoard(form);">게시판 삭제</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</c:forEach>
				
				<div class="tab-pane" id="tab_insert">

						<div class="x_content">
							<br/>
							<br><br><br>
							<form class="form-horizontal form-label-left" name="insertBoard"
								onsubmit="return insertSubmit();" method="post">

								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">
										게시판 이름
									</label>
									<div class="col-md-6 col-sm-9 col-xs-12">
										<input type="text" class="form-control" name="boCateName">
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-md-3 col-sm-3 col-xs-12">
										게시판 유형
									</label>
									<div class="col-md-6 col-sm-9 col-xs-12">
										<select class="form-control" name="boCateType">
											<option>사진</option>
											<option>자유</option>
											<option>방명록</option>
										</select>
									</div>
								</div>
								<div class="ln_solid"></div>
								<div class="form-group">
									<div class="col-md-6 col-sm-9 col-xs-12 col-md-offset-4">
									<br><br>
										<button type="submit" class="btn btn-success btn-sm">등록 완료</button>
										<button type="reset" class="btn btn-default btn-sm">다시 작성</button>
									</div>
								</div>
							</form>
						</div>
					</div>

			</div>
		</div>

		<div class="clearfix"></div>

	</div>
</div>
</div>