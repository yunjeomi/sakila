package com.gd.sakila.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	public String addPayment(@RequestBody Map<String, Object> param) {
		log.debug("▶@▶@▶@▶param-> "+param);
		//log.debug("▶@▶@▶@▶rentalId-> "+rentalId);
		//int modifyCnt = paymentService.modifyRentalAndPayment(amount, rentalId);
		//log.debug("▶@▶@▶@▶amount 수정 완료2, 실패0-> "+modifyCnt);
		return "redirect:/admin/getRentalList";
	}
}
