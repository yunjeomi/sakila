package com.gd.sakila.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Address;

@Mapper
public interface AddressMapper {
	int selectPhone(String phone);
	int insertAddress(Address address);
}
