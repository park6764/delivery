package com.korea.js.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.korea.js.service.RestaurantService;
import com.korea.js.vo.Restaurant;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class RestaurantController {
	@Autowired
	private RestaurantService restaurantService;
	
	// 레스토랑 추가
	@PostMapping("/addRes.do")
	public String addRes(@ModelAttribute Restaurant res, HttpServletRequest request) {
		int result = restaurantService.addRes(res, request);
		
		if(0 < result) {
			return "redirect:/admin_restaurant.do";
		}
		
		return "redirect:/admin_restaurant.do";
	}
	
	// 관리자 레스토랑 추가/수정/삭제 페이지로 이동
	@GetMapping("/admin_restaurant.do")
	public String admin_restaurant(Model model) {
		List<Restaurant> result = restaurantService.restaurants();
		model.addAttribute("restaurants", result);
		return "/admin_restaurant";
	}
}
