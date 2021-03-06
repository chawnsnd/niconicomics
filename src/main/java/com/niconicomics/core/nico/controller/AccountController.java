package com.niconicomics.core.nico.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.niconicomics.core.exception.NotImageException;
import com.niconicomics.core.nico.dao.AccountDao;
import com.niconicomics.core.nico.service.AccountService;
import com.niconicomics.core.nico.vo.Account;
import com.niconicomics.core.user.vo.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/account")
public class AccountController {

	@Autowired
	private AccountDao accountDao;
	@Autowired
	private AccountService accountService;
	
	@GetMapping(value="/{userId}")
	public Account getAccount(@PathVariable int userId, HttpSession session, HttpServletResponse res) {
		User user = (User) session.getAttribute("loginUser");
		if(userId != user.getUserId() && !user.getType().equals("ADMIN")) return null;
		Account account = accountService.getAccount(userId);
		return account;
	}
	
	@PostMapping(value="/{userId}")
	public boolean enrollAccount(@PathVariable int userId, Account account,
			@RequestParam(name = "idCardImg") MultipartFile idCardImg, 
			@RequestParam(name = "copyOfBankbookImg") MultipartFile copyOfBankbookImg,
			HttpServletResponse res, HttpSession session) throws NotImageException {
		User user = (User) session.getAttribute("loginUser");
		if(userId != user.getUserId() && !user.getType().equals("ADMIN")) return false;
		account.setAuthorId(userId);
		return accountService.enrollAccount(account, idCardImg, copyOfBankbookImg);
	}
	
	@PostMapping(value="/{userId}/put")
	public boolean modifyAccount(@PathVariable int userId, Account account,
			@RequestParam(name = "idCardImg") MultipartFile idCardImg,
			@RequestParam(name = "idCardImg") MultipartFile copyOfBankbookImg,
			HttpServletResponse res, HttpSession session) throws NotImageException {
		User user = (User) session.getAttribute("loginUser");
		if(userId != user.getUserId() && !user.getType().equals("ADMIN")) return false;
		account.setAuthorId(userId);
		return accountService.modifyAccount(account, idCardImg, copyOfBankbookImg);
	}
	
	@DeleteMapping(value="/{userId}")
	public boolean deleteAccount(@PathVariable(name = "userId") int userId,
			HttpServletResponse res, HttpSession session) {
		User user = (User) session.getAttribute("loginUser");
		if(userId != user.getUserId() && !user.getType().equals("ADMIN")) return false;
		return accountService.deleteAccountByAuthorId(userId);
	}
	
}
