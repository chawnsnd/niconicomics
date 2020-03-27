package com.niconicomics.core.nico.dao;

import com.niconicomics.core.nico.vo.Account;

public interface AccountMapper {
	
	public Account selectAccountByAccountId(int accountId);
	public Account selectAccountByAuthorId(int authorId);
	public int insertAccount(Account account);
	public int updateAccount(Account account);
	public int deleteAccountByAuthorId(int authorId);
	
}
