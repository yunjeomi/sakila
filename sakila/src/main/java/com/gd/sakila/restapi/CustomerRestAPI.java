package com.gd.sakila.restapi;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.sakila.service.CityService;
import com.gd.sakila.service.CustomerService;
import com.gd.sakila.vo.City;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class CustomerRestAPI {
	@Autowired CustomerService customerService;
	@Autowired CityService cityService;
	//RestController 대신 ->ResponseBody 사용 가능
	
	@GetMapping("/phoneNumList")
	public Integer addCustomer(@RequestParam(value = "phone") String phone) {
		return customerService.getPhone(phone);
	}
	
	@GetMapping("/cityList")
	public List<City> addCustomer(@RequestParam(value = "countryId") int countryId) {
		List<City> cityList = cityService.getCity(countryId);
		log.debug("●●●●▶ cityList-> "+cityList);
		return cityService.getCity(countryId);
	}
}
