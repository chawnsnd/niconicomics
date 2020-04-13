package com.niconicomics.core.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.niconicomics.core.user.dao.UserDao;

@Service
public class UserService {
	@Autowired
	private UserDao userDao;

	public boolean checkEmailValidation(String email) {
		if(userDao.selectCountByEmail(email)>=1) {
			return false;
		}
		else {
			return true;
		}
	}

}
