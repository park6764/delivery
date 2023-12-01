package com.korea.js.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.korea.js.service.MenuService;
import com.korea.js.vo.Menu;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class MenuController {
	@Autowired
	private MenuService menuService;
	
	@PostMapping("/addMenu.do")
	public String addMenu(@ModelAttribute Menu menu, HttpServletRequest request) {
		menuService.addMenu(menu, request);
		return "redirect:/owner_menu.do";
	}
}
