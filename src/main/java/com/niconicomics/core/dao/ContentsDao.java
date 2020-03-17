package com.niconicomics.core.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.niconicomics.core.vo.Contents;
import com.niconicomics.core.vo.Episode;
import com.niconicomics.core.vo.Webtoon;

@Repository
public class ContentsDao {
	@Autowired
	private SqlSession session;
	
//	public int contentsInsert(Contents contents) {
//		EpisodeMapper mapper = session.getMapper(EpisodeMapper.class);
//		int result = mapper.episodeInsert(episode);
//		return result;
//	}
	
}
