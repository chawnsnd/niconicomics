package com.niconicomics.core.chat.vo;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.niconicomics.core.chat.dao.ChatDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ChatRoom {
    private ArrayList<WebSocketSession> sessions = new ArrayList<>();
    
//    @Autowired
    private ChatDao chatDao;

    public void join(int webtoonId, WebSocketSession session, ObjectMapper objectMapper) {
        sessions.add(session);
        readChats(webtoonId, session, objectMapper);
    }

    public void send(Chat chat, ObjectMapper objectMapper){
    	chatDao.insertChat(chat);
		try {
			TextMessage message = new TextMessage(objectMapper.writeValueAsString(chat));
			sessions.parallelStream().forEach(session -> {
				try {
					session.sendMessage(message);
				} catch (IOException e) {
					e.printStackTrace();
				}
			});
		} catch (JsonProcessingException e1) {
			e1.printStackTrace();
		}
    }
    
    public void readChats(int webtoonId, WebSocketSession session, ObjectMapper objectMapper) {
    	log.debug("chatroom :"+webtoonId);
    	log.debug("dao :"+chatDao.toString());
    	ArrayList<Chat> chats = chatDao.selectChatsByWebtoonId(webtoonId);
    	for (Chat chat2 : chats) {
    		log.debug(chat2.toString());
    		TextMessage message;
			try {
				message = new TextMessage(objectMapper.writeValueAsString(chat2));
				try {
					session.sendMessage(message);
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			} catch (JsonProcessingException e1) {
				e1.printStackTrace();
			}
    	}
    }
}