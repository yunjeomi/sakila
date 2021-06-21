package com.gd.sakila.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gd.sakila.mapper.CountryMapper;
import com.gd.sakila.service.StaffService;
import com.gd.sakila.vo.Address;
import com.gd.sakila.vo.City;
import com.gd.sakila.vo.Country;
import com.gd.sakila.vo.Staff;

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
	
	@GetMapping("/getStaffOne")
	public String getStaffOne(Model model, HttpSession session, @RequestParam(value = "staffId") int staffId) {
		log.debug("●●●●▶staffId-> "+staffId);
		Staff loginStaff = (Staff)session.getAttribute("loginStaff");
		Map<String, Object> staffOne = staffService.getStaffOne(staffId);
		model.addAttribute("staffOne", staffOne);
		model.addAttribute("loginStaff", loginStaff);
		return "getStaffOne";
	}
	
	@GetMapping("/addStaff")
	public String addStaff(Model model) {
		List<Country> countryList = countryMapper.selectCountryList();
		model.addAttribute("countryList", countryList);
		return "addStaff";
	}
	
	@PostMapping("/addStaff")
	public String addStaff(City city, Address address, Staff staff, MultipartFile multipartFile) {
		log.debug("●●●●▶city-> "+city.toString());
		log.debug("●●●●▶address-> "+address.toString());
		log.debug("●●●●▶staff-> "+staff.toString());
		log.debug("●●●●▶multipartfile-> "+multipartFile);
		
		int cnt = staffService.addStaff(city, address, staff, multipartFile);
		log.debug("●●●●▶staff 추가 완료1. 실패0-> "+cnt);
		
		return "redirect:/admin/getStaffList";
	}
	
	@GetMapping("/modifyStaff")
	public String modifyStaff() {
		return "modifyStaff";
	}
	
	@PostMapping("/modifyStaff")
	public String modifyStaff(Staff staff) {
		return "modifyStaff";
	}
	
}
