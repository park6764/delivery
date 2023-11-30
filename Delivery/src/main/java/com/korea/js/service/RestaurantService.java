package com.korea.js.service;

import java.util.List;

import com.korea.js.vo.Restaurant;

import jakarta.servlet.http.HttpServletRequest;

public interface RestaurantService {
	/**
	 * 레스토랑 추가
	 * @param map 레스토랑 정보 객체
	 * @return 레스토랑 추가 성공 시 1, 실패 시 0;
	 */
	public int addRes(Restaurant res, HttpServletRequest request);
	/**
	 * 레스토랑 리스트
	 * @return	오너 리스트
	 */
	public List<Restaurant> restaurants();
}
