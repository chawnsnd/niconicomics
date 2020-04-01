package com.niconicomics.core.nico.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.niconicomics.core.nico.dao.DonateDao;
import com.niconicomics.core.nico.vo.Donate;
import com.niconicomics.core.user.dao.UserDao;
import com.niconicomics.core.user.vo.User;

@Service
public class NicoService {

	@Autowired
	private UserDao userDao;
	@Autowired
	private DonateDao donateDao;
	
	@Transactional
	public boolean chargeNico(int userId, int nico) {
		User user = userDao.selectUserByUserId(userId);
		user.setNico(user.getNico()+nico);
//		User user = userDao.selectByUserEamil(loginEmail);
//		if(userDao.updateNico(user.getUserId(), nico)==1) {
//			return true;
//		}else {
			return false;
//		}
	}

	@Transactional
	public boolean donateNico(int authorId, int sponsorId, int nico) {
		User author = userDao.selectUserByUserId(authorId);
		User sponsor = userDao.selectUserByUserId(sponsorId);
		int renico = (int)(nico * 0.97); //수수료 3% 
		author.setNico(author.getNico()+renico);
		sponsor.setNico(sponsor.getNico()-renico);
		Donate donate = new Donate();
		donate.setNico(renico);
		donateDao.insertDonate(donate);
//		if(userDao.updateUser(author) == 1 && sponsor.updateUser(sponsor)) {
			return true;
//		}else {
//			return false;
//		}
	}
	
}
