package com.korea.js.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.korea.js.vo.User;

@Mapper
public interface UserDao {
	/**
	 * 회원가입
	 * @param userId              유저 아이디
	 * @param pw                  비밀번호
	 * @param userName            이름
	 * @param nick                별명
	 * @param tel                 전화번호
	 * @param addr                주소
	 * @param group               그룹
	 * @param acornCoin           도토리(화폐)
	 * @param acornPw             2차 비밀번호
	 * @param profileImgName      파일이름
	 * @param profileImg          파일
	 * @param dormantAccount      접속일
	 * @return 회원가입에 성공하면 1, 실패하면 0;
	 */
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
		, String profileImg
		, boolean dormantAccount
	);	
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
}
