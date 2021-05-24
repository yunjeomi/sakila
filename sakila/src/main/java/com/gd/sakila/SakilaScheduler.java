package com.gd.sakila;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gd.sakila.service.CustomerService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class SakilaScheduler {
	@Autowired CustomerService customerService;
	
	//Scheduled 메소드 리턴값, 매개변수값 없음
	@Scheduled(cron = "0 0 0 1 * *")	//초-분-시-일-월-요일-(*년); 매달 1일에 이 메소드가 실행된다
	public void modifyCustomerActive() {
		customerService.modifyCustomerActiveByScheduler();
		log.debug("●●●●▶휴면 고객 스케쥴러 실행 완료");
	}
}
