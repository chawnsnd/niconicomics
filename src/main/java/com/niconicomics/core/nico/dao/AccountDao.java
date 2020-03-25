package com.niconicomics.core.nico.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.niconicomics.core.nico.vo.Account;

@Repository
public class AccountDao {

	@Autowired
	private SqlSession session;
	
	public boolean insertAccount(Account account) {
		AccountMapper mapper = session.getMapper(AccountMapper.class);
		if(mapper.insertAccount(account)==1) {
			return true;
		}else {
			return false;
		}
	}

	public Account selectAccountByAuthorId(int authorId) {
		AccountMapper mapper = session.getMapper(AccountMapper.class);
		return mapper.selectAccountByAuthorId(authorId);
	}

	public Account selectAccountByAccountId(int accountId) {
		AccountMapper mapper = session.getMapper(AccountMapper.class);
		return mapper.selectAccountByAccountId(accountId);
	}
	
}
