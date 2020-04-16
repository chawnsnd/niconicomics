package com.niconicomics.core.user.dao;

import com.niconicomics.core.user.vo.User;

public interface UserMapper {

	public int insertUser(User user);

	public int selectCountByEmail(String email);

	public User selectUserByUserId(int userId);

	public User selectUserByEmail(String email);

	public boolean updateUser(User user);

}
