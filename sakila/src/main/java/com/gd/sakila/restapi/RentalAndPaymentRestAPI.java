package com.gd.sakila.restapi;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.sakila.service.CustomerService;
import com.gd.sakila.service.PaymentService;
import com.gd.sakila.service.RentalService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class RentalAndPaymentRestAPI {
	@Autowired RentalService rentalService;
	@Autowired CustomerService customerService;
	@Autowired PaymentService paymentService;
	
	@GetMapping("/filmTitleListByStoreIdInRental")
	public List<Map<String, Object>> addRental(@RequestParam(value = "storeId", required = true) int storeId,
												@RequestParam(value = "keyWord", required = false) String keyWord) {
		log.debug("▶@▶@▶@▶storeId-> "+storeId);
		log.debug("▶@▶@▶@▶keyWord-> "+keyWord);
		return rentalService.addRentalByFilmTitleList(storeId, keyWord);
	}
	
	@GetMapping("/phoneNumListInRental")
	public Map<String, Object> addRental(@RequestParam(value = "phone") String phone) {
		return customerService.getPhone(phone);
	}
	
	@GetMapping("/paymentListInPayment")
	public List<Map<String, Object>> addPayment(@RequestParam(value = "phone", required = true) String phone){
		log.debug("▶@▶@▶@▶phone-> "+phone);
		return paymentService.getPaymentInfoListInPayment(phone);
	}
	
	@GetMapping("/paymentListByStoreIdInPayment")
	public List<Map<String, Object>> addPayment(@RequestParam(value = "phone", required = true) String phone,
												@RequestParam(value = "storeId", required = true) int storeId){
		log.debug("▶@▶@▶@▶storeId-> "+storeId);
		log.debug("▶@▶@▶@▶phone-> "+phone);
		return paymentService.getPaymentInfoListByStoreIdInPayment(phone, storeId);
	}
	
	@GetMapping("/paymentListByTitleInPayment")
	public List<Map<String, Object>> addPayment(@RequestParam(value = "phone", required = true) String phone,
												@RequestParam(value = "storeId", required = true) int storeId,
												@RequestParam(value = "title", required = true) String title){
		log.debug("▶@▶@▶@▶storeId-> "+storeId);
		log.debug("▶@▶@▶@▶phone-> "+phone);
		log.debug("▶@▶@▶@▶title-> "+title);
		return paymentService.getPaymentInfoListByTitle(phone, storeId, title);
	}
	
}
