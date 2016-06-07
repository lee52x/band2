<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>


 
  
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<!-- Optional theme -->

<style>
.modal-backdrop {
	position: relative;
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
	
	f.action="<%=cp%>/guest/player/${url}?"+player;
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
	var url="<%=cp%>/guest/listGuest/${url}";
	
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
		,url:"<%=cp%>/guest/created/${url}"
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
	var url="<%=cp%>/guest/countLike/${url}";
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
		,url:"<%=cp%>/guest/guestLike/${url}"
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
		,url:"<%=cp%>/guest/delete/${url}"
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




<body>



  <div class="well"> 
               <form class="form-horizontal" name="guestForm" role="form"  method="post" enctype="multipart/form-data" >
                       <h4>방명록</h4>
                    <div class="form-group" style="padding:14px;">
                    <textarea class="form-control" rows="3" id="content"  name="content" placeholder="무슨 생각을 하고 계신가요?">
                    </textarea>
                    <br>
                     Youtube링크 <a href="javascript:howYoutube();"><i class="glyphicon glyphicon-question-sign"></i></a>
                     <br>
                     <input type="text" class="form-control" id="player" name="player" placeholder="주소">
                    <br>
                    <br>
                  	사진등록<br>
                    <button class="btn btn-primary pull-right" type="button" onclick="sendGuest();">등록</button>
                 
                    <input type="file" name="upload">
                   </div>
				</form>
				
				
				
				
				
 </div>
                 <div id="guestList"></div>
                 
                 
                 
   <div class="modal fade" id="howYoutube">
  <div class="modal-dialog">
    <div class="modal-content">
     
      <!-- header -->
      <div class="modal-header">
        <!-- 닫기(x) 버튼 -->
        <button type="button" class="close" data-dismiss="modal" ><span aria-hidden="true">×</span></button>
        <!-- header title -->
        <h4 class="modal-title" id="myModalLabel" style="word-spacing: 100">유튜브 올리는 방법</h4>
      </div>
      
      <!-- body -->
      
      <div class="modal-body">
      1.Youtube에 원하는 동영상 클릭<br><br>
      2.사진과 같이 주소창의 맨뒤에  고유코드 붙여넣기<br>
      <hr>
<img src="<%=cp%>/res/img/kkkk.PNG" width="500" height="200">

      		
      			
      	
            
 
   
      
    </div>
  </div>
</div>
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 

