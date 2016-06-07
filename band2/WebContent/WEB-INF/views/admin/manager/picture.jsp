<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
function check() {
    var f = document.pictureForm;

	f.action="<%=cp%>/admin/manager/picture/created/${url}";

    return true;
}

function deletePicture(){
	
	var url="<%=cp%>/admin/manager/picture/delete2/${url}";

	
	if(confirm("대표사진들을 삭제하시겠습니까?"))
		location.href=url;
}

</script>



    <!-- Dropzone.js -->
    <link href="<%=cp%>/res/css/communityManager/dropzone.css" rel="stylesheet">
	<link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">



			<!-- 대표사진 등록 -->
            <div class="x_panel">
            	<div class="x_title">
                    <h2>사진 업로더</h2>
                    <div class="clearfix"></div>
                </div>
                
                <div class="x_content">
                <p>커뮤니티 메인에 쓰일 사진을 선택해주세요.</p>
           		<form name="pictureForm" method="post" onsubmit="return check();" enctype="multipart/form-data">
            	<div class="bs-write">
                <table class="table">
                    <tbody>
                        <tr>
                            <td class="td1">대표 이미지</td>
                            <td colspan="3" class="td3">
                                <input type="file" name="upload1" class="form-control input-sm">
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="td1">이미지 1</td>
                            <td colspan="3" class="td3">
                                <input type="file" name="upload2" class="form-control input-sm">
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="td1">이미지 2</td>
                            <td colspan="3" class="td3">
                                <input type="file" name="upload3" class="form-control input-sm">
                            </td>
                        </tr>
				       
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="4" style="text-align: center; padding-top: 15px;">
                                  <button type="submit" class="btn btn-primary"> 확인 <span class="glyphicon glyphicon-ok"></span></button>
                                  <button type="button" class="btn btn-danger" onclick="javascript:location.href='<%=cp%>/photo/list';"> 취소 </button>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
       		</form>
            </div>
            </div>
            
            <!-- 현재 커뮤니티 대표 사진 표시 -->
             <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>현재 대표 사진</h2>
                    <div class="clearfix"></div>
                  </div>
                  
                  <div class="x_content">
                    <p>현재 설정되어 있는 대표 사진들입니다.</p>
                   	<c:forEach var="dto" items="${list}">
                   		 <tr style="border-bottom:none;">
                         <td colspan="2">
                             <img src="<%=cp%>/uploads/management/${dto.saveFilename}" style="max-width:100%; height:auto; resize:both;">
                         </td>
                     	</tr>
                   	</c:forEach>
                   
                  </div>
                  
                 <div class="form-group">
                        <div class="col-md-6 col-md-offset-3">
                          	<button type="button" class="btn btn-danger" onclick="deletePicture();">현재 대표사진 삭제</button>
                        </div>
             	 </div>
                  
                </div>
              </div>
            </div>
            
          
          
          
        <!-- /page content -->
    

    <!-- Dropzone.js -->
    <script src="<%=cp%>/res/js/communityManager/dropzone.js"></script>
