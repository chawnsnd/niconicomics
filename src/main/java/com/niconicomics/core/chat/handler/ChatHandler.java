package com.niconicomics.core.chat.handler;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.niconicomics.core.chat.vo.Chat;
import com.niconicomics.core.chat.vo.ChatRoom;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ChatHandler extends TextWebSocketHandler{

	private ObjectMapper objectMapper = new ObjectMapper();
	
	private Map<Integer, ChatRoom> chatRooms = new HashMap<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		int webtoonId = Integer.parseInt(session.getUri().getQuery().split("=")[1]);
		ChatRoom chatRoom = null;
		if(!chatRooms.containsKey(webtoonId)) {
			chatRoom = new ChatRoom();
			chatRooms.put(webtoonId, chatRoom);			
		}else {
			chatRoom = chatRooms.get(webtoonId);
		}
		chatRoom.join(webtoonId, session, objectMapper);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		Chat chat = objectMapper.readValue(message.getPayload(), Chat.class);
		int webtoonId = chat.getWebtoonId();
		ChatRoom chatRoom = chatRooms.get(webtoonId);
		chatRoom.send(chat, objectMapper);
		
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	}
	
}
