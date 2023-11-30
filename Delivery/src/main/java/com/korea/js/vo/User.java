package com.korea.js.vo;

import lombok.Data;

@Data
public class User {
	private String userId;
	private String pw;
	private String userName;
	private String nick;
	private String tel;
	private String addr;
	private String group;
	private Long acornCoin;
	private String acornPw;
	private String profileImgName;
	private String profileImg;
	private String accessDt;
	private boolean dormantAccount;

	public boolean getDormantAccount() {
		return dormantAccount;
	}
	
	public void setDormantAccount(boolean dormantAccount) {
		this.dormantAccount = dormantAccount;
	}
}