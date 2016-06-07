package com.server.chat;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/chat.msg")
public class ChatServer {
	// AtomicInteger 클래스는 getAndIncrement()를 호출할 때마다 카운터를 1씩 증가
	// private static final AtomicInteger connectionIds = new AtomicInteger(0);

	private static final Map<String, Session> sessionMap = new HashMap<String, Session>();

	private String userId, userName;

	// 클라이언트가 새로 접속할 때마다 한개의 Session 객체가 생성된다.
	// Session 객체를 컬렉션에 보관하여 해당 클라이언트에게 데이터를 전송할 때마다 사용한다.
	private Session session;

	public ChatServer() {
		// 클라이언트가 새로 접속할 때마다 이 클래스의 인스턴스가 새로 생성됨
		    // 클라이언트가 접속할 때마다 서버측에서는 Thread 가 새로 생성됨
	}

	@OnOpen
	public void start(Session session) {
		System.out.println("클라이언트 접속됨 " + session);
		// 접속자마다 한개의 세션이 생성되어 데이터 통신수단으로 사용
		this.session = session;
	}

	@OnClose
	public void end() {
		String user=userId+":"+userName;
		sessionMap.remove(user);
		String msg = String.format("disconn:%s:%s", userId, userName);
		broadcast(msg,  null);
	}

	// 현재 세션과 연결된 클라이언트로부터 메시지가 도착할 때마다 새로운 쓰레드가 실행되어 incoming()을 호출
	@OnMessage
	public void incoming(String message) {
		System.out.println("메시지 도착:" + userId);
		if (message == null || message.trim().equals(""))
			return;
		
		String str;
		String ss[]=message.split(":");
		if(ss.length<2)
			return;
		
		if(ss[0].equals("conn")) {
			// 접속한 사용자의 아이디와 이름을 키로 Session 저장
			this.userId=ss[1];
			this.userName=ss[2];
			String user=userId+":"+userName;
			sessionMap.put(user, session);
			
			// 접속한 사용자를 전송 해줌
			Iterator<String> it = sessionMap.keySet().iterator();
			while (it.hasNext()) {
				String key = it.next();
				if(user.equals(key))  // 자기 자신
					continue;
				str = "conn:"+key;
				sendToOne(str, this.session);
			}
			
			// 다른 클라이언트에게 접속 사실을 알려줌
			str = String.format("conn:%s", user);
			broadcast(str, user);
			return;
			
		} else if(ss[0].equals("msg")) {
			// 채팅 문자열을 전송 받은 경우
			String user=userId+":"+userName;
			
			str = String.format("msg:%s] %s", userId, ss[1]);
			
			// 자신을 제외한 모든 접속자에게 전송
			broadcast(str, user);
		}
		
		// 특정 접속자에게 전송 할 경우 
		// sendToOne(msg, sessionMap.get("Guest"));
	}

	@OnError
	public void onError(Throwable t) throws Throwable {
		System.err.println("오류/세션제거(" + userId + "):Chat Error: " + t.toString());
		String user=userId+":"+userName;
		sessionMap.remove(user);
	}

	// 클라이언트로부터 도착한 메시지를 특정 수신자(Session)에게만 전달한다.
	protected void sendToOne(String msg, Session ses) {
		try {
			ses.getBasicRemote().sendText(msg);
		} catch (IOException e) {
			// e.printStackTrace();
		}
	}

	// 클라이언트로부터 도착한 메시지를 모든 접속자에게 전송한다.
	// msg : 전송할 메시지, out: 메시지 전송 제외자(null 일경우 모두 전송)
	protected void broadcast(String msg, String out) {
		Set<String> keys = sessionMap.keySet();

		Iterator<String> it = keys.iterator();
		while (it.hasNext()) {
			String key = it.next();
			if(out!=null && out.equals(key))  // 자기 자신
				continue;
			
			Session s = sessionMap.get(key);
			try {
				s.getBasicRemote().sendText(msg);
			} catch (IOException e) {
				sessionMap.remove(key);
				try {
					s.close();
				} catch (IOException e1) {
					// e1.printStackTrace();
				}

				String str = String.format("disconn:%s:%s", userId, userName);
				broadcast(str, null);
			}
		}
	}


}
