package com.korea.js.serviceImpl;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.js.dao.AcornDao;
import com.korea.js.dao.UserDao;
import com.korea.js.service.AcornService;
import com.korea.js.vo.Acorn;

@Service
public class AcornServiceImpl implements AcornService {
	@Autowired
	private AcornDao acornDao;
	
	@Autowired
	private UserDao userDao;
	
	@Override
	public int acornCharging(Acorn acorn) {
		// 현재 시간 가져오기
        LocalDateTime today = LocalDateTime.now();

        // LocalDateTime을 String으로 변환
        String dt = today.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        
        // 오늘날짜 설정
        acorn.setInputDt(dt);
        
		int result = acornDao.acornCharging(acorn);
		
		// 충전한 유저 아이디
		String fromUserId = acorn.getFromUserId();
		// 충전 도토리
		Long inputAcorn = acorn.getInputAcorn();
		// 유저 보유 도토리
		Long userAcorn = userDao.getAcorn(fromUserId);
		
		inputAcorn += userAcorn;
		
		// 업데이트
		int result2 = userDao.acornCharging(fromUserId, inputAcorn);
		
		return result * result2;
	}
}
