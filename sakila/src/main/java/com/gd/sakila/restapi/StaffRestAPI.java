package com.gd.sakila.restapi;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.sakila.service.CityService;
import com.gd.sakila.vo.City;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/admin")
@Slf4j
@RestController
public class StaffRestAPI {
	@Autowired CityService cityService;
	
	@GetMapping("/cityList")
	public List<City> addStaff(@RequestParam(value = "countryId") int countryId) {
		List<City> cityList = cityService.getCity(countryId);
		log.debug("@@@@@@@cityList-> "+cityList);
		return cityService.getCity(countryId);
	}
}
