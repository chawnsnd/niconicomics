package com.niconicomics.core.chat.vo;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.niconicomics.core.chat.dao.ChatDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ChatRoom {
	
    private ArrayList<WebSocketSession> sessions;

    private ChatDao chatDao;
    
    public ChatRoom(ChatDao chatDao) {
		super();
		this.sessions = new ArrayList<>();
		this.chatDao = chatDao;
	}

	public void join(int webtoonId, WebSocketSession session, ObjectMapper objectMapper) {
        sessions.add(session);
        readChats(webtoonId, session, objectMapper);
    }

    public void send(Chat chat, ObjectMapper objectMapper){
    	chatDao.insertChat(chat);
		try {
			TextMessage message = new TextMessage(objectMapper.writeValueAsString(chat));
			for (WebSocketSession session : sessions) {
				log.debug(session.toString());
				session.sendMessage(message);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
    
    public void readChats(int webtoonId, WebSocketSession session, ObjectMapper objectMapper) {
    	try {
	    	ArrayList<Chat> chats = chatDao.selectChatsByWebtoonId(webtoonId);
	    	for (Chat chat : chats) {
				try {
					TextMessage message = new TextMessage(objectMapper.writeValueAsString(chat));
					session.sendMessage(message);
				} catch (IOException e) {
					e.printStackTrace();
				}
	    	}
    	}catch(Exception e) {
    		e.printStackTrace();
    	}
    }
}