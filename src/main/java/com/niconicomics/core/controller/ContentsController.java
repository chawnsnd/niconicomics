package com.niconicomics.core.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.niconicomics.core.dao.EpisodeDao;
import com.niconicomics.core.dao.WebtoonDao;
import com.niconicomics.core.vo.Episode;
import com.niconicomics.core.vo.Webtoon;

@Controller

public class ContentsController {

	@Autowired
	private EpisodeDao dao;
	
	@RequestMapping(value = "/episodeInsert", method = RequestMethod.GET)
	public String webtoonInsert(Episode episode) {
		episode.setNo(1);
		episode.setTitle("testTitle2");
		episode.setWebtoonId(6);
		episode.setThumbnail("testThumbnail2");
		//테스트를 위한 강제 입력사항
		int result = dao.episodeInsert(episode);
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
	
}
