package com.niconicomics.core.nico.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.niconicomics.core.nico.vo.Account;
import com.niconicomics.core.nico.vo.InquiryRealNameReq;
import com.niconicomics.core.nico.vo.InquiryRealNameRes;
import com.niconicomics.core.nico.vo.OpenBankingTokenRes;
import com.niconicomics.core.nico.vo.TransferDepositReq;
import com.niconicomics.core.nico.vo.TransferDepositReqItem;
import com.niconicomics.core.nico.vo.TransferDepositRes;
import com.niconicomics.core.nico.vo.TransferDepositResItem;
import com.niconicomics.core.nico.vo.TransferResultReq;
import com.niconicomics.core.nico.vo.TransferResultReqItem;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class OpenBankingService {
	
	private final String CLIENT_ID = "OO2GQHBwJArOFvcr8Ezr55cqCn5sIS1JjGqtLbPW";
	private final String CLIENT_SECRET = "tt2P8BVUWqUeYKa6laBrFKulf228gdKsoIEN3Nn8";
	private final String HOST = "https://testapi.openbanking.or.kr";
	private final String CODE = "T991617520";

	private DateFormat HHmmssSSS;
	private DateFormat yyyyMMddHHmmss;
	private DateFormat yyyyMMdd;
	private Map<String, String> bankMap;
	
	public OpenBankingService() {
		this.HHmmssSSS = new SimpleDateFormat("HHmmssSSS");
		this.yyyyMMddHHmmss = new SimpleDateFormat("yyyyMMddHHmmss");
		this.yyyyMMdd = new SimpleDateFormat("yyyyMMdd");
		this.bankMap = new HashMap<>();
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
	
	private String getAccessToken() {
		HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
        String url = HOST+"/oauth/2.0/token"+
        		"?client_id="+CLIENT_ID+
        		"&client_secret="+CLIENT_SECRET+
        		"&scope=oob"+
        		"&grant_type=client_credentials";
        HttpEntity entity = new HttpEntity<>(headers);
		OpenBankingTokenRes res = (OpenBankingTokenRes) restTemplate.postForObject(url, entity, OpenBankingTokenRes.class);
		return res.getAccess_token();
	}
	
	public boolean inquiryRealName(Account account) {
		Date date = new Date();
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer "+getAccessToken());
        headers.set("Content-Type", "application/json; charset=UTF-8");
        InquiryRealNameReq req = new InquiryRealNameReq();
        req.setBank_tran_id(CODE+"U"+HHmmssSSS.format(date));
        req.setBank_code_std(bankMap.get(account.getBankName()));
        req.setAccount_num(account.getAccountNumber());
        req.setAccount_holder_info_type(" ");
        req.setAccount_holder_info(account.getRegistrationNumber().substring(0, 6));
        req.setTran_dtime(Long.parseLong(yyyyMMddHHmmss.format(date)));
        log.debug(req.toString());
		HttpEntity<InquiryRealNameReq> entity = new HttpEntity<InquiryRealNameReq>(req, headers);
		InquiryRealNameRes res = restTemplate.postForObject(HOST+"/v2.0/inquiry/real_name", entity, InquiryRealNameRes.class);
		log.debug(res.toString());
		return res.getAccount_holder_name().equals(account.getAccountHolderName());
	}

	public boolean transfer(Account account, int nico) {
		Date date = new Date();
		long tranDtime = Long.parseLong(yyyyMMddHHmmss.format(date));
		String bankTranId = CODE+"U"+HHmmssSSS.format(date);
		int bankTranDate = Integer.parseInt(yyyyMMdd.format(date));
		int tranAmt = nico;
		
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer "+getAccessToken());
        headers.set("Content-Type", "application/json; charset=UTF-8");
        
        TransferDepositReq req = new TransferDepositReq();
        req.setCntr_account_type("N");
        req.setCntr_account_num("4060044536");
        req.setWd_pass_phrase("NONE");
        req.setWd_print_content("니코환전");
        req.setName_check_option("on");
        req.setTran_dtime(tranDtime);
        req.setReq_cnt(1);
        
        TransferDepositReqItem reqItem = new TransferDepositReqItem();
        reqItem.setTran_no(1);
        reqItem.setBank_tran_id(bankTranId);
        reqItem.setBank_code_std(bankMap.get("오픈은행"));
        reqItem.setPrint_content("니코환전");
        reqItem.setTran_amt(tranAmt);
        reqItem.setAccount_num("1234567890123456");
        reqItem.setAccount_holder_name(account.getAccountHolderName());
        reqItem.setReq_client_name(account.getName());
        reqItem.setReq_client_bank_code(bankMap.get(account.getBankName()));
        reqItem.setReq_client_account_num(account.getAccountNumber());
        reqItem.setReq_client_num(Integer.toString(account.getAccountId()));
        reqItem.setTransfer_purpose("TR");
        ArrayList<TransferDepositReqItem> reqList = new ArrayList<>();
        reqList.add(reqItem);
        req.setReq_list(reqList);
        log.debug(req.toString());
        HttpEntity<TransferDepositReq> entity = new HttpEntity<TransferDepositReq>(req, headers);
		TransferDepositRes res = (TransferDepositRes) restTemplate.postForObject(HOST+"/v2.0/transfer/deposit/acnt_num", entity, TransferDepositRes.class);
		log.debug(res.toString());
		return transferResult(tranDtime, bankTranId, bankTranDate, tranAmt);
	}
	
	private boolean transferResult(long tranDtime, String bankTranId, int bankTranDate, int tranAmt) {
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer "+getAccessToken());
        headers.set("Content-Type", "application/json; charset=UTF-8");
		String bankTranIdTemp = CODE+"U000000000";
        int bankTranDateTemp = 20200401;
        
		TransferResultReq req = new TransferResultReq();
		req.setCheck_type("2");
		req.setReq_cnt(1);
		req.setTran_dtime(tranDtime);
		TransferResultReqItem reqItem = new TransferResultReqItem();
		reqItem.setTran_no(1);
		reqItem.setOrg_bank_tran_id(bankTranId);
		reqItem.setOrg_bank_tran_date(bankTranDate);
		reqItem.setOrg_bank_tran_id(bankTranIdTemp);
		reqItem.setOrg_bank_tran_date(bankTranDateTemp);
		reqItem.setOrg_tran_amt(tranAmt);
		ArrayList<TransferResultReqItem> reqList = new ArrayList<>();
		reqList.add(reqItem);
		req.setReq_list(reqList);
		log.debug(req.toString());
		HttpEntity<TransferResultReq> entity = new HttpEntity<TransferResultReq>(req, headers);
		String res = (String) restTemplate.postForObject(HOST+"/v2.0/transfer/result", entity, String.class);
		log.debug(res.toString());
		return false;
	}
	
}
