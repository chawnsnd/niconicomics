package com.niconicomics.core.nico.service;

import java.util.ArrayList;

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

	public String accountMessage(Account account) {
		log.debug(account.toString());
		account.setAuthorId(1);
		HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json; charset=UTF-8");
        headers.set("Accept", "application/vnd.tosslab.jandi-v2+json");
        MultiValueMap<String, Object> body = new LinkedMultiValueMap<String, Object>();
        body.add("body", "새로운 계좌등록 신청이 있습니다.");
        body.add("connectColor", "#FAC11B");
        ArrayList<MultiValueMap<String, String>> connectInfo = new ArrayList<>();
        MultiValueMap<String, String> name = new LinkedMultiValueMap<String, String>();
        name.add("title", "이름");
        name.add("desription", account.getName());
        connectInfo.add(name);
        
        MultiValueMap<String, String> bankName = new LinkedMultiValueMap<String, String>();
        bankName.add("title", "은행명");
        bankName.add("desription", account.getBankName());
        connectInfo.add(bankName);

        MultiValueMap<String, String> accountNumber = new LinkedMultiValueMap<String, String>();
        accountNumber.add("title", "계좌번호");
        accountNumber.add("desription", account.getAccountNumber());
        connectInfo.add(accountNumber);

        MultiValueMap<String, String> link = new LinkedMultiValueMap<String, String>();
        link.add("title", "확인하러 가기");
        link.add("desription", "http://localhost:8888/core/account-approve/"+account.getAuthorId());
        connectInfo.add(link);
        
        body.add("connectInfo", connectInfo);
		HttpEntity<MultiValueMap<String, Object>> entity = new HttpEntity<MultiValueMap<String, Object>>(body, headers);
        String result = restTemplate.postForObject("https://wh.jandi.com/connect-api/webhook/20858837/8eb8abe45489dd7a33a92259d9d4927e", entity, String.class);
		log.debug(result);
        return "success";
	}
}
