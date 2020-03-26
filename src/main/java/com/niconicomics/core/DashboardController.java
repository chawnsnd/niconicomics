package com.niconicomics.core;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/dashboard")
@Controller
public class DashboardController {

	@GetMapping("")
	public String goDashboard() {
		return "dashboard/home";
	}
	
	@GetMapping(value = "/account")
	public String goAccount() {
		return "dashboard/account";
	}

	@GetMapping(value = "/enroll-account")
	public String goEnrollAccount() {
		return "dashboard/enrollAccount";
	}
	
}
