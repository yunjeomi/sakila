package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.PaymentMapper;
import com.gd.sakila.mapper.RentalMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class PaymentService {
	@Autowired PaymentMapper paymentMapper;
	@Autowired RentalMapper rentalMapper;
	
	public List<Map<String, Object>> getSalesListByCategory(){
		return paymentMapper.selectSalesListByCategory();
	}
	
	public List<Map<String, Object>> getBestSellerList(){
		return paymentMapper.selectBestSellerList();
	}
	
	public List<Map<String, Object>> getSalesListByStore(){
		return paymentMapper.selectSalesListByStore();
	}
	
	public List<Map<String, Object>> getPaymentInfoListByStoreId(String phone, int storeId){
		Map<String, Object> map = new HashMap<>();
		map.put("phone", phone);
		map.put("storeId", storeId);
		log.debug("▶@▶@▶@▶map-> "+map);
		return paymentMapper.selectPaymentInfoList(map);
	}
	
	public List<Map<String, Object>> getPaymentInfoListByTitle(String phone, int storeId, String title){
		Map<String, Object> map = new HashMap<>();
		map.put("phone", phone);
		map.put("storeId", storeId);
		map.put("title", title);
		log.debug("▶@▶@▶@▶map-> "+map);
		return paymentMapper.selectPaymentInfoList(map);
	}
	
	public int modifyAmount(Double amount) {
		log.debug("▶@▶@▶@▶amount-> "+amount);
		return paymentMapper.updateAmount(amount);
	}
	
	public int modifyRentalAndPayment(Double amount, int rentalId) {
		log.debug("▶@▶@▶@▶amount-> "+amount);
		log.debug("▶@▶@▶@▶rentalId-> "+rentalId);
		
		//결제&반납 시 처리해야 할 것 
		//1. rental table의 return_date NOW로 수정
		int rentalCnt = rentalMapper.updateReturnDate(rentalId);
		log.debug("▶@▶@▶@▶paymentCnt 수정 완료1, 실패0-> "+rentalCnt);
		
		//2. payment table의 amount를 paymentFee로 수정
		int paymentCnt = paymentMapper.updateAmount(amount);
		log.debug("▶@▶@▶@▶paymentCnt 수정 완료1, 실패0-> "+paymentCnt);
		return rentalCnt+paymentCnt;
	}
}
