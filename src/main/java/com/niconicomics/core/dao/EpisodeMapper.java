package com.niconicomics.core.dao;

import java.util.ArrayList;

import com.niconicomics.core.vo.Episode;

public interface EpisodeMapper {

	public int episodeInsert(Episode episode);
	public ArrayList<Episode> episodeList();
}
