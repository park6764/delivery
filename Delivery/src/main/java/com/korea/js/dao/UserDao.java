package com.korea.js.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.korea.js.vo.User;

@Mapper
public interface UserDao {
	public int signup(
		String userId
		, String pw
		, String userName
		, String nick
		, String tel
		, String addr
		, String group
		, Long acornCoin
		, String acornPw
		, String profileImgName
		, String profileImg
		, boolean dormantAccount
	);	
	public String idCk(String userId);
	public User login(String userId, String pw);
	public int accessDt(String userId, String accessDt);
	public List<User> users(); 
	public int changeGroup(String userId, String group);
}
