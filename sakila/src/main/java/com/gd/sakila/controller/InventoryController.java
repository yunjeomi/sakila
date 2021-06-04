package com.gd.sakila.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.InventoryService;
import com.gd.sakila.vo.Inventory;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class InventoryController {
	@Autowired InventoryService inventoryService;
	
	@GetMapping("/getInventoryList")
	public String getInventoryList(Model model, @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
												@RequestParam(value = "rowPerPage", defaultValue = "10") int rowPerPage,
												@RequestParam(value = "searchWord", required = false) String searchWord,
												@RequestParam(value = "storeId", required = false) Integer storeId,
												@RequestParam(value = "notInStock", required = false) Integer notInStock) {
		log.debug("▶@▶@▶@▶currentPage-> "+currentPage);
		log.debug("▶@▶@▶@▶rowPerPage-> "+rowPerPage);
		log.debug("▶@▶@▶@▶searchWord-> "+searchWord);
		log.debug("▶@▶@▶@▶storeId-> "+storeId);
		log.debug("▶@▶@▶@▶notInStock-> "+notInStock);
		
		//String 넘어오는 값 전처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		Map<String, Object> map = inventoryService.getInventoryList(currentPage, rowPerPage, searchWord, storeId, notInStock);
		model.addAttribute("inventoryList", map.get("inventoryList"));
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("totalRow", map.get("totalRow"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("storeId", storeId);
		model.addAttribute("notInStock", notInStock);
		
		return "getInventoryList";
	}
	
	@GetMapping("/addInventory")
	public String addInventory() {
		return "addInventory";
	}
	
	@PostMapping("/addInventory")
	public String addInventory(Inventory inventory, int ea) {
		log.debug("▶@▶@▶@▶inventory-> "+inventory);
		log.debug("▶@▶@▶@▶추가 갯수-> "+ea);
		
		int totalCnt = inventoryService.addInventory(inventory, ea);
		log.debug("▶@▶@▶@▶추가 갯수:"+ea+", 처리 횟수(service실행 후):"+totalCnt);
		
		return "redirect:/admin/getInventoryList";
	}
}
