package com.niconicomics.core.nico.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.http.HttpStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.niconicomics.core.nico.vo.KakaoPayApprove;
import com.niconicomics.core.nico.vo.KakaoPayReady;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class KakaopayService {
	
	private KakaoPayReady ready;
	private KakaoPayApprove approve;
	private Map<String, Integer> itemMap;
	private HttpHeaders headers;
	
	private final String ADMIN_KEY = "1c55408a822d10253d67adedbbcb54ba";
	private final String HOST = "https://kapi.kakao.com";
	private final String CID = "TC0ONETIME";
	private final String PARTNER_ORDER_ID = "charge_nico";
	private final String PARTNER_USER_ID = "niconicomics";
	
	public KakaopayService() {
		itemMap = new HashMap<String, Integer>();
		itemMap.put("1000니코", 1000);
		itemMap.put("2000니코", 2000);
		itemMap.put("3000니코", 3000);
		itemMap.put("10000니코", 10000);
		headers = new HttpHeaders();
		headers.set("Authorization", "KakaoAK "+ADMIN_KEY);
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
	}
	
	@Autowired
	private RestTemplate restTemplate;
	
	public KakaoPayReady kakaoPayReady(String item) {
		int amount = itemMap.get(item);
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("cid", CID);
		body.add("partner_order_id", PARTNER_ORDER_ID);
		body.add("partner_user_id", PARTNER_USER_ID);
		body.add("item_name", item);
		body.add("quantity", "1");
		body.add("total_amount", Integer.toString(amount));
		body.add("tax_free_amount", "0");
		body.add("vat_amount", Integer.toString(amount/11));
		body.add("approval_url", "http://203.233.199.118/api/nico/charge2");
		body.add("cancel_url", "http://203.233.199.118/users/mypage/charge-cancel");
		body.add("fail_url", "http://203.233.199.118/users/mypage/charge-fail");
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<MultiValueMap<String, String>>(body, headers);
		ready = restTemplate.postForObject(HOST+"/v1/payment/ready", entity, KakaoPayReady.class);
		log.debug(ready.toString());
		return ready;
	}
	
	public KakaoPayApprove kakaoPayApprove(String pg_token) {
        MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
        body.add("cid", CID);
        body.add("tid", ready.getTid());
        body.add("partner_order_id", PARTNER_ORDER_ID);
        body.add("partner_user_id", PARTNER_USER_ID);
        body.add("pg_token", pg_token);
        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<MultiValueMap<String, String>>(body, headers);
		approve = restTemplate.postForObject(HOST+"/v1/payment/approve", entity, KakaoPayApprove.class);
		log.debug(approve.toString());
		return approve;
	}
	
}
