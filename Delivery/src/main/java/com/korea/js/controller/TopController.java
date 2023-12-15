package com.korea.js.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.korea.js.service.MenuService;
import com.korea.js.service.RestaurantService;
import com.korea.js.service.UserService;
import com.korea.js.vo.Menu;
import com.korea.js.vo.Restaurant;

@Controller
public class TopController {
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private RestaurantService restaurantService;
	
	@Autowired
	private UserService userService;
	
	// 메인 페이지로 이동
	@GetMapping("/delivery.do")
	public String delivery(Model model) { 
	    List<Restaurant> result = restaurantService.restaurants();
	    model.addAttribute("restaurants", result);
	    return "/delivery";
	}

	// 메인 페이지로 이동
	@GetMapping("/delivery_.do")
	public String delivery(Model model, Optional<String> userId) { 
		List<Restaurant> result = restaurantService.restaurants();
		model.addAttribute("restaurants", result);
		if(userId.isPresent())	{
			String userId_ = userId.get();
			var coin = userService.getAcorn(userId_);
			model.addAttribute("acorn", coin);
		}
		return "/delivery";
	}
	
	// 회원가입 페이지로 이동
	@GetMapping("signup.do")
	public String signup(Model model){
		// top에서 회원가입 URL을 띄우기 위한 값
		model.addAttribute("signup", "signup");
		return "/signup";
	}
	
	// 로그인 페이지로 이동
	@GetMapping("/login.do")
	public String login() { return "/login"; }
	
	// 마이페이지로 이동
	@GetMapping("/myPage.do")
	public String myPage() { return "/myPage"; }

	// 마이페이지로 이동
	@GetMapping("/owner_menu.do")
	public String owner_menu(Model model, Long restaurantId) { 
		List<Menu> result = menuService.menus(restaurantId);
		model.addAttribute("menus", result);
		return "/owner_menu";
	}
	
	// 레스토랑 페이지로 이동
	@GetMapping("/restaurant.do")
	public String restaurant(Model model, Long restaurantId) { 
		List<Restaurant> result = restaurantService.restaurant(restaurantId);
		model.addAttribute("restaurant", result);
		
		if(!result.isEmpty()) {
			model.addAttribute("restaurantName", result.get(0).getRestaurantName());
			model.addAttribute("restaurantImgName", result.get(0).getRestaurantImgName());
		}
		return "/restaurant";
	}
	
	// 도토리 충전 페이지로 이동
	@GetMapping("/acornCharging.do")
	public String acornCharging() {
		return "acorn_charging";
	}

	// 주문내역 페이지로 이동
	@GetMapping("/myPage/orderHistory.do")
	public String orderHistory() {
		return "orderHistory";
	}
}












