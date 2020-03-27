package com.niconicomics.core.nico.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.niconicomics.core.nico.vo.OpenBankingRealName;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OpenBankingService {
	
	private String accessToken;
	private final String CLIENT_ID = "OO2GQHBwJArOFvcr8Ezr55cqCn5sIS1JjGqtLbPW";
	private final String CLIENT_SECRET = "tt2P8BVUWqUeYKa6laBrFKulf228gdKsoIEN3Nn8";
	private final String HOST = "https://testapi.openbanking.or.kr";
	private Map<String, String> bankMap;
	
	public OpenBankingService() {
		bankMap = new HashMap<>();
		bankMap.put("산업", "002");
		bankMap.put("기업", "003");
		bankMap.put("국민", "004");
		bankMap.put("수협", "007");
		bankMap.put("농협", "011");
		bankMap.put("우리", "020");
		bankMap.put("SC 제일", "023");
		bankMap.put("씨티", "027");
		bankMap.put("대구", "031");
		bankMap.put("부산", "032");
		bankMap.put("광주", "034");
		bankMap.put("제주", "035");
		bankMap.put("전북", "037");
		bankMap.put("경남", "039");
		bankMap.put("KEB 하나", "081");
		bankMap.put("신한", "088");
		bankMap.put("K 뱅크", "089");
		bankMap.put("카뱅", "090");
		bankMap.put("오픈", "097");
		bankMap.put("KDB 산업은행", "002");
		bankMap.put("IBK 기업은행", "003");
		bankMap.put("KB 국민은행", "004");
		bankMap.put("수협은행", "007");
		bankMap.put("NH 농협은행", "011");
		bankMap.put("우리은행", "020");
		bankMap.put("SC 제일은행", "023");
		bankMap.put("한국씨티은행", "027");
		bankMap.put("대구은행", "031");
		bankMap.put("부산은행", "032");
		bankMap.put("광주은행", "034");
		bankMap.put("제주은행", "035");
		bankMap.put("전북은행", "037");
		bankMap.put("경남은행", "039");
		bankMap.put("KEB 하나은행", "081");
		bankMap.put("신한은행", "088");
		bankMap.put("케이뱅크", "089");
		bankMap.put("카카오뱅크", "090");
		bankMap.put("오픈은행", "097");
	}
	

	@Autowired
	private RestTemplate restTemplate;
	
	public OpenBankingRealName inquiryRealName(String bankName, String accountNum, String birthdate) {
		String access_token = getAccessToken();
		log.debug(access_token);
		HttpHeaders headers = new HttpHeaders();
		Date date = new Date();
		String bankCode = bankMap.get(bankName);
		log.debug(bankCode);
		log.debug(birthdate);
		DateFormat format1 = new SimpleDateFormat("HHmmssSSS");
		headers.set("Authorization", "Bearer "+access_token);
        headers.set("Content-Type", "application/json; charset=UTF-8");
		Map<String, String> body = new HashMap<String, String>();
		body.put("bank_tran_id", "T991617520U"+format1.format(date)); //내가 만드는거임
		body.put("bank_code_std", bankCode);
		body.put("account_num", accountNum);
		body.put("account_holder_info_type", " ");
		body.put("account_holder_info", birthdate);
		DateFormat format2 = new SimpleDateFormat("yyyyMMddHHmmss");
		body.put("tran_dtime", format2.format(date));
		HttpEntity<Map<String, String>> entity = new HttpEntity<Map<String, String>>(body, headers);
		OpenBankingRealName realName = restTemplate.postForObject(HOST+"/v2.0/inquiry/real_name", entity, OpenBankingRealName.class);
		return realName;
	}
	
	private String getAccessToken() {
		HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("client_id", CLIENT_ID);
		body.add("client_secret", CLIENT_SECRET);
		body.add("scope", "oob");
		body.add("grant_type", "client_credentials");
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<MultiValueMap<String, String>>(body, headers);
		String token = (String) restTemplate.postForObject(HOST+"/oauth/2.0/token", entity, Map.class).get("access_token");
		accessToken = token;
		return token;
	}
	
}
