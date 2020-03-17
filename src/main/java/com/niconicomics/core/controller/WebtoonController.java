package com.niconicomics.core.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.niconicomics.core.dao.WebtoonDao;
import com.niconicomics.core.vo.Webtoon;

@Controller

public class WebtoonController {

	@Autowired
	private WebtoonDao dao;
	
	@RequestMapping(value = "/webtoonInsert", method = RequestMethod.GET)
	public String webtoonInsert(Webtoon webtoon) {
		webtoon.setTitle("test");
		webtoon.setSummary("testSummary");
		webtoon.setAuthorId(1);
		webtoon.setHashtag("#일상#개그");
		webtoon.setMgrHashtag("#시간순삭#일단클릭");
		webtoon.setThumbnail("testThumbnail");
		webtoon.setEnd("end");
		//테스트를 위한 강제 입력사항
		int result = dao.webtoonInsert(webtoon);
		return "home";
	}
	@RequestMapping(value = "/webtoonGet", method = RequestMethod.GET)
	public String webtoonGet() {
		Webtoon webtoon = dao.webtoonGet(6);
		System.out.println(webtoon.toString());
		//테스트를 위한 강제 입력사항
		//매개변수는 추후 추가예정
		String hashtag = webtoon.getHashtag();
		String mgrHashtag = webtoon.getMgrHashtag();
		String[] arrayHashtag = hashtag.split("#");
		String[] arrayMgrHashtag = mgrHashtag.split("#");
		for (int i = 1; i < arrayHashtag.length; i++) {
			System.out.println("#"+arrayHashtag[i]);
		}
		for (int i = 1; i < arrayMgrHashtag.length; i++) {
			System.out.println("#"+arrayMgrHashtag[i]);
		}
		return "home";
	}
}
