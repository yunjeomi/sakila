package com.gd.sakila.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.AddressMapper;
import com.gd.sakila.mapper.CityMapper;
import com.gd.sakila.mapper.StaffMapper;
import com.gd.sakila.vo.Address;
import com.gd.sakila.vo.City;
import com.gd.sakila.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service	//bean에 service를 생성
@Transactional	//트랜잭션 관리
public class StaffService {
	@Autowired StaffMapper staffMapper;	//mapper 의존객체 주입
	@Autowired CityMapper cityMapper;
	@Autowired AddressMapper addressMapper;
	
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
	public List<Map<String, Object>> getStaffList(){
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
	
	//staff 추가
	public int addStaff(City city, Address address, Staff staff) {
		log.debug("●●●●▶city-> "+city);
		log.debug("●●●●▶address-> "+address);
		log.debug("●●●●▶staff-> "+staff);
		
		int cityId = 0;
		
		//cityId가 0일때는 새로 추가하는 것
		if(city.getCityId() == 0) {
			String cityName = city.getCity().substring(0, 1).toUpperCase()+city.getCity().substring(1).toLowerCase();
			City setCity = new City();
			setCity.setCity(cityName);
			setCity.setCountryId(city.getCountryId());
			log.debug("●●●●▶추가할 city정보-> "+setCity);
			
			//city 추가 메소드 실행
			int cityCnt = cityMapper.insertCity(setCity);
			log.debug("●●●●▶city추가 성공1, 실패0-> "+cityCnt);
			
			cityId = setCity.getCityId();
			log.debug("●●●●▶추가한 cityId-> "+cityId);
		} else {
			cityId = city.getCityId();
			log.debug("●●●●▶기존의 cityId-> "+cityId);
		}
		
		//얻은 cityId를 address에 넣어준다.
		String district = address.getDistrict().substring(0, 1).toUpperCase()+address.getDistrict().substring(1).toLowerCase();
		Address setAddress = new Address();
		setAddress.setAddress(address.getAddress());
		setAddress.setAddress2(address.getAddress2());
		setAddress.setCityId(cityId);		//city추가 시, 추가된 cityId가 들어온다.
		setAddress.setDistrict(district);
		setAddress.setPhone(address.getPhone());
		setAddress.setPostalCode(address.getPostalCode());
		
		//address 추가 메소드 실행
		int addressCnt = addressMapper.insertAddress(setAddress);
		log.debug("●●●●▶address추가 성공1, 실패0-> "+addressCnt);
		
		//추가한 address의 addressId를 가져온다.
		int addressId = setAddress.getAddressId();
		
		//firstName, lastName -> 첫대문자+나머지소문자, email -> firstName.lastName@sakilastaff.com
		String firstName = staff.getFirstName().substring(0, 1).toUpperCase()+staff.getFirstName().substring(1).toLowerCase();
		String lastName = staff.getLastName().substring(0, 1).toUpperCase()+staff.getLastName().substring(1).toLowerCase();
		String email = firstName+"."+lastName+"@sakilastaff.com";
		log.debug("●●●●▶firstName-> "+firstName);
		log.debug("●●●●▶lastName-> "+lastName);
		log.debug("●●●●▶email-> "+email);
		
		//얻은 addressId를 staff에 넣어준다.
		Staff setStaff = new Staff();
		setStaff.setFirstName(firstName);
		setStaff.setLastName(lastName);
		setStaff.setEmail(email);
		setStaff.setPicture(staff.getPicture());
		setStaff.setAddressId(addressId);
		setStaff.setPassword(staff.getPassword());
		setStaff.setStoreId(staff.getStoreId());
		
		//picture설정
		
		//staff 추가 메소드 실행
		int staffCnt = staffMapper.insertStaff(setStaff);
		log.debug("●●●●▶staff추가 성공1, 실패0-> "+staffCnt);
		
		return staffCnt;
	}
}
