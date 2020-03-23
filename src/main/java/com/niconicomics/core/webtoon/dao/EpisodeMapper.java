package com.niconicomics.core.webtoon.dao;

import java.util.ArrayList;

import com.niconicomics.core.webtoon.vo.Episode;

public interface EpisodeMapper {

	public int insertEpisode(Episode episode);
	public ArrayList<Episode> episodeList();
	public int updateEpisode(Episode episode);
	public int deleteEpisode(Episode episode);
}
