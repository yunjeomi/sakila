package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.FilmMapper;
import com.gd.sakila.mapper.RentalMapper;
import com.gd.sakila.vo.Rental;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class RentalService {
	@Autowired RentalMapper rentalMapper;
	@Autowired FilmMapper filmMapper;
	
	public Map<String, Object> getRentalList(int currentPage, int rowPerPage, String searchWord, Integer storeId){
		log.debug("▶@▶@▶@▶currentPage-> "+currentPage);
		log.debug("▶@▶@▶@▶rowPerPage-> "+rowPerPage);
		log.debug("▶@▶@▶@▶searchWord-> "+searchWord);
		log.debug("▶@▶@▶@▶storeId-> "+storeId);
		
		//메소드 실행시 매개변수로 넣어줄 setMap
		Map<String, Object> setMap = new HashMap<>();
		setMap.put("searchWord", searchWord);
		setMap.put("storeId", storeId);
		
		//페이징
		int beginRow = (currentPage-1)*rowPerPage;
		int totalRow = rentalMapper.selectRentalListTotal(setMap);
		log.debug("▶@▶@▶@▶totalRow-> "+totalRow);
		int lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		
		//setMap에 나머지 값들 넣어준다.
		setMap.put("beginRow", beginRow);
		setMap.put("rowPerPage", rowPerPage);
		log.debug("▶@▶@▶@▶setMap-> "+setMap);
		
		//리스트 출력 메소드
		List<Map<String, Object>> rentalList = rentalMapper.selectRentalList(setMap);
		log.debug("▶@▶@▶@▶rentalList-> "+rentalList);
		
		//컨트롤러에게 전달해줄 map
		Map<String, Object> map = new HashMap<>();
		map.put("rentalList", rentalList);
		map.put("lastPage", lastPage);
		map.put("totalRow", totalRow);
		
		return map;
	}
	
	public List<Map<String, Object>> addRentalByFilmTitleList(int storeId, String keyWord){
		log.debug("▶@▶@▶@▶storeId-> "+storeId);
		log.debug("▶@▶@▶@▶keyWord-> "+keyWord);
		//selectFilmTitleListByStoreId의 매개타입 Map
		Map<String, Object> setMap = new HashMap<>();
		setMap.put("storeId", storeId);
		setMap.put("keyWord", keyWord);
		return filmMapper.selectFilmTitleListByStoreId(setMap);
	}
	
	public int addRental(String customerId, String inventoryId, String staffId) {
		//String ","로 구분되어 있는 정보를 배열로 구분하고 처리하자.
		log.debug("▶@▶@▶@▶대여 customerId-> "+customerId);
		log.debug("▶@▶@▶@▶대여 inventoryId-> "+inventoryId);
		log.debug("▶@▶@▶@▶대여 staffId-> "+staffId);
		
		String[] customerIdArr = customerId.split(",");
		String[] inventoryIdArr = inventoryId.split(",");
		String[] staffIdArr = staffId.split(",");
		
		Rental rental = new Rental();
		int addRentalCnt = 0;
		int totalCnt = 0;
		//arr를 변환후 메소드 실행해주기
		for(int i=0; i<customerIdArr.length; i++) {
			rental.setCustomerId(Integer.parseInt(customerIdArr[i]));
			rental.setInventoryId(Integer.parseInt(inventoryIdArr[i]));
			rental.setStaffId(Integer.parseInt(staffIdArr[i]));
			addRentalCnt = rentalMapper.insertRental(rental);
			log.debug("▶@▶@▶@▶등록 성공1, 실패0-> "+addRentalCnt);
			totalCnt += 1;
		}
		return totalCnt;
	}
}
