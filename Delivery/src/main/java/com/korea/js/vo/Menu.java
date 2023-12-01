package com.korea.js.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Menu {
	private Long meunId;                    // 메뉴 아이디
	private Long restaurantId;              // 레스토랑 아이디
	private String menuName;                // 메뉴 이름
	private String menuPrice;               // 메뉴 가격
	private String menuImgName;      		// 메뉴 이미지 이름
	private MultipartFile menuImg;          // 메뉴 이미지
	private String menuExplanation;         // 메뉴 설명
	private String role;         			// 권한
}
