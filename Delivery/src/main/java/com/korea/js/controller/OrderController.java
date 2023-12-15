package com.korea.js.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.korea.js.service.OrderService;
import com.korea.js.vo.Order;

@Controller
public class OrderController {
	@Autowired
	private OrderService orderService;
	
	@PostMapping("/insertOrder.do")
	@ResponseBody
	public String insertOrder(@RequestBody Order order) {
		int result = orderService.inserOrder(order);
		 
		if(0 < result) {
			return "T";
		}
		
		return "F";
	}
}
