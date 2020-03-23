package com.niconicomics.core.webtoon.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.niconicomics.core.webtoon.dao.UserDao;
import com.niconicomics.core.webtoon.vo.User;

@Controller
@RequestMapping("users")
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserDao dao;
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test() {
		return "user";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(String email, String password, String nickname, String birthdate, String gender, String type) throws Exception {
		User user = new User();
		
		user.setEmail(email);
		user.setPassword(password);
		user.setNickname(nickname);
		user.setBirthdate(birthdate);
		user.setGender(gender);
		user.setType(type);
		
		dao.insertUser(user);
		
		return "redirect:/";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(String email, String password, HttpSession session) {
		
		logger.debug("email: {}, password: {}", email, password);
		
		session.setAttribute("loginEmail", email);
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("loginEmail");
		return "redirect:/";
	}
}
