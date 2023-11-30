package com.korea.js.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.korea.js.service.RestaurantService;

@Controller
public class RestaurantController {
	@Autowired
	private RestaurantService restaurantService;
	
	@PostMapping("/addRes.do")
	@ResponseBody
	public String addRes(@RequestBody Map<String, String> map) {
		int result = restaurantService.addRes(map);
		
		if(0 < result) {
			return "T";
		}
		
		return "F";
	}
}
