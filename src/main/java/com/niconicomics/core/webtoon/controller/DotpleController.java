package com.niconicomics.core.webtoon.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.niconicomics.core.nico.dao.DonateDao;
import com.niconicomics.core.nico.vo.Donate;
import com.niconicomics.core.webtoon.dao.ContentsDao;
import com.niconicomics.core.webtoon.dao.DotpleDao;
import com.niconicomics.core.webtoon.dao.EpisodeDao;
import com.niconicomics.core.webtoon.vo.Contents;
import com.niconicomics.core.webtoon.vo.Dotple;

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
	private DonateDao donateDao;
	
	@GetMapping(value = "/{webtoonId}/episodes/{episodeNo}/dotples")
	public Map<Integer, ArrayList<Dotple>> getDotples(
			@PathVariable int webtoonId,
			@PathVariable int episodeNo) {
		int episodeId = episodeDao.selectEpisodeByWebtoonIdAndEpisodeNo(webtoonId, episodeNo).getEpisodeId();
		Map<Integer, ArrayList<Dotple>> result = new HashMap<Integer, ArrayList<Dotple>>();
		ArrayList<Contents> contentsList = contentsDao.selectContentsListByEpisodeId(episodeId);
		for (Contents contents : contentsList) {
			result.put(contents.getIdx(), dotpleDao.selectDotpleListByContentsId(contents.getContentsId()));
		}
		return result;
	}
	
	@PostMapping(value = "/{webtoonId}/episodes/{episodeNo}/dotples")
	public void postDotple(
			@PathVariable int webtoonId,
			@PathVariable int episodeNo,
			Dotple dotple) {
		int episodeId = episodeDao.selectEpisodeByWebtoonIdAndEpisodeNo(webtoonId, episodeNo).getEpisodeId();
		int contentsId = contentsDao.selectContentsByEpsodeIdAndIdx(episodeId, dotple.getIdx()).getContentsId();
		dotple.setContentsId(contentsId);
		dotpleDao.insertDotple(dotple);
	}
}
