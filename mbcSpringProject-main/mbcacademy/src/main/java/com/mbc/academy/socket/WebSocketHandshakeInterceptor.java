package com.mbc.academy.socket;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import javax.servlet.http.HttpSession;
import java.util.Map;

public class WebSocketHandshakeInterceptor implements HandshakeInterceptor {

    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
        // WebSocket 연결 전에 실행되는 메서드
        // 여기서 사용자 인증 및 권한 확인 등의 작업을 수행할 수 있습니다.

        if (request instanceof ServletServerHttpRequest) {
            ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
            HttpSession session = servletRequest.getServletRequest().getSession(false);

            if (session != null && session.getAttribute("id") != null) {
            	String userId = (String) session.getAttribute("id");
                attributes.put("userId", userId);
                return true;
            }
        }

        // 세션 정보가 없거나, 사용자 정보가 없다면 연결을 거부
        return false;
    }

    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Exception exception) {
        // WebSocket 연결 후에 실행되는 메서드
        // 여기서 추가적인 작업을 수행할 수 있습니다.
    }
}
