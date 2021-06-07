package com.gd.sakila.restapi;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gd.sakila.service.PaymentService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class SalesRestAPI {
	@Autowired PaymentService paymentService;
	
	@GetMapping("/getSalesListByCategory")
	public List<Map<String, Object>> getSalesListByCategory(){
		return paymentService.getSalesListByCategory();
	}
	
	@GetMapping("/getBestSellerList")
	public List<Map<String, Object>> getBestSellerList(){
		return paymentService.getBestSellerList();
	}
	
	@GetMapping("/getSalesListByStore")
	public List<Map<String, Object>> getSalesListByStore(){
		return paymentService.getSalesListByStore();
	}
}
