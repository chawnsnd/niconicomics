package com.niconicomics.core.user.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.niconicomics.core.user.dao.UserDao;
import com.niconicomics.core.user.service.UserService;
import com.niconicomics.core.user.vo.User;

@Controller
@RequestMapping("users")
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserDao userDao;
	@Autowired
	private UserService userService;
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test() {
		return "user";
	}
	
	// 이메일 중복 체크
	@RequestMapping(value = "/check-email", method = RequestMethod.POST)
	public @ResponseBody String checkEmail(String email) {
		
		boolean result = userService.checkEmailValidation(email);
		System.out.println("1: " + result);
		
		if (result == false) {
			System.out.println("2: " + result);
			return "no";
		} else {
			return "yes";
		}
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(String email, String password, String nickname, String birthdate, String gender, String type) throws Exception {
		logger.info("post join");
		
		User user = new User();
		
		user.setEmail(email);
		user.setPassword(password);
		user.setNickname(nickname);
		user.setBirthdate(birthdate);
		user.setGender(gender);
		user.setType(type);
		
		userDao.insertUser(user);
		
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
