package com.niconicomics.core.nico.vo;

import lombok.Data;

@Data
public class OpenBankingTokenRes {

	private String access_token;
	private String token_type; //고정값: Bearer Access Token 유형
	private int expires_in; //<expire_time> Access Token 만료 기간(초)
	private String scope; //고정값: oob Access Token 권한 범위
	private String client_use_code; //“F001234560” 이용기관코드
	
}
