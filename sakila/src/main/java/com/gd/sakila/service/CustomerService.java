package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.CustomerMapper;
import com.gd.sakila.mapper.PaymentMapper;

import lombok.extern.slf4j.Slf4j;

@Transactional
@Slf4j
@Service
public class CustomerService {
	@Autowired CustomerMapper customerMapper;
	@Autowired PaymentMapper paymentMapper;
	
	public Map<String, Object> getCustomerList(int currentPage, int rowPerPage, String searchWord, Integer storeId){
		log.debug("●●●●▶ currentPage-> "+currentPage);
		log.debug("●●●●▶ rowPerPage-> "+rowPerPage);
		log.debug("●●●●▶ searchWord-> "+searchWord);
		log.debug("●●●●▶ storeId-> "+storeId);
		
		Map<String, Object> getMap = new HashMap<>();
		getMap.put("rowPerPage", rowPerPage);
		getMap.put("searchWord", searchWord);
		getMap.put("storeId", storeId);
		
		//페이징할 때 필요한 것
		//totalPage, lastPage, beginRow
		//totalPage구하기 위해 위 값들을 먼저 넣는다.
		int beginRow = (currentPage-1)*rowPerPage;
		int totalPage = customerMapper.selectCustomerTotal(getMap);
		int lastPage = totalPage/rowPerPage;
		if(totalPage % rowPerPage != 0) {
			lastPage += 1;
		}
		
		log.debug("●●●●▶ totalPage-> "+totalPage);
		log.debug("●●●●▶ lastPage-> "+lastPage);
		
		//customerList얻기 위해 구한 beginRow를 map에 넣어준다.
		getMap.put("beginRow", beginRow);
		
		List<Map<String, Object>> customerList = customerMapper.selectCustomerList(getMap);
		log.debug("●●●●▶ customerList-> "+customerList);
		
		Map<String, Object> map = new HashMap<>();
		map.put("customerList", customerList);
		map.put("lastPage", lastPage);
		map.put("totalPage", totalPage);
		
		return map;
	}
	
	public Map<String, Object> getCustomerOne(int customerId){
		log.debug("●●●●▶ customerId-> "+customerId);
		Map<String, Object> customerOne = customerMapper.selectCustomerOne(customerId);
		log.debug("●●●●▶ customerOne-> "+customerOne);
		double payment = paymentMapper.selectPaymentByCustomer(customerId);
		log.debug("●●●●▶ 총 구매액 payment-> "+payment);
		
		//return null일 때, not null일 때 구분한다.
		//null -> 0 / not null -> 1
		List<Map<String, Object>> rentalListOfNull = customerMapper.selectRentalListByCustomer(customerId, 0);
		List<Map<String, Object>> rentalListOfNotNull = customerMapper.selectRentalListByCustomer(customerId, 1);
		log.debug("●●●●▶ 대여중 리스트 rentalListOfNull-> "+rentalListOfNull);
		log.debug("●●●●▶ 대여완료 리스트 rentalListOfNotNull-> "+rentalListOfNotNull);
		
		Map<String, Object> map = new HashMap<>();
		map.put("customerOne", customerOne);
		map.put("payment", payment);
		map.put("rentalListOfNull", rentalListOfNull);
		map.put("rentalListOfNotNull", rentalListOfNotNull);
		
		return map;
	}
	
	public void modifyCustomerActiveByScheduler() {
		log.debug("●●●●▶ modifyCustomerActiveByScheduler()실행");
		int cnt = customerMapper.updateCustomerActiveByScheduled();
		log.debug("●●●●▶ 휴면고객 처리 수-> "+cnt);
	}

}
