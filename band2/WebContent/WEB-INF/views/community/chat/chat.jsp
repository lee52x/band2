<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();

   String wsURL = "ws://"+request.getServerName()+":"+request.getServerPort()+cp+"/chat.msg";
%>

<style type="text/css">
#chatMsgContainer{
   clear:both;
   border: 1px solid #ccc;
   height: 277px;
   overflow-y: scroll;
   padding: 3px;
   width: 100%;
}
#chatMsgContainer p{
   padding-bottom: 0px;
   margin-bottom: 0px;
}
#chatConnectList{
	clear:both;
	width: 100%;
	height: 315px;
	text-align:left;
	padding:5px 5px 5px 5px;
	overflow-y:scroll;
    border: 1px solid #ccc;
}
</style>

<script type="text/javascript">
// -----------------------------------------------
// 채팅을 위한 Chat 객체 생성
var Chat = {};
Chat.socket = null;

// connect() 함수 정의 시작  -------------------
Chat.connect = (function(host) {
    // 서버에 접속 시도
    if ('WebSocket' in window) {
        Chat.socket = new WebSocket(host);
    } else if ('MozWebSocket' in window) {
        Chat.socket = new MozWebSocket(host);
    } else {
        Console.log('Error : WebSocket is not supported by this browser.');
        return false;
    }

    // 서버에 접속이 되면 호출되는 콜백함수
    Chat.socket.onopen = function () {
        Console.log('채팅방에 입장했습니다.');
        
        // 서버 접속이 성공 하면 아이디와 이름을 서버에 전송
        var userId = "${sessionScope.main.userId}";
        var userName = "${sessionScope.main.userName}";
        if(! userId) {
        	location.href="<%=cp%>/group/${url}";
        	return false;
        }
        var msg="conn:"+userId+":"+userName;
        Chat.socket.send(msg);
        
        // 채팅입력창에 메시지를 입력하기 위해 키를 누르면 호출되는 콜백함수
        document.getElementById('chatMsg').onkeydown = function(event) {
            // 엔터키가 눌린 경우, 서버로 메시지를 전송함
            if (event.keyCode == 13) {
                Chat.sendMessage();
            }
        };
    };

    // 연결이 끊어진 경우에 호출되는 콜백함수
    Chat.socket.onclose = function () {
    	// 채팅 입력창 이벤트를 제거함
        document.getElementById('chatMsg').onkeydown = null;
        Console.log('Info: WebSocket closed.');
    };

    // 서버로부터 메시지를 받은 경우에 호출되는 콜백함수
    Chat.socket.onmessage = function (message) {
    	var msg=message.data;
    	var ss=msg.split(":");
    	
    	if(ss[0]=="conn") {
    		var s=ss[1]+"("+ss[2]+") 님이 입장하였습니다.";
    		Console.log(s);
    		
    		var sp="<span id='conn"+ss[1]+"'>"+ss[1]+"("+ss[2]+")<span>";
    		$("#chatConnectList").append(sp);
    		
    	} else if(ss[0]=="msg") {
    	    var s=msg.substr(ss[0].length+1);
    	    // 수신된 메시지를 화면에 출력함
            Console.log(s); 
    	} else if(ss[0]=="disconn") {
    		var s=ss[1]+"("+ss[2]+") 님이 나가셨습니다.";
    		Console.log(s);
    		$("#conn"+ss[1]).remove();
    	}
    	
    };
});
// connect() 함수 정의 끝 -------------------

// initialize() 함수 정의 : connect() 함수를 호출하여  서버에 접속
Chat.initialize = function() {
    if (window.location.protocol == 'http:') {
        //Chat.connect('ws://' + window.location.host + '/websocket/chat.msg');
        // 주소는 localhost 대신 아이피를 사용해야 함
    	// Chat.connect('ws://localhost:9090/<%=cp%>/chat.msg');
    	Chat.connect('<%=wsURL%>');
    } else {
        Chat.connect('wss://' + window.location.host + '/wchat.msg');
    }
};

// close() 함수 정의 : 서버의 접속을 해제 할때 호출
Chat.close = function() {
	if(Chat.socket!=null)
		Chat.socket.close();
	
	Chat.socket = null;
};

// sendMessage() 함수 정의 : 서버로 메시지를 전송하고 입력창에서 메시지를 제거
Chat.sendMessage = (function() {
    var message = document.getElementById('chatMsg').value;
    if (message != '') {
        Chat.socket.send("msg:"+message);
        document.getElementById('chatMsg').value = '';
        Console.log("보냄] "+message);
    }
});

//-----------------------------------------------
// 화면에 메시지를 출력하기 위한 객체 생성
var Console = {};

// log() 함수 정의
Console.log = (function(message) {
    var console = document.getElementById('chatMsgContainer');
    var p = document.createElement('p');
    p.style.wordWrap = 'break-word';
    p.innerHTML = message;

    console.appendChild(p); // 전달된 메시지를 하단에 추가

    // 추가된 메시지가 50개를 초과하면 가장 먼저 추가된 메시지를 한개 삭제
    while (console.childNodes.length > 50) {
        console.removeChild(console.firstChild);
    }

    // 스크롤을 최상단에 있도록 설정함
    console.scrollTop = console.scrollHeight;
});

// 서버에 접속
Chat.initialize();
</script>

<div class="bodyFrame2">
    <div class="body-title">
          <h3><span class="glyphicon glyphicon-send"></span> 채팅 <small>Chatting</small></h3>
    </div>
    
    <div class="alert alert-info">
        <i class="glyphicon glyphicon-info-sign"></i> 회원과 실시간으로 대화를 나룰수 있는 공간 입니다.
    </div>
    
    <div style="clear: both;">
        <div style="float: left; width: 350px;">
             <div style="clear: both; padding-bottom: 5px;">
                 <span class="glyphicon glyphicon-menu-right"></span>
                 <span style="font-weight:bold; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">채팅 메시지</span>
             </div>
             <div id="chatMsgContainer"></div>
             <div style="clear: both; padding-top: 5px;">
                 <input type="text" id="chatMsg" class="form-control" 
                            placeholder="채팅 메시지를 입력 하세요...">
             </div>
        </div>
        
        <div style="float: left; width: 20px;">&nbsp;</div>
        
        <div style="float: left; width: 170px;">
             <div style="clear: both; padding-bottom: 5px;">
                 <span class="glyphicon glyphicon-menu-right"></span>
                 <span style="font-weight:bold; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">접속자 리스트</span>
             </div>
             <div id="chatConnectList"></div>
        </div>
        
    </div>
    

</div>