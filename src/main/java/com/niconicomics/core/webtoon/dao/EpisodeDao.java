package com.niconicomics.core.webtoon.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.niconicomics.core.webtoon.vo.Episode;
import com.niconicomics.core.webtoon.vo.Webtoon;

@Repository
public class EpisodeDao {
	@Autowired
	private SqlSession session;
	
	public int insertEpisode(Episode episode) {
		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
		int result = mapper.insertEpisode(episode);
		return result;
	}
	public ArrayList<Episode> episodeSelectList(int webtoonId){
		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
		ArrayList<Episode> list = mapper.episodeSelectList(webtoonId);
		return list;
	}
	public ArrayList<Episode> episodeAllList(){
		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
		ArrayList<Episode> list = mapper.episodeAllList();
		return list;
	}
	public int updateEpisode(Episode episode) {
		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
		int result = mapper.updateEpisode(episode);
		return result;
	}
	public int deleteEpisode(Episode episode) {
		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
		int result = mapper.deleteEpisode(episode);
		return result;
	}
	public Episode selectEpisodeByEpisodeId(int episodeId) {
		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
		Episode episode = mapper.selectEpisodeByEpisodeId(episodeId);
		return episode;
	}
	public Episode selectEpisodeByEpisodeNo(int episodeNo) {
		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
		Episode episode = mapper.selectEpisodeByEpisodeNo(episodeNo);
		return episode;
	}
	public Episode selectEpisodeByWebtoonId(int WebtoonId) {
		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
		Episode episode = mapper.selectEpisodeByWebtoonId(WebtoonId);
		return episode;
	}
}
