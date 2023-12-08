package com.korea.js.service;

import java.util.List;
import java.util.Map;

import com.korea.js.vo.User;

import jakarta.servlet.http.HttpServletRequest;


public interface UserService {
	/**
	 * 회원가입
	 * @param map 유저 정보 객체
	 * @return 회원가입을 성공하면 1, 싪패하면 0;
	 */
	public int signup(User user, HttpServletRequest request);
	/**
	 * 아이디 중복 체크
	 * @param userId 유저 아이디
	 * @return 중복 값이 있으면 해당 아이디 반환, 없으면 null;             
	 */
	public String idCk(String userId);
	/**
	 * 로그인
	 * @param map 유저 정보 객체
	 * @return 일치하는 정보가 있으면 해당 레코드 반환, 없으면, null;
	 */
	public User login(Map<String, String> map);
	/**
	 * 유저 리스트
	 * @return 유저 리스트
	 */
	public List<User> users();
	/**
	 * 유저 그룹 변경
	 * @param map 그룹을 변경할 정보 객체의 리스트
	 * @return 변경을 성공하면 1, 실패하면 0;
	 */
	public int changeGroup(List<Map<String, String>> map);
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
	public String getAcornPw(Map<String, String> map);
}
