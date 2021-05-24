package com.gd.sakila.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.CustomerMapper;

import lombok.extern.slf4j.Slf4j;

@Transactional
@Slf4j
@Service
public class CustomerService {
	@Autowired CustomerMapper customerMapper;
	
	public void modifyCustomerActiveByScheduler() {
		log.debug("●●●●▶ modifyCustomerActiveByScheduler()실행");
		int cnt = customerMapper.updateCustomerActiveByScheduled();
		log.debug("●●●●▶ 휴면고객 처리 수-> "+cnt);
	}

}
