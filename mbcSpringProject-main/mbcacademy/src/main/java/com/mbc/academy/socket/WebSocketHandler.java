package com.mbc.academy.socket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class WebSocketHandler extends TextWebSocketHandler {
	Map<String, WebSocketSession> userSessions = new ConcurrentHashMap<String, WebSocketSession>();
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
    
	@Autowired
	alarmSerivce as;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	    String userId = getid(session); 
	    if (userId != null) {
	    	sessions.add(session);
	    	userSessions.put(userId,session);
	   	 System.out.println(userId + "연결");
		 System.out.println(userId + "세션 오픈 확인:" + session.isOpen());
	    }
	}
	
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		System.out.println(session.getId() + " 익셉션 발생: " + exception.getMessage());
	}
	
	public String getid(WebSocketSession session) {
		 String userId = (String) session.getAttributes().get("userId");
		if (userId != null) {
			return userId;
		}
		else {
			return null;
		}
	}
	
	@Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
    	 String userId = getid(session);
    	 if(userId != null) {
    		 sessions.remove(userId);
    		 userSessions.remove(userId);
    		 System.out.println(userId + "제거");
    	 }
        
    }
	
	public void sendMessageToUser(String typemessage, String Target, String url, String sender) throws Exception {
	        WebSocketSession session = userSessions.get(Target);
	        String  userId = "";
	    
	        if(session != null) {
	        userId = getid(session);
	        System.out.println(userId + "세션 오픈 확인: " + session.isOpen());
	        }
	        Map<String, Object> messageDTO = new HashMap<>();
	        String message = "";
	        if ("휴가".equals(typemessage)) {
	            message = "신청하신 휴가에 대한 변동 사항이 있습니다";
	        }
	        else if ("댓글".equals(typemessage)) {
	            message = "게시판에 댓글이 달렸습니다";
	        }
	        if (!Target.equals(sender)) {
	        messageDTO.put("message", message);
	        messageDTO.put("messagetype", typemessage);
	        messageDTO.put("empno", Target);
	        messageDTO.put("url", url);
	        as.insertalarm(messageDTO);
	        }
	        if (session != null && session.isOpen()) {
	            TextMessage textMessage = new TextMessage(messageDTO.toString());
	            session.sendMessage(textMessage);
	        } else {
	          
	        }
	}

@Override
public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {    Map<String,Object> map = session.getAttributes();  String userId = (String)map.get("userId");  System.out.println("로그인 한 아이디 : " + userId); }    

}





