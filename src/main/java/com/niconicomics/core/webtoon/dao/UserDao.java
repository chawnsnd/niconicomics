package com.niconicomics.core.webtoon.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.niconicomics.core.webtoon.vo.User;

@Repository
public class UserDao {
	@Autowired
	private SqlSession session;
	UserMapper mapper;
	
	public int insertUser(User user) {
		/*
		TODO 회원가입
		@param email, password, nickname, (birthdate), (gender), type
		 */
		int result = mapper.insertUser(user);
		return 0;
	}
	
}
