package com.korea.js.serviceImpl;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.korea.js.dao.UserDao;
import com.korea.js.service.UserService;
import com.korea.js.utils.BCrypt;
import com.korea.js.vo.User;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao userDao;
	
	// 회원가입
	@Override
	public int signup(User user, HttpServletRequest request) {
		
		// 세션의 서블릿 컨텍스트를 기반으로 "/img/" 디렉토리의 실제 경로를 가져옴
		String path = request.getSession().getServletContext().getRealPath("/img/");
		System.out.println("path: " + path);
		
		//HttpServletRequest를 통해 파일을 가져온다
		MultipartFile fileUpload = user.getProfileImg();

		// 파일이 null이거나 비어있으면 추가 실패
//		if (fileUpload == null || fileUpload.isEmpty()) {
//			return 0;
//		}
		
		String originalFilename = fileUpload.getOriginalFilename();
		
		// 중복 파일명 처리
		File f = new File(path + originalFilename);
//		if(f.exists()) {
//			return 0;
//		}
		
		try {
			// 파일 저장
			fileUpload.transferTo(f);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 비밀번호
		String pw = user.getPw();                                                      
		// 2차 비밀번호
		String acornPw = user.getAcornPw();
		// 비밀번호 암호화
		String password = BCrypt.hashpw(pw, BCrypt.gensalt());		
		// 2차 비밀번호 암호화
		String password2 = BCrypt.hashpw(acornPw, BCrypt.gensalt());	
		
		// 값 세팅
		user.setGroup("회원");
		user.setAcornCoin(Long.valueOf(0));
		user.setDormantAccount(false);
		user.setProfileImgName(originalFilename);
		user.setPw(password);
		user.setAcornPw(password2);
		
		int result = userDao.signup(user);

		return result;
	}
	
	// 중복 아이디 체크
	@Override
	public String idCk(String userId) {
		// 중복 아이디가 없으면 null;
		String result = userDao.idCk(userId);
		return result;
	}

	// 로그인
	@Override
	public User login(Map<String, String> map) {
		String userId = map.get("userId");
		String pw = map.get("pw");
		User result = userDao.login(userId); // userId로 해당 레크드를 가져옴. userId : pk
		
		if(result == null) {
			// 일치하는 정보 없음
			return null;
		}
		
		// 비밀번호 비교
		boolean checkpw = BCrypt.checkpw(pw, result.getPw());
		
		// 비밀번호 일치
		if(checkpw) {
			LocalDateTime currentTime = LocalDateTime.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        String accessDt = currentTime.format(formatter);
			
	        // 현재시간을 접속일로 업데이트
			userDao.accessDt(result.getUserId(), accessDt);
			
			// 유저 정보 반환
			return result;
		}
		
		return null;
	}

	// 유저 리스트(그룹변경을 위한)
	@Override
	public List<User> users() {
		List<User> result = userDao.users();
		return result;
	}

	// 그룹 변경
	@Override
	public int changeGroup(List<Map<String, String>> map) {
		String userId = "";
		String group = "";
		String role = "";
		int result = 1;
		
		// 루프 돌면서 객체 꺼내기
		for(Map<String, String> m : map) {
			userId = m.get("userId");
			group = m.get("group");
			role = m.get("role");
			
			if(!role.equals("관리자")) { return 0; } // 관리자가 아니면 그룹 변경 불가
			
			// 업데이트 성공시 반환 1, 실패하면 0;
			result *= userDao.changeGroup(userId, group);
		}
		
		return result;
	}

	// 유저 도토리 가져오기
	@Override
	public Long getAcorn(String userId) {
		Long result = userDao.getAcorn(userId);
		return result;
	}

	@Override
	public String getAcornPw(Map<String, String> map) {
		String userId = map.get("userId");
		String acornPw = map.get("acornPw");
		
		String result = userDao.getAcornPw(userId);
		
		boolean checkpw = BCrypt.checkpw(acornPw, result);
		
		if(checkpw) {
			return "T";
		}
		
		return "F";
	}
}
