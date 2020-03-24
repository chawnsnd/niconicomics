package com.niconicomics.core.user.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.niconicomics.core.chat.controller.ChatController;
import com.niconicomics.core.user.dao.UserDao;
import com.niconicomics.core.user.service.UserService;
import com.niconicomics.core.user.util.UserUtil;
import com.niconicomics.core.user.vo.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("users")
public class UserController {
	
	@Autowired
	private UserDao userDao;
	@Autowired
	private UserService userService;
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String test() {
		return "user/join";
	}
	
	// 이메일 중복 체크
	@RequestMapping(value = "/check-email", method = RequestMethod.POST)
	public @ResponseBody String checkEmail(String email) {
		
		boolean result = userService.checkEmailValidation(email);
		
		if (result == false) {
			return "no";
		} else {
			return "yes";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(String email, String password, String nickname,String type, String birthdate, String gender) throws Exception {
		
		boolean result = userService.checkEmailValidation(email);
		if(!result) {
			return "no";
		}
		User user = new User();
		String salt = UserUtil.makeSalt();
		String hashedPassword = UserUtil.hashBySHA256(password, salt);

		user.setEmail(email);
		user.setPassword(hashedPassword);
		user.setType(type);
		user.setNickname(nickname);
		user.setBirthdate(birthdate);
		user.setGender(gender);
		user.setSalt(salt);
		
		int result2 = userDao.insertUser(user);
		if(result2!=1) {
			return "no";
		}else {
			return "yes";
		}
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String goLogin() {
		
		return "user/login";
	}
	
	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(String email, String password, HttpSession session) {
		
		System.out.println(email+","+password);
//		System.out.println("email: {}, password: {}", email, password);
		
		User user = userDao.selectUserByEmail(email);
		
		String salt = user.getSalt();
		String hashedPassword = UserUtil.hashBySHA256(password, salt);
		
		if(user != null && hashedPassword.equals(user.getPassword())) {
			session.setAttribute("loginUser", user);
			return "yes";
		}
		else {
			return "no";
		}
		
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("loginEmail");
		return "redirect:/";
	}
	
	
}
