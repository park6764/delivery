package com.korea.js.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.korea.js.service.UserService;
import com.korea.js.vo.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	
	@PostMapping("/signup.do")
	@ResponseBody
	public String signup(Model model, @RequestBody Map<String, String> map) {
		int result = userService.signup(map);
		if(0 < result) {
			return "T";
		}
		
		return "F";
	}
	
	@PostMapping("/idCk.do")
	@ResponseBody
	public String idCk(String userId) {
		String result = userService.idCk(userId);
		
		if(result == null) {
			return "T";
		} 
		
		return "F";
	}
	
	@PostMapping("/login.do")
	@ResponseBody
	public String login(@RequestBody Map<String, String> map, HttpSession session) {
		User result = userService.login(map);
		
		if(result != null) {
			session.setAttribute("userInfo", result);
			return "T";
		}
		
		return "F";
	}
	
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/delivery.do";
	}
	
	@GetMapping("/admin_group.do")
	public String owner_group(Model model) {
		List<User> result = userService.users();
		model.addAttribute("users", result);
		String[] groups = {"회원", "오너", "관리자"};
		model.addAttribute("groups", groups);
		
		return "/admin_group";
	}
	
	@PostMapping("/changeGroup.do")
	@ResponseBody
	public String changeGroup(@RequestBody List<Map<String, String>> map) {
		int result = userService.changeGroup(map);
		
		if(0 < result) {
			return "T";
		}
		
		return "F";
	}
	
	@GetMapping("/admin_restaurant.do")
	public String admin_restaurant(Model model) {
		
		
		return "/admin_restaurant";
	}
}
