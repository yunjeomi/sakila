package com.gd.sakila.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gd.sakila.service.PaymentService;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/admin")
@Controller
@Slf4j
public class PaymentController {
	@Autowired PaymentService paymentService;
	
	@GetMapping("/addPayment")
	public String addPayment() {
		return "addPayment";
	}
	
	@PostMapping("/addPayment")
	public String addPayment(String[] rentalId, String[] amount) {
		for(int i=0; i<rentalId.length; i++) {
			log.debug("▶@▶@▶@▶rentalId-> "+rentalId[i]+", amount->["+amount[i]+"]");
		}
		int modifyCnt = paymentService.modifyRentalAndPayment(rentalId, amount);
		log.debug("▶@▶@▶@▶총 수정 내역-> "+modifyCnt);
		return "redirect:/admin/getRentalList";
	}
}
