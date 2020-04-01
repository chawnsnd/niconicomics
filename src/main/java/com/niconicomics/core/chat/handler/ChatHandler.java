package com.niconicomics.core.chat.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.niconicomics.core.chat.dao.ChatDao;
import com.niconicomics.core.chat.vo.Chat;
import com.niconicomics.core.chat.vo.ChatRoom;
import com.niconicomics.core.user.dao.UserDao;
import com.niconicomics.core.user.vo.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ChatHandler extends TextWebSocketHandler{

	@Autowired
	private ObjectMapper objectMapper;
	@Autowired
	private ChatDao chatDao;
	@Autowired
	private UserDao userDao;

	private Map<Integer, ChatRoom> chatRooms = new HashMap<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		int webtoonId = Integer.parseInt(session.getUri().getQuery().split("=")[1]);
		ChatRoom chatRoom = null;
		if(!chatRooms.containsKey(webtoonId)) {
			chatRoom = new ChatRoom(chatDao, userDao);
			chatRooms.put(webtoonId, chatRoom);
		}else {
			chatRoom = chatRooms.get(webtoonId);
		}
		chatRoom.join(webtoonId, session, objectMapper);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		Chat chat = objectMapper.readValue(message.getPayload(), Chat.class);
		User user = userDao.selectUserByUserId(chat.getUserId());
		chat.setNickname(user.getNickname());
		int webtoonId = chat.getWebtoonId();
		ChatRoom chatRoom = chatRooms.get(webtoonId);
		chatRoom.send(chat, objectMapper);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		int webtoonId = Integer.parseInt(session.getUri().getQuery().split("=")[1]);
		ChatRoom chatRoom = chatRooms.get(webtoonId);
		chatRoom.exit(session, objectMapper);
	}
	
}
