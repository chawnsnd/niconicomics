package com.niconicomics.core.webtoon.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import com.niconicomics.core.webtoon.vo.Episode;

public interface EpisodeMapper {

	public int insertEpisode(Episode episode);
	public ArrayList<Episode> selectEpisodeListByWebtoonId(int webtoonId, RowBounds rb);
	public int updateEpisode(Episode episode);
	public int deleteEpisodeByEpisodeId(int episodeId);
	public Episode selectEpisodeByEpisodeId(int episodeId);
	public Episode selectEpisodeByWebtoonIdAndEpisodeNo(
			@Param("webtoonId") int webtoonId, 
			@Param("episodeNo") int episodeNo);
	public int selectCountEpisodeListByWebtoonId(int webtoonId);
	
}
