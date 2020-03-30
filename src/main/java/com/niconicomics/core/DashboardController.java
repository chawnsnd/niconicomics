package com.niconicomics.core;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
		return "dashboard/account/account";
	}

	@GetMapping(value = "/enroll-account")
	public String goEnrollAccount() {
		return "dashboard/account/enrollAccount";
	}

	@GetMapping(value = "/modify-account")
	public String goModifyAccount() {
		return "dashboard/account/modifyAccount";
	}
	
	@GetMapping(value = "/webtoons-list")
	public String goWebtoonFront() {
		log.debug("저쪽");
		return "dashboard/webtoon/webtoonFront";
	}
	
	@GetMapping(value = "/insert-webtoon")
	public String goInsertWebtoon() {
		log.debug("이쪽");
		return "dashboard/webtoon/insertWebtoon";
	}
	@GetMapping(value = "/insert-episode")
	public String goepisodeFront() {
		log.debug("이쪽");
		return "dashboard/webtoon/episodeFront";
	}
}
