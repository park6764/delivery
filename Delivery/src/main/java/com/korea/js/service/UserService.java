package com.korea.js.service;

import java.util.List;
import java.util.Map;

import com.korea.js.vo.User;


public interface UserService {
	public int signup(Map<String, String> map);
	public String idCk(String userId);
	public User login(Map<String, String> map);
	public List<User> users(); 
	public int changeGroup(List<Map<String, String>> map);
}
