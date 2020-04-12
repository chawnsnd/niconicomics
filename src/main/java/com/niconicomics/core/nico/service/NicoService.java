package com.niconicomics.core.nico.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.niconicomics.core.nico.dao.AccountDao;
import com.niconicomics.core.nico.dao.DonateDao;
import com.niconicomics.core.nico.vo.Account;
import com.niconicomics.core.nico.vo.Donate;
import com.niconicomics.core.user.dao.UserDao;
import com.niconicomics.core.user.vo.User;

@Service
public class NicoService {

	@Autowired
	private UserDao userDao;
	@Autowired
	private DonateDao donateDao;
	@Autowired
	private OpenBankingService openBankingService;
	@Autowired
	private AccountDao accountDao;
	
	@Transactional
	public boolean chargeNico(int userId, int nico) {
		User user = userDao.selectUserByUserId(userId);
		user.setNico(user.getNico()+nico);
		if(userDao.updateUser(user)) {
			return true;
		}else {
			return false;
		}
	}

	@Transactional
	public boolean donateNico(int authorId, int sponsorId, int webtoonId, int nico) {
		User author = userDao.selectUserByUserId(authorId);
		User sponsor = userDao.selectUserByUserId(sponsorId);
		int renico = (int)(nico * 0.97); //수수료 3% 
		author.setNico(author.getNico()+renico);
		sponsor.setNico(sponsor.getNico()-renico);
		Donate donate = new Donate();
		donate.setNico(renico);
		donate.setAuthorId(authorId);
		donate.setSponsorId(sponsorId);
		donate.setWebtoonId(webtoonId);
		if(userDao.updateUser(author) && userDao.updateUser(sponsor) && donateDao.insertDonate(donate)) {
			return true;
		}else {
			return false;
		}
	}

	@Transactional
	public boolean exchageNico(int userId, int nico) {
		User user = userDao.selectUserByUserId(userId);
		Account account = accountDao.selectAccountByAuthorId(userId);
		openBankingService.transfer(account, nico);
		user.setNico(user.getNico()-nico);
		return false;
	}
	
}
