package com.niconicomics.core.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.niconicomics.core.dao.UserDao;

@Controller
@RequestMapping("users")
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserDao dao;
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join() {
		return "user";
	}
	
	
}
