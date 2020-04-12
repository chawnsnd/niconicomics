package com.niconicomics.core.webtoon.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.niconicomics.core.webtoon.vo.Episode;

@Repository
public class EpisodeDao {
	
	@Autowired
	private SqlSession session;
	
	public int insertEpisode(Episode episode) {
		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
		mapper.insertEpisode(episode);
		return episode.getEpisodeId();
	}
	
	public ArrayList<Episode> selectEpisodeListByWebtoonId(int webtoonId){
		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
		ArrayList<Episode> list = mapper.selectEpisodeListByWebtoonId(webtoonId);
		return list;
	}

	public int updateEpisode(Episode episode) {
		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
		int result = mapper.updateEpisode(episode);
		return result;
	}
	public int deleteEpisodeByEpisodeId(int episodeId) {
		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
		int result = mapper.deleteEpisodeByEpisodeId(episodeId);
		return result;
	}
	public Episode selectEpisodeByEpisodeId(int episodeId) {
		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
		Episode episode = mapper.selectEpisodeByEpisodeId(episodeId);
		return episode;
	}
	public Episode selectEpisodeByWebtoonIdAndEpisodeNo(int webtoonId, int episodeNo) {
		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
		Episode episode = mapper.selectEpisodeByWebtoonIdAndEpisodeNo(webtoonId, episodeNo);
		return episode;
	}

}
