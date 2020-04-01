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

import com.niconicomics.core.user.vo.User;
import com.niconicomics.core.webtoon.dao.EpisodeDao;
import com.niconicomics.core.webtoon.dao.WebtoonDao;
import com.niconicomics.core.webtoon.vo.Episode;
import com.niconicomics.core.webtoon.vo.Webtoon;

import lombok.extern.slf4j.Slf4j;

@Controller

public class EpisodeController {

	@Autowired
	private EpisodeDao dao;
	
	@ResponseBody
	@RequestMapping(value = "/webtoons/{webtoonId}/episodeInsert", method = RequestMethod.GET)
	public String webtoonInsert(Episode episode,@PathVariable(name = "webtoonId") int webtoonId) {
		System.out.println(episode.toString());
		//int result = dao.insertEpisode(episode);
		return "home";
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
	@RequestMapping(value = "/updateEpisode", method = RequestMethod.GET)
	public String updateEpisode(Episode episode) {
		episode.setWebtoonId(7);
		episode.setEpisodeId(3);
		episode.setNo(4);
		//episode.setTitle("updatedTitle");
		episode.setThumbnail("updatedThumbnail");
		//테스트를 위한 강제 입력사항
		int result = dao.updateEpisode(episode);
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
