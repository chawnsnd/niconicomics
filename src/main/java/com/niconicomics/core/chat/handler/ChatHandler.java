package com.niconicomics.core.chat.handler;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatHandler extends TextWebSocketHandler{

	private static final Logger logger = LoggerFactory.getLogger(ChatHandler.class);
	
	private ArrayList<WebSocketSession> sessionList = new ArrayList<>();
	private ArrayList<TextMessage> messageList = new ArrayList<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		logger.debug(session.getId()+" 연결 됨");
		logger.debug("참여자 : "+session.getId());
		for (TextMessage message : messageList) {			
			session.sendMessage(message);
		}
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		logger.debug(session.getId()+" : "+message.getPayload());
		messageList.add(message);
		for (WebSocketSession sess : sessionList) {
			sess.sendMessage(new TextMessage(message.getPayload()));
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		logger.debug(session.getId()+" 연결 끊킴");
		logger.debug("퇴장자 : "+session.getId());
	}
	
}
