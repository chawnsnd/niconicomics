package com.niconicomics.core.nico.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.niconicomics.core.exception.NotImageException;
import com.niconicomics.core.nico.dao.AccountDao;
import com.niconicomics.core.nico.service.AccountService;
import com.niconicomics.core.nico.service.OpenBankingService;
import com.niconicomics.core.nico.util.RandomScope;
import com.niconicomics.core.nico.vo.Account;
import com.niconicomics.core.nico.vo.OpenBankingRealName;
import com.niconicomics.core.user.dao.UserDao;
import com.niconicomics.core.user.vo.User;
import com.niconicomics.core.util.ImageService;

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
	private AccountService accountService;
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private OpenBankingService openBankingService;
	
	@ResponseBody
	@GetMapping(value="/{userId}")
	public Account getAccount(
			@PathVariable(name = "userId") int userId, 
			HttpSession session,
			HttpServletResponse res) {
		User user = (User) session.getAttribute("loginUser");
		if(userId != user.getUserId()) {
			res.setStatus(403);
			return null;
		}
		Account account = accountService.getAccount(userId);
		return account;
	}
	
	@ResponseBody
	@PostMapping(value="/{userId}")
	public boolean enrollAccount(
			@PathVariable(name = "userId") int userId,
			Account account,
			@RequestParam(name = "idCardImg") MultipartFile idCardImg, 
			@RequestParam(name = "copyOfBankbookImg") MultipartFile copyOfBankbookImg,
			HttpServletResponse res,
			HttpSession session) {
		User user = (User) session.getAttribute("loginUser");
		if(userId != user.getUserId()) {
			res.setStatus(403);
			return false;
		}
		try {
			account.setAuthorId(userId);
			return accountService.enrollAccount(account, idCardImg, copyOfBankbookImg);
		} catch (NotImageException e) {
			e.printStackTrace();
			res.setStatus(406);
			return false;
		}
	}
	
	@ResponseBody
	@DeleteMapping(value="/{userId}")
	public boolean deleteAccount(
			@PathVariable(name = "userId") int userId,
			HttpServletResponse res,
			HttpSession session) {
		User user = (User) session.getAttribute("loginUser");
		if(userId != user.getUserId()) {
			res.setStatus(403);
			return false;
		}
		return accountDao.deleteAccountByAuthorId(userId);
	}
	
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
