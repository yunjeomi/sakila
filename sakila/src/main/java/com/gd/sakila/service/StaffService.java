package com.gd.sakila.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
	
	/*SELECT
			ID,
			name,
			address,
			`zip code`,
			phone,
			city,
			country,
			SID
		FROM staff_list
	*/
	//스태프 리스트
	public List<Map<String, Object>> selectStaffList(){
		List<Map<String, Object>> staffList = new ArrayList<>();
		staffList = staffMapper.selectStaffList();
		log.debug("●●●●▶selectStaffList staffList-> "+staffList);
		return staffList;
	}
	
	//로그인 정보
	public Staff login(Staff staff){
		log.debug("●●●●▶staff-> "+staff);
		return staffMapper.selectStaffByLogin(staff);
	}
	
	
}
