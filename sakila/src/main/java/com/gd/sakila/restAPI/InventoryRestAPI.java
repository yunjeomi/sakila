package com.gd.sakila.restAPI;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gd.sakila.service.InventoryService;
import com.gd.sakila.vo.Film;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class InventoryRestAPI {
	@Autowired InventoryService inventoryService;
	
	@GetMapping("/filmTitleList")
	public List<Film> addInventory(@RequestParam(value = "keyWord", required = false) String keyWord) {
		log.debug("▶@▶@▶@▶keyWord-> "+keyWord);
		return inventoryService.addInventoryByFilmTitleList(keyWord);
	}
	
	@GetMapping("/filmTitleListByStoreId")
	public List<Map<String, Object>> removeInventory(@RequestParam(value = "storeId", required = true) int storeId,
												@RequestParam(value = "keyWord", required = false) String keyWord) {
		log.debug("▶@▶@▶@▶keyWord-> "+storeId);
		log.debug("▶@▶@▶@▶keyWord-> "+keyWord);
		return inventoryService.removeInventoryByFilmTitleList(storeId, keyWord);
	}
}
