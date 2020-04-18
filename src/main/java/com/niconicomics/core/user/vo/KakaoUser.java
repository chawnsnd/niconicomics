package com.niconicomics.core.user.vo;

import java.util.ArrayList;

import lombok.Data;

@Data
public class KakaoUser {

	private String id;
	private KakaoProperties properties;
	private KakaoAccount kakao_account;
	
}
