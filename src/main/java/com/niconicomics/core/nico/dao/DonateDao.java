package com.niconicomics.core.nico.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.niconicomics.core.nico.vo.Donate;

@Repository
public class DonateDao {

	@Autowired
	private SqlSession session;
	
	public boolean insertDonate(Donate donate) {
		DonateMapper mapper = session.getMapper(DonateMapper.class);
		if(mapper.insertDonate(donate) == 1) {
			return true;
		}else {
			return false;
		}
	}
	
}
