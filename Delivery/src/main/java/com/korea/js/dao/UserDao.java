package com.korea.js.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.korea.js.vo.User;

@Mapper
public interface UserDao {
	/**
	 * 회원가입
	 * @param user 회원정보
	 * @return 회원 추가 성공 시 1, 실패 시 0;
	 */
	public int signup(User user);	
	/**
	 * 아이디 중복 체크
	 * @param userId 유저 아이디
	 * @return 중복 값이 있으면 해당 아이디 반환, 없으면 null;             
	 */
	public String idCk(String userId);
	/**
	 * 로그인
	 * @param userId 유저 아이디
	 * @return 아이디와 일치하는 정보가 있으면 해당 레코드 반환, 없으면, null;
	 */
	public User login(String userId);
	/**
	 * 접속날짜 업데이트
	 * @param userId   유저 아이디
 	 * @param accessDt 접속일
	 * @return 업데이트에 성공하면 1, 실패하면 0;
	 */
	public int accessDt(String userId, String accessDt);
	/**
	 * 유저 리스트
	 * @return 유저 리스트
	 */
	public List<User> users(); 
	/**
	 * 유저 그룹 변경
	 * @param userId 유저 아이디
	 * @param group  변경할 그룹
	 * @return 변경을 성공하면 1, 실패하면 0;
	 */
	public int changeGroup(String userId, String group);
	/**
	 * 도토리 충전
	 * @param inputAcorn 충전 도토리
	 * @param fromUserId 충전할 아이디
	 * @return 업데이트 성공 시 1, 실패 시 0;
	 */
	public int acornCharging(String fromUserId, Long inputAcorn);
	/**
	 * 보유 도토리 가져오기
	 * @param userId 유저 아이디
	 * @return 도토리
	 */
	public Long getAcorn(String userId);
	/**
	 * 2차 비밀번호 가져오기
	 * @param userId 유저 아이디
	 * @return 2차 비밀번호
	 */
	public String getAcornPw(String userId);
}
