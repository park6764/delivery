package com.korea.js.serviceImpl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.js.dao.RestaurantDao;
import com.korea.js.service.RestaurantService;

@Service
public class RestaurantServiceImpl implements RestaurantService {
	@Autowired
	private RestaurantDao restaurantDao;
	@Override
	public int addRes(Map<String, String> map) {
		String ownerId = map.get("ownerId");
		String restaurantName = map.get("restaurantName");
		String restaurantImg = map.get("restaurantImg");
		int result = restaurantDao.addRes(ownerId, restaurantName, restaurantImg);
		return result;
	}

}
