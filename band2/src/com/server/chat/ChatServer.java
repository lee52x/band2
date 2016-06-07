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
	// AtomicInteger Ŭ������ getAndIncrement()�� ȣ���� ������ ī���͸� 1�� ����
	// private static final AtomicInteger connectionIds = new AtomicInteger(0);

	private static final Map<String, Session> sessionMap = new HashMap<String, Session>();

	private String userId, userName;

	// Ŭ���̾�Ʈ�� ���� ������ ������ �Ѱ��� Session ��ü�� �����ȴ�.
	// Session ��ü�� �÷��ǿ� �����Ͽ� �ش� Ŭ���̾�Ʈ���� �����͸� ������ ������ ����Ѵ�.
	private Session session;

	public ChatServer() {
		// Ŭ���̾�Ʈ�� ���� ������ ������ �� Ŭ������ �ν��Ͻ��� ���� ������
		    // Ŭ���̾�Ʈ�� ������ ������ ������������ Thread �� ���� ������
	}

	@OnOpen
	public void start(Session session) {
		System.out.println("Ŭ���̾�Ʈ ���ӵ� " + session);
		// �����ڸ��� �Ѱ��� ������ �����Ǿ� ������ ��ż������� ���
		this.session = session;
	}

	@OnClose
	public void end() {
		String user=userId+":"+userName;
		sessionMap.remove(user);
		String msg = String.format("disconn:%s:%s", userId, userName);
		broadcast(msg,  null);
	}

	// ���� ���ǰ� ����� Ŭ���̾�Ʈ�κ��� �޽����� ������ ������ ���ο� �����尡 ����Ǿ� incoming()�� ȣ��
	@OnMessage
	public void incoming(String message) {
		System.out.println("�޽��� ����:" + userId);
		if (message == null || message.trim().equals(""))
			return;
		
		String str;
		String ss[]=message.split(":");
		if(ss.length<2)
			return;
		
		if(ss[0].equals("conn")) {
			// ������ ������� ���̵�� �̸��� Ű�� Session ����
			this.userId=ss[1];
			this.userName=ss[2];
			String user=userId+":"+userName;
			sessionMap.put(user, session);
			
			// ������ ����ڸ� ���� ����
			Iterator<String> it = sessionMap.keySet().iterator();
			while (it.hasNext()) {
				String key = it.next();
				if(user.equals(key))  // �ڱ� �ڽ�
					continue;
				str = "conn:"+key;
				sendToOne(str, this.session);
			}
			
			// �ٸ� Ŭ���̾�Ʈ���� ���� ����� �˷���
			str = String.format("conn:%s", user);
			broadcast(str, user);
			return;
			
		} else if(ss[0].equals("msg")) {
			// ä�� ���ڿ��� ���� ���� ���
			String user=userId+":"+userName;
			
			str = String.format("msg:%s] %s", userId, ss[1]);
			
			// �ڽ��� ������ ��� �����ڿ��� ����
			broadcast(str, user);
		}
		
		// Ư�� �����ڿ��� ���� �� ��� 
		// sendToOne(msg, sessionMap.get("Guest"));
	}

	@OnError
	public void onError(Throwable t) throws Throwable {
		System.err.println("����/��������(" + userId + "):Chat Error: " + t.toString());
		String user=userId+":"+userName;
		sessionMap.remove(user);
	}

	// Ŭ���̾�Ʈ�κ��� ������ �޽����� Ư�� ������(Session)���Ը� �����Ѵ�.
	protected void sendToOne(String msg, Session ses) {
		try {
			ses.getBasicRemote().sendText(msg);
		} catch (IOException e) {
			// e.printStackTrace();
		}
	}

	// Ŭ���̾�Ʈ�κ��� ������ �޽����� ��� �����ڿ��� �����Ѵ�.
	// msg : ������ �޽���, out: �޽��� ���� ������(null �ϰ�� ��� ����)
	protected void broadcast(String msg, String out) {
		Set<String> keys = sessionMap.keySet();

		Iterator<String> it = keys.iterator();
		while (it.hasNext()) {
			String key = it.next();
			if(out!=null && out.equals(key))  // �ڱ� �ڽ�
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
