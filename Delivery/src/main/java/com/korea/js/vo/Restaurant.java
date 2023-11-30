package com.korea.js.vo;

import lombok.Data;

@Data
public class Restaurant {
	private Long restaurantId;
	private String ownerId;
	private String restaurantName;
	private String restaurantImg;
	private Long dailySales;
	private String dailySalesDt;
	private Long totalSales;
	private String launchDt;
}
