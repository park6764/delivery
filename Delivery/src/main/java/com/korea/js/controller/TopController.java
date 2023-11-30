package com.korea.js.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TopController {
	@GetMapping("/delivery.do")
	public String delivery() { return "/delivery"; }
	
	@GetMapping("signup.do")
	public String signup(Model model){
		model.addAttribute("signup", "signup");
		return "/signup";
	}
	
	@GetMapping("/login.do")
	public String login() { return "/login"; }
	
	@GetMapping("/myPage.do")
	public String myPage() { return "/myPage"; }
}
