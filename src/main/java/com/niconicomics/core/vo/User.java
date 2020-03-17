package com.niconicomics.core.vo;

import lombok.Data;

@Data
public class User {
	private int user_id;
	private String email;
	private String password;
	private String nickname;
	private String birthdate;
	private String gender;
	private String type;
	private String authority;
	private String salt;
	private String regdate;
	private int nico;
	private String show_dotple;
	private String show_chat;
}
