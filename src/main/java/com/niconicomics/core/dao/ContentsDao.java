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
	
	public int insertContents(Contents contents) {
		ContentsMapper mapper = session.getMapper(ContentsMapper.class);
		int result = mapper.insertContents(contents);
		return result;
	}
	public ArrayList<Contents> getContents(int episodeId){
		ContentsMapper mapper = session.getMapper(ContentsMapper.class);
		ArrayList<Contents> contentsList = mapper.getContents(episodeId);
		return contentsList;
	}
	public int updateContents(Contents contents) {
		ContentsMapper mapper = session.getMapper(ContentsMapper.class);
		int result = mapper.updateContents(contents);
		return result;
	}
	
}
