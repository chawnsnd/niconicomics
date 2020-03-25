package com.niconicomics.core;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.niconicomics.core.webtoon.vo.Webtoon;

import lombok.extern.slf4j.Slf4j;

@Slf4j
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
	
	@GetMapping(value = "/webtoons")
	public String goWebtoonFront() {
		log.debug("저쪽");
		return "dashboard/webtoon/webtoonFront";
	}
	
	@GetMapping(value = "/webtoons/insert")
	public String goInsertWebtoon() {
		log.debug("이쪽");
		return "dashboard/webtoon/insertWebtoon";
	}
}
