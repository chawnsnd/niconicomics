package com.niconicomics.core.webtoon.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.niconicomics.core.nico.dao.DonateDao;
import com.niconicomics.core.nico.service.DonateService;
import com.niconicomics.core.nico.vo.Donate;
import com.niconicomics.core.webtoon.dao.ContentsDao;
import com.niconicomics.core.webtoon.dao.DotpleDao;
import com.niconicomics.core.webtoon.dao.EpisodeDao;
import com.niconicomics.core.webtoon.dao.WebtoonDao;
import com.niconicomics.core.webtoon.vo.Contents;
import com.niconicomics.core.webtoon.vo.Dotple;
import com.niconicomics.core.webtoon.vo.Webtoon;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/webtoons")
public class DotpleController {
	
	@Autowired
	private ContentsDao contentsDao;
	@Autowired
	private EpisodeDao episodeDao;
	@Autowired
	private DotpleDao dotpleDao;
	@Autowired
	private DonateService donateService;
	@Autowired
	private WebtoonDao webtoonDao;
	
	@GetMapping(value = "/{webtoonId}/episodes/{episodeNo}/dotples")
	public ArrayList<Dotple> getDotples(
			@PathVariable int webtoonId,
			@PathVariable int episodeNo) {
		int episodeId = episodeDao.selectEpisodeByWebtoonIdAndEpisodeNo(webtoonId, episodeNo).getEpisodeId();
		Map<Integer, ArrayList<Dotple>> result = new HashMap<Integer, ArrayList<Dotple>>();
		return dotpleDao.selectDotpleListByEpisodeId(episodeId);
	}
	
	@PostMapping(value = "/{webtoonId}/episodes/{episodeNo}/dotples")
	public Dotple postDotple(
			@PathVariable int webtoonId,
			@PathVariable int episodeNo,
			Dotple dotple,
			int nico) {
		dotple.setType("GENERAL");
		if(nico > 0) {
			Webtoon webtoon = webtoonDao.selectWebtoonByWebtoonId(webtoonId);
			Donate donate = new Donate();
			donate.setNico(nico);
			donate.setSponsorId(dotple.getUserId());
			donate.setAuthorId(webtoon.getAuthorId());
			donate.setWebtoonId(webtoonId);
			if(!donateService.donate(donate)) return null;
			dotple.setType("DONATE");
		}
		int episodeId = episodeDao.selectEpisodeByWebtoonIdAndEpisodeNo(webtoonId, episodeNo).getEpisodeId();
		int contentsId = contentsDao.selectContentsByEpsodeIdAndIdx(episodeId, dotple.getIdx()).getContentsId();
		dotple.setContentsId(contentsId);
		return dotpleDao.insertDotple(dotple);
	}
	
	@DeleteMapping(value = "/{webtoonId}/episodes/{episodeNo}/dotples/{dotpleId}")
	public void deleteDoptle(
			@PathVariable int webtoonId,
			@PathVariable int episodeNo,
			@PathVariable int dotpleId) {
		dotpleDao.deleteDotpleByDotpleId(dotpleId);
	}
	
}
