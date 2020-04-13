package com.niconicomics.core.chat.vo;

import lombok.Data;

@Data
public class Chat {

	private int chatId;
	private int userId;
	private String nickname;
	private int webtoonId;
	private String message;
	private String type;
	
}
