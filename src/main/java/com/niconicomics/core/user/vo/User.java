package com.niconicomics.core.user.vo;

import lombok.Data;

@Data
public class User {
	private int userId;
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
}
