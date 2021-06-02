package com.gd.sakila.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.CustomerService;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/admin")
@Controller
@Slf4j
public class CustomerController {
	@Autowired CustomerService customerService;
	
	@GetMapping("/getCustomerList")
	public String getCustomerList(Model model, 
								@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
								@RequestParam(value = "rowPerPage", defaultValue = "10") int rowPerPage,
								@RequestParam(value = "searchWord", required = false) String searchWord,
								@RequestParam(value = "storeId", required = false) Integer storeId) {
		log.debug("●●●●▶ currentPage-> "+currentPage);
		log.debug("●●●●▶ rowPerPage-> "+rowPerPage);
		log.debug("●●●●▶ searchWord-> "+searchWord);
		log.debug("●●●●▶ storeId-> "+storeId);
		
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		if(storeId != null && storeId == 0) {
			storeId = null;
		}
		
		Map<String, Object> map = customerService.getCustomerList(currentPage, rowPerPage, searchWord, storeId);
		
		model.addAttribute("customerList", map.get("customerList"));
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("totalPage", map.get("totalPage"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("storeId", storeId);
		
		return "getCustomerList";
	}
	
	@GetMapping("/getCustomerOne")
	public String getCustomerOne(Model model, @RequestParam(value = "customerId", required = true) int customerId) {
		log.debug("●●●●▶ customerId-> "+customerId);
		
		Map<String, Object> map = customerService.getCustomerOne(customerId);
		log.debug("●●●●▶ customerOne(정보,구매액,대여리스트)-> "+map);
		
		model.addAttribute("customerOne", map.get("customerOne"));
		model.addAttribute("payment", map.get("payment"));
		model.addAttribute("rentalListOfNull", map.get("rentalListOfNull"));
		model.addAttribute("rentalListOfNotNull", map.get("rentalListOfNotNull"));
		return "getCustomerOne";
	}
}
