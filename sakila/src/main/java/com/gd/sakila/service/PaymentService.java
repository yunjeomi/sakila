package com.gd.sakila.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.PaymentMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class PaymentService {
	@Autowired PaymentMapper paymentMapper;
	
	public List<Map<String, Object>> getSalesListByCategory(){
		return paymentMapper.selectSalesListByCategory();
	}
	
	public List<Map<String, Object>> getBestSellerList(){
		return paymentMapper.selectBestSellerList();
	}
	
	public List<Map<String, Object>> getSalesListByStore(){
		return paymentMapper.selectSalesListByStore();
	}
}
