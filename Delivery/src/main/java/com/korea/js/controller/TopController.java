package com.korea.js.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TopController {
	
	// 메인 페이지로 이동
	@GetMapping("/delivery.do")
	public String delivery() { return "/delivery"; }
	
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
	public String owner_menu() { return "/owner_menu"; }
}
