package com.niconicomics.core.user.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.niconicomics.core.user.vo.User;

@Repository
public class UserDao {
	
	@Autowired
	private SqlSession session;
	
	public User selectUserByUserId(int userId) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		User result = mapper.selectUserByUserId(userId);
		return result;
	}
	
	public User selectUserByEmail(String email) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		User result = mapper.selectUserByEmail(email);
		return result;
	}
	
	/*
	TODO 회원가입
	@param email, password, nickname, (birthdate), (gender), type
	 */
	public int insertUser(User user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		int result = mapper.insertUser(user);
		return result;
	}
	
	/*
	TODO 1명의 회원정보 수정
	@param email, password, nickname, (birthdate), (gender)
	 */
	public boolean updateUser(User user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		boolean result = mapper.updateUser(user);
		return result;
	}
	
	/*
	TODO 1명의 회원정보 검색
	@param email 검색할 email
	@return user 객체값
	 */
	public int selectCountByEmail(String email) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		int result = mapper.selectCountByEmail(email);
		return result;
	}
}
