package com.korea.js.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class User {                         
	private String userId;                  // 유저 아이디  
	private String pw;                      // 비밀번호    
	private String userName;                // 이름      
	private String nick;                    // 별병      
	private String tel;                     // 전화번호
	private String addr;                    // 주소
	private String group;                   // 그룹
	private Long acornCoin;                 // 도토리(화폐)
	
	private String acornPw;                 // 2차 비밀번호
	private String profileImgName;          // 사진 이름
	
	private MultipartFile profileImg;       // 사진
	private String accessDt;                // 접속일
	private boolean dormantAccount;         // 휴면 계정 여부

	private String restaurantId;            // 레스토랑 아이디

	// 휴면 계정 여부 get
	public boolean getDormantAccount() {
		return dormantAccount;
	}
	
	//휴면 계정 여부 set
	public void setDormantAccount(boolean dormantAccount) {
		this.dormantAccount = dormantAccount;
	}
}