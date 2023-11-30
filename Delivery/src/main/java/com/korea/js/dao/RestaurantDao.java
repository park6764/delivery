package com.korea.js.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RestaurantDao {
	public int addRes(String ownerId, String restaurantName, String restaurantImg);
}
