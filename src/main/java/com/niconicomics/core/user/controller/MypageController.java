package com.niconicomics.core.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("users")
public class MypageController {
	
	@GetMapping(value = "/join")
	public String test() {
		return "user/join";
	}
	
	@GetMapping(value="/join2")
	public String goJoin2() {
		return "user/sendEmail";
	}

	@GetMapping(value = "/login")
	public String goLogin() {
		return "user/login";
	}

	@GetMapping(value = "/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginUser");
		return "redirect:/";
	}
	
	@GetMapping(value = "/me/profile")
	public String myPage() {
		return "user/me/profile";
	}
	
	@GetMapping(value = "/me/edit-profile")
	public String selectUser() {
		return "user/me/editProfile";
	}
	
	@GetMapping(value = "/me/change-to-author")
	public String changeType() {
		return "user/me/changeType";
	}
	
	@GetMapping(value = "/me/setting")
	public String setting() {
		return "user/me/setting";
	}
}
