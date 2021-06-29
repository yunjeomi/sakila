package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.FilmMapper;
import com.gd.sakila.mapper.PaymentMapper;
import com.gd.sakila.mapper.RentalMapper;
import com.gd.sakila.vo.Payment;
import com.gd.sakila.vo.Rental;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class RentalService {
	@Autowired RentalMapper rentalMapper;
	@Autowired FilmMapper filmMapper;
	@Autowired PaymentMapper paymentMapper;
	
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
	
	public List<Map<String, Object>> getRentalListLast(){
		return rentalMapper.selectRentalListLast();
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
	
	public int addRental(String[] customerIdStr, String[] inventoryIdStr, String[] staffIdStr) {
		int addRentalCnt = 0;
		int addPaymentCnt = 0;
		int totalCnt = 0;
		//arr를 변환후 메소드 실행해주기
		for(int i=0; i<customerIdStr.length; i++) {
			log.debug("▶@▶@▶@▶대여 customerId->["+customerIdStr[i]+"], inventoryId->["+inventoryIdStr[i]+"], staffId->["+staffIdStr[i]+"]");
			int customerId = Integer.parseInt(customerIdStr[i]);
			int inventoryId = Integer.parseInt(inventoryIdStr[i]);
			int staffId = Integer.parseInt(staffIdStr[i]);
			
			Rental rental = new Rental();
			
			rental.setCustomerId(customerId);
			rental.setInventoryId(inventoryId);
			rental.setStaffId(staffId);
			addRentalCnt = rentalMapper.insertRental(rental);
			log.debug("▶@▶@▶@▶rental등록 성공1, 실패0-> "+addRentalCnt);
			int rentalId = rental.getRentalId();
			log.debug("▶@▶@▶@▶바로 얻어온 rentalId-> "+rentalId);
			
			//rental 테이블에 db추가후 payment도 바로 추가해준다.
			Payment payment = new Payment();
			payment.setCustomerId(customerId);
			payment.setStaffId(staffId);
			payment.setRentalId(rentalId);	//rental에서 얻어온 rentalId 값
			payment.setAmount(paymentMapper.selectAmountFromRentalDate(rentalId));	//쿼리를 통해 새로 가져온 amount를 넣어준다.
			addPaymentCnt = paymentMapper.insertPayment(payment);
			log.debug("▶@▶@▶@▶payment등록 성공1, 실패0-> "+addPaymentCnt);
			
			totalCnt += 1;	//rental & payment 묶어서 하나 등록
		}
		return totalCnt;	//총 몇개를 등록했는지?
	}
}
