package com.niconicomics.core.nico.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import com.niconicomics.core.nico.util.RandomScope;
import com.niconicomics.core.nico.vo.OpenBankingRealName;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/account")
public class AccountController {

	@Autowired
	private RestTemplate restTemplate;
	
	@GetMapping(value = "/authorize-1")
	public String authorize1() {
		String url = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
        		+ "response_type=code&"
        		+ "client_id=OO2GQHBwJArOFvcr8Ezr55cqCn5sIS1JjGqtLbPW&"
        		+ "redirect_uri=http://localhost:8888/core/account/authorize-2&"
        		+ "scope=inquiry&"
        		+ "state="+RandomScope.make(32)+"&"
        		+ "auth_type=0";
		return "redirect:"+url;
	}
	
	@GetMapping(value = "/authorize-2")
	public void authorize2(String code, String scope, String client_info, String state) {
		log.debug(code);
		log.debug(scope);
		log.debug(client_info);
		log.debug(state);
	}
	
	@GetMapping(value = "/inquiry-real-name")
	public String inquiryRealName(String bankName, String accountNum, String accountHolderInfo) {
		String access_token = getAccessToken();
		HttpHeaders headers = new HttpHeaders();
		Date date = new Date();
		DateFormat format1 = new SimpleDateFormat("HHmmssSSS");
		headers.set("Authorization", "Bearer "+access_token);
        headers.set("Content-Type", "application/json; charset=UTF-8");
		Map<String, String> body = new HashMap<String, String>();
		body.put("bank_tran_id", "T991617520U"+format1.format(date)); //내가 만드는거임
		body.put("bank_code_std", "020");
		body.put("account_num", "1002045880243");
		body.put("account_holder_info_type", " ");
		body.put("account_holder_info", "930110");
		DateFormat format2 = new SimpleDateFormat("yyyyMMddHHmmss");
		body.put("tran_dtime", format2.format(date));
		HttpEntity<Map<String, String>> entity = new HttpEntity<Map<String, String>>(body, headers);
		OpenBankingRealName realName = restTemplate.postForObject("https://testapi.openbanking.or.kr/v2.0/inquiry/real_name", entity, OpenBankingRealName.class);
		log.debug(realName.toString());
		return "";
	}

	private String getAccessToken() {
		HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("client_id", "OO2GQHBwJArOFvcr8Ezr55cqCn5sIS1JjGqtLbPW");
		body.add("client_secret", "tt2P8BVUWqUeYKa6laBrFKulf228gdKsoIEN3Nn8");
		body.add("scope", "oob");
		body.add("grant_type", "client_credentials");
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<MultiValueMap<String, String>>(body, headers);
		String token = (String) restTemplate.postForObject("https://testapi.openbanking.or.kr/oauth/2.0/token", entity, Map.class).get("access_token");
		return token;
	}
	
}
