package com.niconicomics.core.webtoon.dao;

import java.util.ArrayList;

import com.niconicomics.core.webtoon.vo.Episode;

public interface EpisodeMapper {

	public int insertEpisode(Episode episode);
	public ArrayList<Episode> episodeSelectList(int webtoonId);
	public ArrayList<Episode> episodeAllList();
	public int updateEpisode(Episode episode);
	public int deleteEpisode(Episode episode);
	public Episode selectEpisodeByEpisodeId(int episodeId);
	public Episode selectEpisodeByEpisodeNo(int episodeNo);
	public Episode selectEpisodeByWebtoonId(int WebtoonId);
	
}
