package com.niconicomics.core.chat.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.niconicomics.core.chat.vo.Chat;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class ChatDao {

//	@Autowired
	private SqlSession session;
	
	public ArrayList<Chat> selectChatsByWebtoonId(int webtoonId){
		log.debug("chatdao");
		log.debug("세션:"+session.toString());
		ChatMapper mapper = session.getMapper(ChatMapper.class);
		log.debug(mapper.toString());
		return mapper.selectChatsByWebtoonId(webtoonId);
	}

	public Boolean insertChat(Chat chat) {
		log.debug("DAO");
		ChatMapper mapper = session.getMapper(ChatMapper.class);
		if(mapper.insertChat(chat)==1) {
			return true;
		}else {
			return false;
		}
	}
}
