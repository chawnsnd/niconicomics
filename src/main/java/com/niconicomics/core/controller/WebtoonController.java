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
import com.niconicomics.core.util.SplitTag;
import com.niconicomics.core.vo.Webtoon;

@Controller

public class WebtoonController {

	@Autowired
	private WebtoonDao dao;
	SplitTag tag;
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
		Webtoon webtoon = dao.webtoonGet(7);
		System.out.println(webtoon.toString());
		//테스트를 위한 강제 입력사항
		//매개변수는 추후 추가예정
		String hashtag = webtoon.getHashtag();
		String mgrHashtag = webtoon.getMgrHashtag();
		//String[] arrayHashtag = hashtag.split("#");
		//String[] arrayMgrHashtag = mgrHashtag.split("#");
		tag.splitTag(hashtag);
		tag.splitTag(mgrHashtag);
		for (int i = 1; i < tag.splitTag(hashtag).size(); i++) {
			System.out.println("#"+tag.splitTag(mgrHashtag).get(i));
		}
		for (int i = 1; i < tag.splitTag(mgrHashtag).size(); i++) {
			System.out.println("#"+tag.splitTag(mgrHashtag).get(i));
		}//해시태그를 빼는 유틸패키지로, 포스트맨
		return "home";
	}
	@RequestMapping(value = "/updateWebtoon", method = RequestMethod.GET)
	public String updateWebtoon(Webtoon webtoon) {
		webtoon.setWebtoonId(6);
		webtoon.setTitle("test");
		webtoon.setSummary("testUpdateSummary");
		webtoon.setAuthorId(1);
		webtoon.setHashtag("#일상#개그");
		webtoon.setMgrHashtag("#시간순삭#일단클릭");
		webtoon.setThumbnail("testThumbnail");
		webtoon.setEnd("end");
		//테스트를 위한 강제 입력사항
		int result = dao.updateWebtoon(webtoon);
		return "home";
	}
	@RequestMapping(value = "/deleteWebtoon", method = RequestMethod.GET)
	public String deleteWebtoon(Webtoon webtoon) {
		webtoon.setAuthorId(1);
		webtoon.setWebtoonId(6);
		//테스트를 위한 강제 입력사항
		int result = dao.deleteWebtoon(webtoon);
		return "home";
	}
	@RequestMapping(value = "/updateHits", method = RequestMethod.GET)
	public String updateHits() {
		int webtoonId = 7;
		//테스트를 위한 강제 입력사항
		dao.updateHits(webtoonId);
		return "home";
	}
}
