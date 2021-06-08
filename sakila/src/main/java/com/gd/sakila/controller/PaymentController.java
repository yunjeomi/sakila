package com.gd.sakila.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gd.sakila.service.PaymentService;

@RequestMapping("/admin")
@Controller
public class PaymentController {
	@Autowired PaymentService paymentService;
	
	@GetMapping("/addPayment")
	public String addPayment() {
		return "addPayment";
	}
}
