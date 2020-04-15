package com.niconicomics.core.nico.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.niconicomics.core.nico.dao.AccountDao;
import com.niconicomics.core.nico.dao.DonateDao;
import com.niconicomics.core.nico.dao.TransferDao;
import com.niconicomics.core.nico.vo.Account;
import com.niconicomics.core.nico.vo.Donate;
import com.niconicomics.core.nico.vo.Transfer;
import com.niconicomics.core.nico.vo.TransferDepositReqItem;
import com.niconicomics.core.user.dao.UserDao;
import com.niconicomics.core.user.vo.User;

@Service
public class NicoService {
	
	private static final double FEES = 0.03;

	@Autowired
	private UserDao userDao;
	@Autowired
	private OpenBankingService openBankingService;
	@Autowired
	private AccountDao accountDao;
	@Autowired
	private TransferDao transferDao;
	
	@Transactional
	public boolean chargeNico(int userId, int nico) {
		User user = userDao.selectUserByUserId(userId);
		user.setNico(user.getNico()+nico);
		return userDao.updateUser(user);
	}

	@Transactional
	public boolean exchageNico(int userId, int nico) {
		User user = userDao.selectUserByUserId(userId);
		Account account = accountDao.selectAccountByAuthorId(userId);
		int amount = (int) (nico * (1-FEES));
		if(user.getNico()-amount < 0) return false;
		if(!openBankingService.transfer(account, amount)) return false;
		user.setNico(user.getNico()-nico);
		Transfer transfer = new Transfer();
		transfer.setAccountId(userId);
		transfer.setNico(nico);
		transfer.setAmount(amount);
		if(userDao.updateUser(user) && transferDao.insertTransfer(transfer)) {
			return true;
		}else {			
			return false;
		}
	}
	
}
