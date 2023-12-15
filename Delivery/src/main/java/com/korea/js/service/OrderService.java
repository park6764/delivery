package com.korea.js.service;

import com.korea.js.vo.Order;

public interface OrderService {
	/**
	 * 메뉴 주문
	 * @param order 주문정보
	 * @return 주문 성공 시 1, 실패 시 0;
	 */
	public int inserOrder(Order order);
}
