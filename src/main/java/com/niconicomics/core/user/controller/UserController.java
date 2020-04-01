package com.niconicomics.core.user.controller;

import java.io.IOException;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.niconicomics.core.user.dao.UserDao;
import com.niconicomics.core.user.service.MailService;
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
	@Autowired
	private MailService mailService;
	
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
	
	@GetMapping(value="/join2")
	public String goJoin2() {
		return "user/sendEmail";
	}
	
	@ResponseBody
	@RequestMapping(value = "/join2", method = RequestMethod.POST)
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
	
	@ResponseBody
	@RequestMapping(value = "/join1", method = RequestMethod.GET)
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
		session.removeAttribute("loginUser");
		return "redirect:/";
	}
	
	
}
