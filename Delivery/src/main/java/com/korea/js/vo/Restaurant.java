package com.korea.js.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Restaurant {
	private Long restaurantId;                // 레스토랑 아이디
	private String ownerId;                   // 오너 아이디
	private String ownerName;                 // 오너 이름
	private String restaurantName;            // 레스토랑 이름
	private MultipartFile restaurantImg;      // 레스토랑 이미지
	private String restaurantImgName;      	  // 레스토랑 이미지 이름
	private Long dailySales;                  // 일일 매출
	private String dailySalesDt;              // 일일 매출일
	private Long totalSales;                  // 총 매출
	private String launchDt;                  // 개점일
	private String role;                  	  // 권한
	
	private String menuName;                  // 메뉴 이름
	private String menuPrice;                 // 메뉴 가격
	private String menuImgName;      		  // 메뉴 이미지 이름
	private String menuExplanation;           // 메뉴 설명
}
