package com.korea.js.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.korea.js.vo.Restaurant;

@Mapper
public interface RestaurantDao {
	/**
	 * 레스토랑 추가	
	 * @param ownerId			오너 아이디
	 * @param restaurantName	레스토랑 이름
	 * @param restaurantImg		레스토랑 이미지
	 * @return 레스토랑 추가 성공 시 1, 실패 시 0;
	 */
	public int addRes(String ownerId, String restaurantName, String restaurantImg);
	/**
	 * 레스토랑 리스트
	 * @return	오너 리스트
	 */
	public List<Restaurant> restaurants();
	/**
	 * 레스토랑 메뉴
	 * @param restaurantId
	 * @return 레스토랑 메뉴
	 */
	public List<Restaurant> restaurant(Long restaurantId);
	/**
	 * 주문을 위한 레스토랑 정보
	 * @param restaurantId 레스토랑 아이디
	 * @return 레스토랑 정보
	 */
	public Restaurant restaurantSalesAcorn(Long restaurantId);
	/**
	 * 레스토랑 매출 업데이트
	 * @param restaurantId 레스토랑 아이디
	 * @return 업데이트 성공 시 1, 실패 시 0;
	 */
	public int restaurantSalesUpdate(Restaurant restaurant);
}
