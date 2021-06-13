package com.gd.sakila.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gd.sakila.mapper.CountryMapper;
import com.gd.sakila.service.StaffService;
import com.gd.sakila.vo.Country;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class StaffController {
	@Autowired StaffService staffService;
	@Autowired CountryMapper countryMapper;
	
	@GetMapping("/getStaffList")
	public String getStaffList(Model model) {
		List<Map<String, Object>> staffList = staffService.getStaffList();
		log.debug("●●●●▶staffList-> "+staffList.toString());
		model.addAttribute("staffList", staffList);
		return "getStaffList";
	}
	
	@GetMapping("/addStaff")
	public String addStaff(Model model) {
		List<Country> countryList = countryMapper.selectCountryList();
		model.addAttribute("countryList", countryList);
		return "addStaff";
	}
}
