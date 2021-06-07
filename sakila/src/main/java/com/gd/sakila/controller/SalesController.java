package com.gd.sakila.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/admin")
@Controller
@Slf4j
public class SalesController {

	@GetMapping("/getSalesListByCategory")
	public String getSalesListByCategory() {
		return "getSalesListByCategory";
	}
	
	@GetMapping("/getBestSellerList")
	public String getBestSellerList() {
		return "getBestSellerList";
	}
	
	@GetMapping("/getSalesListByStore")
	public String getSalesListByStore() {
		return "getSalesListByStore";
	}
}
