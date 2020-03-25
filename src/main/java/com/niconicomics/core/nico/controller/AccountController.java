package com.niconicomics.core.nico.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import com.niconicomics.core.nico.dao.AccountDao;
import com.niconicomics.core.nico.service.OpenBankingService;
import com.niconicomics.core.nico.util.RandomScope;
import com.niconicomics.core.nico.vo.OpenBankingRealName;
import com.niconicomics.core.user.dao.UserDao;
import com.niconicomics.core.user.vo.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/account")
public class AccountController {

	@Autowired
	private RestTemplate restTemplate;
	
	@Autowired
	private AccountDao accountDao;
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private OpenBankingService openBankingService;
	
	@GetMapping("value=/{userId}")
	public void getAccount(@PathVariable(name = "userId") int userId, HttpSession session) {
		User user = (User) session.getAttribute("loginUser");
		if(user.getUserId() == userId) {			
			accountDao.selectAccountByAccountId(userId);
		}
	}

//	@PostMapping(value = "/enroll")
//	public String enroll(Account account) {
//		log.debug(account.toString());
//		account.setAuthorId(1);
//		if(accountDao.insertAccount(account)) {
//			HttpHeaders headers = new HttpHeaders();
//	        headers.set("Content-Type", "application/json; charset=UTF-8");
//	        headers.set("Accept", "application/vnd.tosslab.jandi-v2+json");
//	        MultiValueMap<String, Object> body = new LinkedMultiValueMap<String, Object>();
//	        body.add("body", "새로운 계좌등록 신청이 있습니다.");
//	        body.add("connectColor", "#FAC11B");
//	        ArrayList<MultiValueMap<String, String>> connectInfo = new ArrayList<>();
//	        
//	        MultiValueMap<String, String> name = new LinkedMultiValueMap<String, String>();
//	        name.add("title", "이름");
//	        name.add("desription", account.getName());
//	        connectInfo.add(name);
//	        
//	        MultiValueMap<String, String> bankName = new LinkedMultiValueMap<String, String>();
//	        bankName.add("title", "은행명");
//	        bankName.add("desription", account.getBankName());
//	        connectInfo.add(bankName);
//
//	        MultiValueMap<String, String> accountNumber = new LinkedMultiValueMap<String, String>();
//	        accountNumber.add("title", "계좌번호");
//	        accountNumber.add("desription", account.getAccountNumber());
//	        connectInfo.add(accountNumber);
//
//	        MultiValueMap<String, String> link = new LinkedMultiValueMap<String, String>();
//	        link.add("title", "확인하러 가기");
//	        link.add("desription", "http://localhost:8888/core/account-approve/"+account.getAuthorId());
//	        connectInfo.add(link);
//	        
//	        body.add("connectInfo", connectInfo);
//			HttpEntity<MultiValueMap<String, Object>> entity = new HttpEntity<MultiValueMap<String, Object>>(body, headers);
//	        String result = restTemplate.postForObject("https://wh.jandi.com/connect-api/webhook/20858837/8eb8abe45489dd7a33a92259d9d4927e", entity, String.class);
//		}
//		return "success";
//	}
	
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
	public String inquiryRealName(String bankName, String accountNum, String birthdate, String accountHolderInfo) {
		OpenBankingRealName realName = openBankingService.inquiryRealName("우리은행", "1002045880243", "930110");
		log.debug(realName.toString());
		return "";
	}
	
}
