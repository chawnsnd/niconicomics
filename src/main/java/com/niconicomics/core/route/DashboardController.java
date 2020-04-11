package com.niconicomics.core.route;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.niconicomics.core.webtoon.dao.EpisodeDao;
import com.niconicomics.core.webtoon.dao.WebtoonDao;
import com.niconicomics.core.webtoon.vo.Episode;
import com.niconicomics.core.webtoon.vo.Webtoon;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/dashboard")
@Controller
public class DashboardController {
	@Autowired
	private WebtoonDao dao;
	@Autowired
	private EpisodeDao episodeDao;
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
	
	@GetMapping(value = "/webtoons")
	public String goWebtoons() {
		log.debug("저쪽");
		return "dashboard/webtoon/list";
	}
	//뷰 컨트롤러에서 페이지를 반환함
	@GetMapping(value = "/webtoons/insert")
	public String goInsertWebtoon() {
		log.debug("이쪽");
		return "dashboard/webtoon/insert";
	}
	@GetMapping(value = "/webtoons/{webtoonId}/update")
	public String updateWebtoon(
		@PathVariable(value = "webtoonId") int webtoonId,
		Model model) {
		model.addAttribute("webtoonId", webtoonId);
		return "dashboard/webtoon/update";
	}
	@GetMapping(value = "/webtoons/{webtoonId}")
	public String GetMyWebtoon(
		@PathVariable(value = "webtoonId") int webtoonId,
		Model model) {
		model.addAttribute("webtoonId", webtoonId);
		return "dashboard/webtoon/episodeFront";
	}

	@GetMapping(value = "/webtoons/{webtoonId}/episodes")
	public String goEpisodeFront(@PathVariable(name = "webtoonId") int webtoonId, Model model) {
		log.debug("이쪽");
		model.addAttribute("webtoonId", webtoonId);
		return "dashboard/webtoon/insertEpisode";
	}					
	@GetMapping(value = "/webtoons/{webtoonId}/episodes/{episodeNo}/insert")
	public String goInsertEpisode(@PathVariable(name = "webtoonId") int webtoonId, Model model) {
		log.debug(Integer.toString(webtoonId));
		ArrayList<Episode> episodeList = episodeDao.selectEpisodeByWebtoonId(webtoonId);
		int max = episodeList.get(0).getEpisodeId();
		for (int i = 0; i < episodeList.size(); i++) {
			if (max<episodeList.get(i).getEpisodeId()) {
				max = episodeList.get(i).getEpisodeId();
			}
		}
		Episode episode = episodeDao.selectEpisodeByEpisodeId(max);
		model.addAttribute("myWebtoonLastestEpisode", episode);
		log.debug("이쪽");
		return "dashboard/webtoon/insertEpisode";
	}
	@GetMapping(value = "/webtoons/{webtoonId}/update")
	public String webtoonUpdate(
		@PathVariable(value = "webtoonId") int webtoonId,
		Model model) {
		model.addAttribute("webtoonId", webtoonId);
		return "dashboard/webtoon/update";
	}
	
	@GetMapping(value = "/exchange")
	public String exchage() {
		return "dashboard/exchage/exchage";
	}
}
