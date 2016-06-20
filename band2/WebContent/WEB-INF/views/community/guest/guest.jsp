<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp=request.getContextPath();
%>





   
   <link type="text/css" href="<%=cp%>/res/css/bootstrap-responsive.min.css" rel="stylesheet">
   
   <link type="text/css" href="<%=cp%>/res/css/font-awesome.css" rel="stylesheet">
   

<style type="text/css">

/* 배경 틀 안에 넣기! */
 .customBG{
   border-radius: 4px;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05), 0 0 0 1px rgba(63, 63, 68, 0.1);
    background-color: #FFFFFF;
    margin-bottom: 30px;
 }
 
 .btn{
	border:none; 
	color:#000; 
	background-color: #fbdf80;"
}
 
 
 
#content:hover{
	background-color: #fbdf80;
}

#player:hover{
	background-color: #fbdf80;
}
 
</style>

<script type="text/javascript">




function howYoutube(){
   
   $("#howYoutube").modal("show");
}


function insertPlayer(){
   var f=document.modalYoutubee;
   
   if(!f.player.value){
      f.address.focus();
      return false;
   }
   
   var player=f.player.value;
   
   f.action="<%=cp%>/guestBoard/player/${url}?"+player;
   f.submit();
   
   
}


function modalyoutube(){
   
   $("#modalyoutube").modal("show");
   
}



function login() {
   location.href="<%=cp%>/group/${url}";
}
//댓글리스트
$(function(){
   listPage(1);
});

function listPage(page){
   var url="<%=cp%>/guestBoard/listGuest/${url}";
   
   $.post(url,{pageNo:page},function(data){
      $("#guestList").html(data);
   });
}

//방명록 게시글 추가
function sendGuest() {
   var uid="${sessionScope.main.userId}";
   if(!uid){
      login();
      return false;
   }
   var guestNo="${dto.guestNo}";
   var content=$.trim($("#content").val());
   var youtube=$.trim($("#player").val());
   
   if(! content ){
      alert("내용을 입력하세요!!!");
      $("#content").focus();
      return false;
   }
   
   var f=document.guestForm;
    var formData = new FormData(f);
   
   $.ajax({
      type:"POST"
      ,url:"<%=cp%>/guestBoard/created/${url}"
       ,processData: false  // file 전송시 필수
       ,contentType: false  // file 전송시 필수
       ,data: formData
      ,dataType:"json"
      ,success:function(data){
         $("#content").val("");
         $("#player").val("");
         
         var state=data.state;
         if(state=="true"){
            listPage(1);
         }else if(state=="false"){
            alert("글을 등록하지 못했습니다.");
         }else if(state="loginFail"){
            login();
         }
      }
      ,error:function(e){
         alert(e.responseText);
      }
   });
}

//좋아요 개수
function countLike(guestNo){
   var url="<%=cp%>/guestBoard/countLike/${url}";
   $.post(url,{guestNo:guestNo},function(data){

      var likeCountId="#likeCount"+guestNo;
      var likeCount=data.likeCount;
      $(likeCountId).html(likeCount);
      
   },"JSON");
}


//좋아요 추가
function sendLike(guestNo,guestLike){
   var uid="${sessionScope.main.userId}";
   if(! uid){
      login();
      return false;
   }
   
   if(guestLike==1)
      msg="게시물에 공감하십니가?";
   if(! confirm(msg))
      return false;
   

   
   var params="guestNo="+guestNo;
   params+="&guestLike="+guestLike;
   
   $.ajax({
      type:"POST"
      ,url:"<%=cp%>/guestBoard/guestLike/${url}"
      ,data:params
      ,dataType:"json"
      ,success:function(data){
         var state=data.state;
         
         if(state=="true"){
            countLike(guestNo);
         }else if(state="false"){
            alert("좋아요는 한번만 가능합니다");
         }else if(state="loginFail"){
            login();
         }
      }
      ,error:function(e){
         alert(e.responseText);
      }
   });
}

function deleteGuest(guestNo,imageFilename){
   if(!  confirm("삭제하시겠습니까?")) {
      return;
   }
   
   var params="guestNo="+guestNo+"&imageFilename="+imageFilename;
   $.ajax({
      type:"POST"
      ,url:"<%=cp%>/guestBoard/delete/${url}"
      ,data:params
      ,dataType:"json"
      ,success:function(data){
         var state=data.state;
         if(state=="true"){
            listPage(1);
         }else if(state=="false"){
            alert("글을 삭제하지 못했습니다.");
         }else if(state="loginFail"){
            login();
         }
      }
      ,error:function(e){
         alert(e.responseText);
      }
   });
      
}

</script>




   <div class="customBG">
      <div class="container" style="width:870px;">
         <div class="row" >
         
         
            <div class="span9" style="margin-left:0px">
               <div class="content">
<br><br>
                  <div class="module">
                     <div class="title" style="color:#5d5d5d; font-weight: bold; font-size: 22px; text-align: center">너의 개그를 뽐내줘</div>
                     <div class="module-head" style="text-align:center; vertical-align:middle; color:#5d5d5d;">
                        <span style="padding-left: 10px;">간단하게 글을 남겨보세요.</span>
                     </div>
                     <!-- <div class="module-body"> -->
                        <div class="stream-composer media">
                        
                        <BR>
                        <!-- 원래 여기 아래 div 태그에 class="media-body"가 적용됐었음 -->
                          <div  >
                           
                           <form name="guestForm" method="post" enctype="multipart/form-data">
                              <div class="row-fluid" >
                                 <textarea class="span12" id="content" name="content" placeholder="무슨 생각을 하고 계신가요?" style="height: 70px;"></textarea>
                              </div>
                              <br>
                     <p style="color:#8c8c8c;"><img src="<%=cp%>/res/img/community/youtube.png" style="width:24px; height: 24px;"/ >&nbsp;Youtube 링크 <a href="javascript:howYoutube();"><i class="icon-question-sign shaded" style="color: #334e7e"></i></a></p>
                    
                     <input style="margin-left:0px; width:870px; height: 30px; margin-bottom: 23px;" type="text" class="span12" id="player" name="player" placeholder="주소" >
                    <br><br>
                    
                     <p style="color:#8c8c8c;"><img src="<%=cp%>/res/img/community/image.png" style="width:24px; height: 24px;"/ >&nbsp;Image 등록</p>
                    
                 
                    <input type="file" name="upload" class="btn-small">
                    <button class="btn btn-primary pull-right" type="button" onclick="sendGuest();">글올리기</button>
                    
                              
                              </form>
                              
                              
                              
                              
                          </div>
                        </div>
<hr style="margin-top: 20px; border-top: 1px solid #BDBDBD;">
                        <div id="guestList"></div>
                        
                                    
                                    </div>
                                    </div>
                                    </div>
                                    </div>
                                    </div>
                                    </div>
                              
                                    
                                    
   <div class="modal fade" id="howYoutube">
  <div class="modal-dialog">
    <div class="modal-content">
     
      <!-- header -->
      <div class="modal-header" style="background-color: #334E7E">
        <!-- 닫기(x) 버튼 -->
        <button type="button" class="close" data-dismiss="modal" ><span aria-hidden="true">×</span></button>
        <!-- header title -->
        <h4 class="modal-title" id="myModalLabel" style="color:#FFF;font-size: 20px; font-weight: bold;word-spacing: 100;" >Youtube 공유 방법</h4>
      </div>
      
      <!-- body -->
      
      <div class="modal-body" style="background-color: #FFFFFF">
      1. Youtube에 원하는 동영상 클릭<br><br>
      2. 주소창의 뒤의  고유코드 붙여넣기<br>

      </div>
</div>
</div>
</div>












            

   <script src="<%=cp%>/res/scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
   <script src="<%=cp%>/res/scripts/jquery-ui-1.10.1.custom.min.js" type="text/javascript"></script>
   <script src="<%=cp%>/res/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>