package com.niconicomics.core.chat.dao;

import java.util.ArrayList;

import com.niconicomics.core.chat.vo.Chat;

public interface ChatMapper {

	public ArrayList<Chat> selectChatsByWebtoonId(int webtoonId);

	public int insertChat(Chat chat);
	
}
