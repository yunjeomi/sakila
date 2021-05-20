package com.gd.sakila.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.StaffMapper;
import com.gd.sakila.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service	//bean에 service를 생성
@Transactional	//트랜잭션 관리
public class StaffService {
	@Autowired StaffMapper staffMapper;	//mapper 의존객체 주입
	public Staff login(Staff staff){
		log.debug("●●●●▶staff-> "+staff);
		return staffMapper.selectStaffByLogin(staff);
	}
}
