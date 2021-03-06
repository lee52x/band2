<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.bs-write table {
    width: 100%;
    border: 0;
    border-spacing: 0;
}
.table tbody tr td {
    border-top: none;
    font-weight: normal;
	font-family: NanumGothic, 나눔고딕, "Malgun Gothic", "맑은 고딕", 돋움, sans-serif;
} 
.bs-write table td {
	padding: 3px 3px 3px 3px;
}

.bs-write .td1 {
    min-width: 100px;
    min-height: 30px;
    color: #666;
    vertical-align: middle;
}

.bs-write .td2 {
}

.bs-write .td3 {
}

.bs-write .td4 {
}
</style>

<script type="text/javascript" src="<%=cp%>/res/se/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
  function check() {
        var f = document.boardForm;

    	var str = f.subject.value;
        if(!str) {
            f.subject.focus();
            return false;
        }

    	str = f.content.value;
        if(!str || str=="<p>&nbsp;</p>") {
            f.content.focus();
            return false;
        }

        var mode="${mode}";
    	if(mode=="created")
    		f.action="<%=cp%>/freeBoard/created/${boCateNum}/${url}";
    	else if(mode=="update")
    		f.action="<%=cp%>/freeBoard/update/${boCateNum}/${url}";

    	// <input type='submit' ..>,  <input type='image' ..>, <button>은 submit() 메소드 호출하면 두번전송
        return true;
 }
</script>

<!-- Start : Board List -->
<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card">
					<div class="header">
						<br><br>
						<div style="text-align: center;">
						<h4 class="title" style="color: #5D5D5D; font-weight: bold;'">${boardName}</h4>
						
						<p class="category">그룹 회원들과 자유롭게 소통하세요!</p>
						</div>
						
						<div class="content table-responsive table-full-width" style="width:95%; padding-left:130px;">
							<div>
        <form name="boardForm" method="post" onsubmit="return submitContents(this);" enctype="multipart/form-data">
            <div class="bs-write">
                <table class="table">
                    <tbody>
                        <tr>
                            <td class="td1" style="text-align: right;">작성자명</td>
                            <td class="td2 col-md-5 col-sm-5">
                                <p class="form-control-static">${sessionScope.main.userId}</p>
                            </td>
                            <td class="td1" align="center"></td>
                            <td class="td2 col-md-5 col-sm-5">
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="td1" style="text-align: right;">제목</td>
                            <td colspan="3" class="td3">
                                <input type="text" name="subject" class="form-control input-sm" value="${dto.subject}" required="required">
                            </td>
                        </tr>
                        
                        <tr>
                            <td colspan="4" class="td4">
                            	<textarea id="content" name="content" class="form-control" rows="15" style="max-width: 99%;">${dto.content}</textarea>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="td1" style="text-align: right;">첨부</td>
                            <td colspan="3" class="td3">
                                <input type="file" name="upload" class="form-control input-sm">
                            </td>
                        </tr>
                        
						<c:if test="${mode=='update'}">
                        <tr>
                            <td class="td1">등록파일</td>
                            <td colspan="3" class="td3">
                                ${dto.originalFilename}
                                <c:if test="${not empty dto.originalFilename}">
                                    | <a href="<%=cp%>/free/deleteFile?boardNo=${dto.boardNo}&page=${page}">삭제</a>
                                </c:if>
                            </td>
                        </tr>
						</c:if>                        
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="4" style="text-align: center; padding-top: 15px;">
                                  <button type="submit" class="btn btn-default btn-sm"
                                  style="background-color: #fbdf80; border:0; color:black;"> 확인</button>
                                  <button type="button" class="btn btn-default btn-sm"
                                  style="background-color: #fbdf80; border:0; color:black;" 
                                  onclick="javascript:location.href='<%=cp%>/freeBoard/list/${boCateNum}/${url}';"> 취소 </button>
                                  
                                  <c:if test="${mode=='update'}">
                                      <input type="hidden" name="boardNo" value="${dto.boardNo}">
                                      <input type="hidden" name="saveFilename" value="${dto.saveFilename}">
                                      <input type="hidden" name="originalFilename" value="${dto.originalFilename}">
                                      <input type="hidden" name="page" value="${page}">
                                  </c:if>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </form>
    </div>



						</div>
					</div>
				</div>
			</div>


		</div>
	</div>
</div>



<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "<%=cp%>/res/se/SmartEditor2Skin.html",	
	htParams : {bUseToolbar : true,
		fOnBeforeUnload : function(){
			//alert("아싸!");
		}
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["content"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	},
	fCreator: "createSEditor2"
});

function pasteHTML() {
	var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
}

function showHTML() {
	var sHTML = oEditors.getById["content"].getIR();
	alert(sHTML);
}
	
function submitContents(elClickedObj) {
	oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	
	// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
	
	try {
		// elClickedObj.form.submit();
		return check();
	} catch(e) {}
}

function setDefaultFont() {
	var sDefaultFont = '돋움';
	var nFontSize = 24;
	oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
}
</script>    
