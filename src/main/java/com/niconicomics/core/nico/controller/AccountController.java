package com.niconicomics.core.nico.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.niconicomics.core.exception.NotImageException;
import com.niconicomics.core.nico.dao.AccountDao;
import com.niconicomics.core.nico.service.AccountService;
import com.niconicomics.core.nico.vo.Account;
import com.niconicomics.core.user.vo.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/account")
public class AccountController {

	@Autowired
	private AccountDao accountDao;
	@Autowired
	private AccountService accountService;
	
	@ResponseBody
	@GetMapping(value="/{userId}")
	public Account getAccount(
			@PathVariable(name = "userId") int userId, 
			HttpSession session,
			HttpServletResponse res) {
		User user = (User) session.getAttribute("loginUser");
		if(!user.getType().equals("ADMIN")) {
			if(userId != user.getUserId()) {
				res.setStatus(403);
				return null;
			}
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
		if(!user.getType().equals("ADMIN")) {
			if(userId != user.getUserId()) {
				res.setStatus(403);
				return false;
			}
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
	@PatchMapping(value="/{userId}")
	public boolean modifyAccount(
			@PathVariable(name="userId") int userId,
			@RequestBody Account account,
			@RequestBody MultipartFile idCardImg, 
			@RequestBody MultipartFile copyOfBankbookImg,
			HttpServletResponse res,
			HttpSession session) {
		User user = (User) session.getAttribute("loginUser");
		if(!user.getType().equals("ADMIN")) {
			if(userId != user.getUserId()) {
				res.setStatus(403);
				return false;
			}
		}
		try {
			account.setAuthorId(userId);
			return accountService.modifyAccount(account, idCardImg, copyOfBankbookImg);
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
		if(!user.getType().equals("ADMIN")) {
			if(userId != user.getUserId()) {
				res.setStatus(403);
				return false;
			}
		}
		return accountDao.deleteAccountByAuthorId(userId);
	}
	
}
