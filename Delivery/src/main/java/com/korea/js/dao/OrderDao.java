package com.korea.js.dao;

import org.apache.ibatis.annotations.Mapper;

import com.korea.js.vo.Order;

@Mapper
public interface OrderDao {
	/**
	 * 메뉴 주문
	 * @param order 주문정보
	 * @return 주문 성공 시 1, 실패 시 0;
	 */
	public int inserOrder(Order order);
}
