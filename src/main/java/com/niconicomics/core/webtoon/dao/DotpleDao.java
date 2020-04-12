package com.niconicomics.core.webtoon.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.niconicomics.core.webtoon.vo.Dotple;

@Repository
public class DotpleDao {

	@Autowired
	private SqlSession session;
	
	public boolean insertDotple(Dotple dotple) {
		DotpleMapper mapper = session.getMapper(DotpleMapper.class);
		if(mapper.insertDotple(dotple) == 1) {
			return true;
		}else {
			return false;
		}
	}

	public ArrayList<Dotple> selectDotpleListByContentsId(int contentsId) {
		DotpleMapper mapper = session.getMapper(DotpleMapper.class);
		return mapper.selectDotpleListByContentsId(contentsId);
		
	}

}
