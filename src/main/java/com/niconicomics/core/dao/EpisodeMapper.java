package com.niconicomics.core.dao;

import java.util.ArrayList;

import com.niconicomics.core.vo.Episode;

public interface EpisodeMapper {

	public int insertEpisode(Episode episode);
	public ArrayList<Episode> episodeList();
	public int updateEpisode(Episode episode);
	public int deleteEpisode(Episode episode);
}
