package com.gd.sakila.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.AddressMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class AddressService {
	@Autowired AddressMapper addressMapper;
	
	public int getPhone(String phone) {
		return addressMapper.selectPhone(phone);
	}
}
