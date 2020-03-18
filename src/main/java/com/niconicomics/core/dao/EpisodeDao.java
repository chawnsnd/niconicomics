package com.niconicomics.core.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.niconicomics.core.vo.Episode;
import com.niconicomics.core.vo.Webtoon;

@Repository
public class EpisodeDao {
	@Autowired
	private SqlSession session;
	
	public int episodeInsert(Episode episode) {
		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
		int result = mapper.episodeInsert(episode);
		return result;
	}
	public ArrayList<Episode> episodeList(){
		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
		ArrayList<Episode> list = mapper.episodeList();
		return list;
	}
}
