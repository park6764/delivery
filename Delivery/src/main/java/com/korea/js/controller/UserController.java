package com.korea.js.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.korea.js.service.UserService;
import com.korea.js.vo.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
@Controller
public class UserController {
	@Autowired
	private UserService userService;

	
	// 회원가입
	@PostMapping("/signup.do")
	public String signup(@ModelAttribute User user, HttpServletRequest request) {
		int result = userService.signup(user, request);
		
		if(0 < result) {
			return "redirect:/delivery.do";
		}
		
		return "redirect:/delivery.do";
	}
	
	// 아이디 중복 체크
	@PostMapping("/idCk.do")
	@ResponseBody
	public String idCk(String userId) {
		String result = userService.idCk(userId);
		
		if(result == null) {
			return "T";
		} 
		
		return "F";
	}
	
	// 로그인
	@PostMapping("/login.do")
	@ResponseBody
	public String login(@RequestBody Map<String, String> map, HttpSession session) {
		User result = userService.login(map);
		
		if(result != null) {
			session.setAttribute("userInfo", result);
			session.setAttribute("acorn", result.getAcornCoin());
			return "T";
		}
		
		return "F";
	}
	
	// 세션 업데이트
	@PostMapping("/updateAcorn.do")
	@ResponseBody
	public String updateAcorn(@RequestBody Map<String, String> map, HttpSession session) {
	    var coin = userService.getAcorn(map.get("userId"));
	    session.setAttribute("acorn", coin);
	    return "T";
	}
	
	// 로그아웃 :: 세션 종료 후 메인 페이지로 이동
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/delivery.do";
	}
	
	// 관리자 그룹변경 페이지로 이동
	@GetMapping("/admin_group.do")
	public String owner_group(Model model) {
		// 유저 리스트
		List<User> result = userService.users();
		model.addAttribute("users", result);
		
		// 그룹 정보
		String[] groups = {"회원", "오너", "관리자"};
		model.addAttribute("groups", groups);
		
		return "/admin_group";
	}
	
	// 유저 그룹 변경
	@PostMapping("/changeGroup.do")
	@ResponseBody
	public String changeGroup(@RequestBody List<Map<String, String>> map) {
		int result = userService.changeGroup(map);
		
		if(0 < result) {
			return "T";
		}
		
		return "F";
	}
	
	// 2차 비밀번호 확인
	@PostMapping("/acornPwCk.do")
	@ResponseBody
	public String acornPwCk(@RequestBody Map<String, String> map) {
		String result = userService.getAcornPw(map);
		
		if(result.equals("T")) {
			return "T";
		}
		
		return "F";
	}
}





