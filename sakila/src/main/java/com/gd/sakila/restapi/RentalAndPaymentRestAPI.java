package com.gd.sakila.restapi;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.sakila.service.CustomerService;
import com.gd.sakila.service.RentalService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class RentalAndPaymentRestAPI {
	@Autowired RentalService rentalService;
	@Autowired CustomerService customerService;
	
	@GetMapping("/filmTitleListByStoreIdInRental")
	public List<Map<String, Object>> addRental(@RequestParam(value = "storeId", required = true) int storeId,
												@RequestParam(value = "keyWord", required = false) String keyWord) {
		log.debug("▶@▶@▶@▶keyWord-> "+storeId);
		log.debug("▶@▶@▶@▶keyWord-> "+keyWord);
		return rentalService.addRentalByFilmTitleList(storeId, keyWord);
	}
	
	@GetMapping("/phoneNumListInRental")
	public Integer addRental(@RequestParam(value = "phone") String phone) {
		return customerService.getPhone(phone);
	}
}
