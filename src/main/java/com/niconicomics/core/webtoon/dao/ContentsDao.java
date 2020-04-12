package com.niconicomics.core.webtoon.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.niconicomics.core.webtoon.vo.Contents;
import com.niconicomics.core.webtoon.vo.Episode;
import com.niconicomics.core.webtoon.vo.Webtoon;

@Repository
public class ContentsDao {
	
	@Autowired
	private SqlSession session;
	
	public boolean insertContents(Contents contents) {
		ContentsMapper mapper = session.getMapper(ContentsMapper.class);
		if(mapper.insertContents(contents)==1) {
			return true;
		}else {
			return false;
		}
	}
	
	public ArrayList<Contents> selectContentsListByEpisodeId(int episodeId){
		ContentsMapper mapper = session.getMapper(ContentsMapper.class);
		ArrayList<Contents> contentsList = mapper.selectContentsListByEpisodeId(episodeId);
		return contentsList;
	}
	
	public Contents selectContentsByEpsodeIdAndIdx(int episodeId, int idx) {
		ContentsMapper mapper = session.getMapper(ContentsMapper.class);
		return mapper.selectContentsByEpsodeIdAndIdx(episodeId, idx);
	}
	
	public boolean updateContents(Contents contents) {
		ContentsMapper mapper = session.getMapper(ContentsMapper.class);
		if(mapper.updateContents(contents)==1) {
			return true;
		}else {			
			return false;
		}
	}

	public boolean deleteContentsByContentsId(int contentsId) {
		ContentsMapper mapper = session.getMapper(ContentsMapper.class);
		if(mapper.deleteContentsByContentsId(contentsId)==1) {
			return true;
		}else {			
			return false;
		}
	}
	
}
