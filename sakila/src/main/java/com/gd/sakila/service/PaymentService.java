package com.gd.sakila.service;

import java.util.ArrayList;
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
		List<Map<String, Object>> list = new ArrayList<>();
		list = paymentMapper.selectPaymentInfoList(map);
		log.debug("▶@▶@▶@▶list-> "+list);
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
	
	public int modifyRentalAndPayment(String[] rentalIdStr, String[] amountStr) {
		int rentalCnt = 0;
		int paymentCnt = 0;
		int totalCnt = 0;
		
		//String으로 들어온 값 double, int로 변환하기
		for(int i=0; i<rentalIdStr.length; i++) {
			log.debug("▶@▶@▶@▶rentalIdStr-> "+rentalIdStr[i]+", amountStr-> "+amountStr[i]);
			int rentalId = Integer.parseInt(rentalIdStr[i]);
			double amount = Double.parseDouble(amountStr[i]);
			
			Map<String, Object> map = new HashMap<>();
			map.put("rentalId", rentalId);
			map.put("amount", amount);
			
			//결제&반납 시 처리해야 할 것 
			//1. rental table의 return_date NOW로 수정
			rentalCnt = rentalMapper.updateReturnDate(rentalId);
			log.debug("▶@▶@▶@▶rentalCnt return_date 수정 완료1, 실패0-> "+rentalCnt);
			
			//2. payment table의 amount를 paymentFee로 수정
			paymentCnt = paymentMapper.updateAmount(map);
			log.debug("▶@▶@▶@▶paymentCnt amount 수정 완료1, 실패0-> "+paymentCnt);
			
			//총 진행 횟수
			totalCnt += 1;
		}
		
		log.debug("▶@▶@▶@▶수정한 내역-> "+totalCnt);
		return totalCnt;
	}
}
