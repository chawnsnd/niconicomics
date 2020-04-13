package com.niconicomics.core.route;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/users")
public class UserViewController {
	
	@GetMapping(value = "/join")
	public String test() {
		return "user/join1";
	}
	
	@GetMapping(value="/join2")
	public String goJoin2() {
		return "user/join2";
	}

	@GetMapping(value = "/login")
	public String goLogin() {
		return "user/login";
	}
	

	@GetMapping(value = "/mypage/charge-nico")
	public String goChargeNico() {
		return "user/mypage/chargeNico";
	}
	
	@GetMapping(value = "/mypage/profile")
	public String myPage() {
		return "user/mypage/profile";
	}
	
	@GetMapping(value = "/mypage/edit-profile")
	public String goEditProfile() {
		return "user/mypage/editProfile";
	}
	
	@GetMapping(value = "/mypage/edit-password")
	public String goEditPassword() {
		return "user/mypage/editPassword";
	}
	
	@GetMapping(value = "/mypage/change-to-author")
	public String changeType() {
		return "user/mypage/changeType";
	}
	
	@GetMapping(value = "/mypage/setting")
	public String setting() {
		return "user/mypage/setting";
	}
}
