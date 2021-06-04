package com.gd.sakila.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gd.sakila.mapper.CountryMapper;
import com.gd.sakila.service.AddressService;
import com.gd.sakila.service.CityService;
import com.gd.sakila.service.CustomerService;
import com.gd.sakila.vo.Address;
import com.gd.sakila.vo.City;
import com.gd.sakila.vo.Country;
import com.gd.sakila.vo.CustomerForm;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/admin")
@Controller
@Slf4j
public class CustomerController {
	@Autowired CustomerService customerService;
	@Autowired CountryMapper countryMapper;
	@Autowired AddressService addressService;
	@Autowired CityService cityService;
	
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
		
		Map<String, Object> map = customerService.getCustomerList(currentPage, rowPerPage, searchWord, storeId);
		
		model.addAttribute("customerList", map.get("customerList"));
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("totalRow", map.get("totalRow"));
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
	
	
	@GetMapping("/addCustomer")
	public String addCustomer(Model model) {
		List<Country> countryList = countryMapper.selectCountryList();
		log.debug("●●●●▶ countryList-> "+countryList);
		model.addAttribute("countryList", countryList);
		return "addCustomer";
	}
	
	//.ajax; RestController 사용하니까 여기 페이지는 다 에러발생,,~
	@ResponseBody
	@GetMapping("/addCustomer/phone")
	public List<Address> addCustomer() {
		return addressService.getPhone();
	}
	
	@ResponseBody
	@GetMapping("/addCustomer/city")
	public List<City> addCustomer(@RequestParam(value = "countryId") int countryId) {
		List<City> cityList = cityService.getCity(countryId);
		log.debug("●●●●▶ cityList-> "+cityList);
		return cityService.getCity(countryId);
	}
	
	@PostMapping("/addCustomer")
	public String addCustomer(CustomerForm customerForm) {
		log.debug("●●●●▶ customerForm-> "+customerForm);
		customerService.addCustomer(customerForm);
		return "redirect:/admin/getCustomerList";
	}
}
