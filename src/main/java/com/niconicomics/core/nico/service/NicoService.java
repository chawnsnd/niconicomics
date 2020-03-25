package com.niconicomics.core.nico.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.niconicomics.core.user.dao.UserDao;
import com.niconicomics.core.user.vo.User;

@Service
public class NicoService {

	@Autowired
	private UserDao userDao;
	
	public boolean chargeNico(String loginEmail, int nico) {
//		User user = userDao.selectByUserEamil(loginEmail);
//		if(userDao.updateNico(user.getUserId(), nico)==1) {
//			return true;
//		}else {
			return false;
//		}
	}
	
}
