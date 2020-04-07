package com.niconicomics.core.webtoon.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.niconicomics.core.user.vo.User;
import com.niconicomics.core.webtoon.dao.EpisodeDao;
import com.niconicomics.core.webtoon.dao.WebtoonDao;
import com.niconicomics.core.webtoon.vo.Episode;
import com.niconicomics.core.webtoon.vo.Webtoon;

import lombok.extern.slf4j.Slf4j;
@Slf4j
@RestController
@RequestMapping("/api/webtoons")
public class EpisodeController {

	@Autowired
	private EpisodeDao dao;
	@ResponseBody
	@RequestMapping(value = "/{webtoonId}", method = RequestMethod.GET)
	public ArrayList<Episode> myEpisodeList(int authorId,
			@PathVariable (value="webtoonId") int webtoonId) {
		log.debug(Integer.toString(authorId));
		ArrayList<Episode> getEpisodeList = dao.episodeSelectList(webtoonId);
		return getEpisodeList;
	}
	@ResponseBody
	@RequestMapping(value = "/{webtoonId}/episodes/insert", method = RequestMethod.POST)
	public void webtoonInsert(
			Episode episode, 
			HttpSession session) { 
		dao.insertEpisode(episode);
		ArrayList<Episode> getAllEpiosdeList = dao.episodeAllList();
		int max = getAllEpiosdeList.get(0).getEpisodeId();
		System.out.println(max);
		for (int i = 0; i < getAllEpiosdeList.size(); i++) {
			if (max<getAllEpiosdeList.get(i).getEpisodeId()) {
				max = getAllEpiosdeList.get(i).getEpisodeId();
			}
		}
		Episode lastestEpisode = dao.selectEpisodeByEpisodeId(max);
		System.out.println(lastestEpisode);
		session.setAttribute("newEpisode", lastestEpisode);
	}
	@RequestMapping(value = "/episodeList", method = RequestMethod.GET)
	public String webtoonList() {
		ArrayList<Episode> list = dao.episodeList();
		//테스트를 위한 강제 입력사항
		for (int i = 0; i < list.size(); i++) {
			System.out.println(list.get(i));
		}
		return "home";
	}
	
	@RequestMapping(value = "/{webtoonId}/episodes/{episodeId}", method = RequestMethod.PATCH)
	public String updateEpisode(Episode episode
			,@PathVariable(value = "webtoonId") int webtoonId
			,@PathVariable(value = "episodeId") int episodeId) {
		//int result = dao.updateEpisode(episode);
		return "home";
	}
	@RequestMapping(value = "/deleteEpisode", method = RequestMethod.GET)
	public String deleteEpisode(Episode episode) {
		episode.setWebtoonId(7);
		episode.setEpisodeId(4);
		//테스트를 위한 강제 입력사항
		int result = dao.deleteEpisode(episode);
		return "home";
	}
	
}
