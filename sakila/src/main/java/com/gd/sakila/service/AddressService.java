package com.gd.sakila.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.AddressMapper;
import com.gd.sakila.vo.Address;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class AddressService {
	@Autowired AddressMapper addressMapper;
	
	public List<Address> getPhone() {
		return addressMapper.selectPhone();
	}
}
