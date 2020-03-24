package com.niconicomics.core.user.dao;

import com.niconicomics.core.user.vo.User;

public interface UserMapper {

	public int insertUser(User user);

	public int selectCountByEmail(String email);
	
}
