package com.korea.js.serviceImpl;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.js.dao.UserDao;
import com.korea.js.service.UserService;
import com.korea.js.utils.BCrypt;
import com.korea.js.vo.User;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao userDao;

	@Override
	public int signup(Map<String, String> map) {
		String userId = map.get("userId");
		String pw = map.get("pw");
		String userName = map.get("userName");
		String nick = map.get("nick");
		String tel = map.get("tel");
		String addr = map.get("addr");
		String group = "회원";
		Long acornCoin = Long.valueOf(0);
		String acornPw = map.get("acornPw");
		String profileImgName = map.get("profileImgName");
		String profileImg = map.get("profileImg");
		boolean dormantAccount = false;

		if("".equals(profileImgName)) {
			profileImgName = "기본프로필";
		}

		if("".equals(profileImg)) {
			profileImg = "기본프로필.png";
		}
		
		String password = BCrypt.hashpw(pw, BCrypt.gensalt());
		String password2 = BCrypt.hashpw(acornPw, BCrypt.gensalt());
		
		int result = userDao.signup(
								userId
								, password
								, userName
								, nick
								, tel
								, addr
								, group
								, acornCoin
								, password2
								, profileImgName
								, profileImg
								, dormantAccount
							);

		return result;
	}

	@Override
	public String idCk(String userId) {
		String result = userDao.idCk(userId);
		return result;
	}

	@Override
	public User login(Map<String, String> map) {
		String userId = map.get("userId");
		String pw = map.get("pw");
		User result = userDao.login(userId, pw);
		
		if(result == null) {
			return null;
		}
		
		boolean checkpw = BCrypt.checkpw(pw, result.getPw());
		
		if(checkpw) {
			LocalDateTime currentTime = LocalDateTime.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        String accessDt = currentTime.format(formatter);
			
			userDao.accessDt(result.getUserId(), accessDt);
			
			return result;
		}
		
		return null;
	}

	@Override
	public List<User> users() {
		List<User> result = userDao.users();
		return result;
	}

	@Override
	public int changeGroup(List<Map<String, String>> map) {
		String userId = "";
		String group = "";
		String role = "";
		int result = 1;
		
		for(Map<String, String> m : map) {
			userId = m.get("userId");
			group = m.get("group");
			role = m.get("role");
			
			if(!role.equals("관리자")) { return 0; }
			
			result *= userDao.changeGroup(userId, group);
		}
		
		return result;
	}
}
