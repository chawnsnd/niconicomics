package com.niconicomics.core.route;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/dashboard")
@Controller
public class DashboardViewController {

	@GetMapping("")
	public String goDashboard() {
		return "dashboard/home";
	}
	
	//analysis
	@GetMapping(value = "/analysis")
	public String goAnalysis() {
		return "dashboard/analysis/list";
	}
	
	//account
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
	
	//webtoon - webtoon
	@GetMapping(value = "/webtoons")
	public String goWebtoons() {
		return "dashboard/webtoon/list";
	}
	@GetMapping(value = "/webtoons/insert")
	public String goInsertWebtoon() {
		return "dashboard/webtoon/insert";
	}
	@GetMapping(value = "/webtoons/{webtoonId}/update")
	public String goUpdateWebtoon(
		@PathVariable(value = "webtoonId") int webtoonId,
		Model model) {
		model.addAttribute("webtoonId", webtoonId);
		return "dashboard/webtoon/update";
	}
	@GetMapping(value = "/webtoons/{webtoonId}")
	public String goWebtoon(
		@PathVariable(value = "webtoonId") int webtoonId,
		Model model) {
		model.addAttribute("webtoonId", webtoonId);
		return "dashboard/webtoon/detail";
	}
	
	//webtoon - episode
	@GetMapping(value = "/webtoons/{webtoonId}/episodes/{episodeNo}/insert")
	public String goInsertEpisode(
			@PathVariable(name = "webtoonId") int webtoonId, 
			@PathVariable(name = "episodeNo") int episodeNo,
			Model model) {
		model.addAttribute("webtoonId", webtoonId);
		model.addAttribute("episodeNo", episodeNo);
		return "dashboard/webtoon/episode/insert";
	}
	@GetMapping(value = "/webtoons/{webtoonId}/episodes/{episodeNo}/update")
	public String goUpdateEpisode(
			@PathVariable(name = "webtoonId") int webtoonId, 
			@PathVariable(name = "episodeNo") int episodeNo,
			Model model) {
		model.addAttribute("webtoonId", webtoonId);
		model.addAttribute("episodeNo", episodeNo);
		return "dashboard/webtoon/episode/update";
	}
	
	@GetMapping(value = "/donate")
	public String goDonate() {
		return "dashboard/donate/donate";
	}

	//exchange
	@GetMapping(value = "/exchange")
	public String exchage() {
		return "dashboard/exchage/exchage";
	}
}
