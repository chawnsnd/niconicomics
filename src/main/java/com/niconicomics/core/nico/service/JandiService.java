package com.niconicomics.core.nico.service;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.niconicomics.core.nico.vo.Account;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class JandiService {
	
	@Autowired
	private RestTemplate restTemplate;

	public void accountMessage(Account account) {
		HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        headers.set("Accept", "application/vnd.tosslab.jandi-v2+json");
        
        JSONObject body = new JSONObject();
        body.put("body", 
        		"새로운 계좌등록 신청/수정이 있습니다."+
				"[[확인]](http://203.233.199.118/admin/account/"+account.getAuthorId()+")"
        );
		HttpEntity<JSONObject> entity = new HttpEntity<>(body, headers);
        log.debug(entity.toString());
        String result = restTemplate.postForObject("https://wh.jandi.com/connect-api/webhook/20858837/8eb8abe45489dd7a33a92259d9d4927e", entity, String.class);
        log.debug(result);
	}
}
