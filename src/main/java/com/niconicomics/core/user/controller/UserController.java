package com.niconicomics.core.user.controller;

import java.io.IOException;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.niconicomics.core.nico.vo.Account;
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
	
	@GetMapping(value = "/join")
	public String test() {
		return "user/join";
	}
	
	@ResponseBody
	@GetMapping(value ="/api/users/me")
	public User getMe(HttpSession session) {
		User user = (User) session.getAttribute("loginUser");
		User newUser = userDao.selectUserByUserId(user.getUserId());
		//나를 찾는로직
		return newUser;
	}

	@ResponseBody
	@GetMapping(value ="/api/users/{userId}")
	public User getUser(@PathVariable(name = "userId") int userId) {
		User user = userDao.selectUserByUserId(userId);
		user.setPassword(null);
		//나를 찾는로직
		return user;
	}
	
	// 이메일 중복 체크
	@PostMapping(value = "/check-email")
	public String checkEmail(String email) {
		
		boolean result = userService.checkEmailValidation(email);
		
		if (!result) {
			return "no";
		} else {
			return "yes";
		}
	}
	
	@PostMapping(value = "/join1")
	public boolean authorizeEmail(HttpSession session, User user, HttpServletResponse response_email) throws IOException {
		
		System.out.println("send-mail check : " + user.getEmail());
		
		String random = Integer.toString(new Random().nextInt(900000)+100000);
		
		session.setAttribute("random", random);
		session.setAttribute("user", user);
		// 보내는 사람 주소
		String fromEmail = "niconicomics@gmail.com";
		// 제목
		String subject = "[niconicomics] Please verify your email address.";
		// 내용
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
	public Boolean sendEmail(String random, HttpSession session) {
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
	
	// 기존 비밀번호 확인
	@PostMapping(value = "/check-password")
	public String checkPassword(HttpSession session, String userId, String password) {
		
		User user = (User)session.getAttribute("loginUser");
		
		String salt = user.getSalt();
		String hashedPassword = UserUtil.hashBySHA256(password, salt);
		
		if(user != null && hashedPassword.equals(user.getPassword())) {
			return "yes";
		}
		else {
			return "no";
		}
	}
	
	@GetMapping(value="/{userId}")
	public User getMe(
			@PathVariable(name = "userId") int userId, 
			HttpSession session,
			HttpServletResponse res) {
		User user = (User) session.getAttribute("loginUser");
		
		User newUser = userDao.selectUserByUserId(user.getUserId());
		return newUser;
	}
	
	
	@PostMapping(value = "/{userId}/edit-profile")
	public String editUser(
			HttpSession session,
			String nickname,
			String password,
			@PathVariable(name = "userId") int userId) {
		User user = (User)session.getAttribute("loginUser");
		System.out.println(user.toString());
		
		if(userId == user.getUserId()) {
			user.setNickname(nickname);
			
			if(!password.equals("") && password != null) {
				String salt = user.getSalt();
				String hashedPassword = UserUtil.hashBySHA256(password, salt);
				user.setPassword(hashedPassword);
			}
			
			boolean result = userDao.editUser(user);
			if (result) {
				return "yes";
			} else {
				return "no";
			}
		} else {
			return "no";
		}
		
	}
	
	@PostMapping(value = "/{userId}/change-to-author")
	public String changeType(
			HttpSession session,
			@PathVariable(name = "userId") int userId) {
		User user = (User)session.getAttribute("loginUser");
		if(userId == user.getUserId()) {
			user.setType("AUTHOR");
			boolean result = userDao.editUser(user);
			if(result) {
				return "yes";
			} else {
				return "no";
			}
		} else {
			return "no";
		}
	}
	
	@PostMapping(value = "/{userId}/setting")
	public String setting(
			HttpSession session,
			String setDotple,
			String setChat,
			@PathVariable(name = "userId") int userId
			) {
		User user = (User)session.getAttribute("loginUser");
		if(userId == user.getUserId()) {
			user.setShowDotple(setDotple);
			user.setShowChat(setChat);
			
			System.out.println(user.toString());
			
			boolean result = userDao.editUser(user);
			if(result) {
				return "yes";
			} else {
				return "no";
			}
		} else {
			return "no";
		}
	}
}
