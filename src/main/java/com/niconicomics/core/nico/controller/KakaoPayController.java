package com.niconicomics.core.nico.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.niconicomics.core.nico.vo.KakaoPayApprove;
import com.niconicomics.core.nico.vo.KakaoPayReady;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class KakaoPayController {
	
	KakaoPayReady ready = new KakaoPayReady();
	
	@Autowired
	private RestTemplate restTemplate;

	@GetMapping(value = "/kakaopay-ready")
	public String kakaoPayReady(String item) {
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "KakaoAK 1c55408a822d10253d67adedbbcb54ba");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
		MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
		body.add("cid", "TC0ONETIME");
		body.add("partner_order_id", "charge_nico");
		body.add("partner_user_id", "niconicomics");
		body.add("item_name", "1000니코");
		body.add("quantity", "1");
		body.add("total_amount", "1000");
		body.add("tax_free_amount", "0");
		body.add("vat_amount", "91");
		body.add("approval_url", "http://localhost:8888/core/kakaopay-approve");
		body.add("cancel_url", "http://localhost:8888/core/kakao/cancel");
		body.add("fail_url", "http://localhost:8888/core/kakao/fail");
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<MultiValueMap<String, String>>(body, headers);
		ready = restTemplate.postForObject("https://kapi.kakao.com/v1/payment/ready", entity, KakaoPayReady.class);
		return "redirect:"+ready.getNext_redirect_pc_url();
	}
	
	@GetMapping(value = "kakaopay-approve")
	public String kakaoPayApprove(@RequestParam("pg_token") String pg_token) {
		log.debug(pg_token);
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "KakaoAK 1c55408a822d10253d67adedbbcb54ba");
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
        MultiValueMap<String, String> body = new LinkedMultiValueMap<String, String>();
        body.add("cid", "TC0ONETIME");
        body.add("tid", ready.getTid());
        body.add("partner_order_id", "charge_nico");
        body.add("partner_user_id", "niconicomics");
        body.add("pg_token", pg_token);
        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<MultiValueMap<String, String>>(body, headers);
		KakaoPayApprove approve = restTemplate.postForObject("https://kapi.kakao.com/v1/payment/approve", entity, KakaoPayApprove.class);
		log.debug(approve.toString());
		return "redirect:/";
	}
}
