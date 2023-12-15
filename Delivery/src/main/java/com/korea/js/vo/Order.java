package com.korea.js.vo;

import lombok.Data;

@Data
public class Order {
	// 주문 아이디
    private Long orderId;
    // 음식점 아이디
    private Long restaurantId;
    // 유저 아이디
    private String userId;
    // 주문한 메뉴들
    private String menus;
    // 메뉴 별 주문 수
    private String menuCount;
    // 메뉴 별 가격
    private String menuPrice;
    // 주문 날짜
    private String orderDt;
    // 총 금액
    private Long totalAcorn;
    // 주문 수락 여부
    private boolean accepted;
}
