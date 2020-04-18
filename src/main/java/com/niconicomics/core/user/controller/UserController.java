package com.niconicomics.core.user.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.niconicomics.core.user.dao.UserDao;
import com.niconicomics.core.user.service.MailService;
import com.niconicomics.core.user.service.UserService;
import com.niconicomics.core.user.util.UserUtil;
import com.niconicomics.core.user.vo.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/users")
public class UserController {
	
	@Autowired
	private UserDao userDao;
	@Autowired
	private UserService userService;
	@Autowired
	private MailService mailService;
	
	@GetMapping(value ="/me")
	public User getMe(HttpSession session) {
		User user = (User) session.getAttribute("loginUser");
		if(user == null) return null;
		User newUser = userDao.selectUserByUserId(user.getUserId());
		return newUser;
	}

	@GetMapping(value ="/{userId}")
	public User getUser(@PathVariable(name = "userId") int userId) {
		User user = userDao.selectUserByUserId(userId);
		user.setPassword(null);
		return user;
	}
	
	@PostMapping(value = "/check-email")
	public boolean checkEmail(String email) {
		return userService.checkEmailValidation(email);
	}
	
	@PostMapping(value = "/join1")
	public boolean join1(HttpSession session, User user, HttpServletResponse response_email) throws IOException {
		String random = Integer.toString(new Random().nextInt(900000)+100000);
		session.setAttribute("random", random);
		session.setAttribute("user", user);
		
		String fromEmail = "niconicomics@gmail.com";
		String subject = "[niconicomics] Please verify your email address.";
		String text =
				"Hi,"+
				System.lineSeparator()+
				"We recieved a request to verify " + user.getEmail() + " as your email account."+
				System.lineSeparator()+
				"If you made this request, use the code below to complete the verification process:"+
				System.lineSeparator()+
				random+
				System.lineSeparator()+
				System.lineSeparator()+
				"Thanks,"+
				"niconicomics Security Team";
		
		return mailService.sendMail(subject, text, fromEmail, user.getEmail(), null);
	}
	
	@PostMapping(value = "/join2")
	public boolean join2(String random, HttpSession session) {
		String sessionRandom = (String)session.getAttribute("random");
		User user = (User)session.getAttribute("user");
		if(sessionRandom.equals(random)) {
			boolean result = userService.checkEmailValidation(user.getEmail());
			if(!result) {
				return false;
			}
			String salt = UserUtil.makeSalt();
			String hashedPassword = UserUtil.hashBySHA256(user.getPassword(), salt);
			user.setPassword(hashedPassword);
			user.setSalt(salt);
			
			int result2 = userDao.insertUser(user);
			if(result2!=1) {
				return false;
			}else {
				return true;
			}
		}else {
			return false;
		}
	}

	@PostMapping(value = "/login")
	public boolean login(String email, String password, HttpSession session) {
		User user = userDao.selectUserByEmail(email);
		if(user == null) return false;
		String salt = user.getSalt();
		String hashedPassword = UserUtil.hashBySHA256(password, salt);
		if(hashedPassword.equals(user.getPassword())) {
			session.setAttribute("loginUser", user);
			return true;
		} else {
			return false;
		}	
	}
	
	@GetMapping(value = "/logout")
	public void logout(HttpSession session) {
		session.removeAttribute("loginUser");
	}
	
	@PostMapping(value = "/check-password")
	public boolean checkPassword(HttpSession session, int userId, String password) {
		User user = userDao.selectUserByUserId(userId);
		String salt = user.getSalt();
		String hashedPassword = UserUtil.hashBySHA256(password, salt);
		if(hashedPassword.equals(user.getPassword())) return true;
		else return false;
	}
	
	@PatchMapping(value = "/{userId}")
	public void editUser(
			HttpSession session,
			@RequestBody User newUser,
			@PathVariable int userId) {
		User user = (User) session.getAttribute("loginUser");
		log.debug(newUser.toString());
		if(userId != user.getUserId()) return;
		if(newUser.getPassword() != null) newUser.setPassword(UserUtil.hashBySHA256(newUser.getPassword(), user.getSalt()));
		newUser.setUserId(userId);
		userDao.updateUser(newUser);
	}
}
