package com.niconicomics.core.route;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.niconicomics.core.nico.dao.AccountDao;
import com.niconicomics.core.nico.vo.Account;

@RequestMapping("/admin")
@Controller
public class AdminViewController {

	@Autowired
	private AccountDao accountDao;
	
	@GetMapping("/account/{userId}")
	public String goAccount(@PathVariable(name = "userId") int userId) {
		return "admin/account";
	}
	
	@ResponseBody
	@PatchMapping("/account/{userId}/approve")
	public boolean appoveAccount(@PathVariable(name="userId") int userId) {
		Account account = new Account();
		account.setAuthorId(userId);
		account.setApproved("TRUE");
		return accountDao.updateAccount(account);
	}
}
	