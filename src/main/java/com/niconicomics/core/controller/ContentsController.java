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

import com.niconicomics.core.dao.ContentsDao;
import com.niconicomics.core.dao.EpisodeDao;
import com.niconicomics.core.dao.WebtoonDao;
import com.niconicomics.core.vo.Contents;
import com.niconicomics.core.vo.Episode;
import com.niconicomics.core.vo.Webtoon;

@Controller

public class ContentsController {

	@Autowired
	private ContentsDao dao;
	
	@RequestMapping(value = "/insertContents", method = RequestMethod.GET)
	public String insertContents(Contents contents) {
		contents.setEpisodeId(2);
		contents.setIdx(2);
		contents.setImage("testImgRoot");
		//테스트를 위한 강제 입력사항
		int result = dao.insertContents(contents);
		return "home";
	}
	@RequestMapping(value = "/getContents", method = RequestMethod.GET)
	public String getContents() {
		int episodeId = 1;
		//테스트를 위한 강제입력사항
		ArrayList<Contents> contentsList = dao.getContents(episodeId);
		for (int i = 0; i < contentsList.size(); i++) {
			System.out.println(contentsList.get(i));
		}
		return "home";
	}
	@RequestMapping(value = "/updateContents", method = RequestMethod.GET)
	public String updateContents(Contents contents) {
		contents.setIdx(4);
		contents.setImage("img");
		contents.setEpisodeId(2);
		contents.setContentsId(15);
		//테스트를 위한 강제입력사항
		int result = dao.updateContents(contents);
		return "home";
	}
	@RequestMapping(value = "/uploadPractice", method = RequestMethod.GET)
	public String updatePracitce() {
		
		return "uploadPractice";
	}
	
	
}
