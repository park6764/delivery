package com.korea.js.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.korea.js.service.AcornService;
import com.korea.js.vo.Acorn;

@Controller
public class AcornController {
	@Autowired
	private AcornService acornService;
	
	@PostMapping("/acornCharging.do")
	@ResponseBody
	public String acornCharging(@RequestBody Acorn acorn) {
		int result = acornService.acornCharging(acorn);
		
		if(0 < result) {
			return "T";
		}
		
		return "F";
	}
}
