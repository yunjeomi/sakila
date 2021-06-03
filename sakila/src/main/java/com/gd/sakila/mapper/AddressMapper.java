package com.gd.sakila.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Address;

@Mapper
public interface AddressMapper {
	List<Address> selectPhone();
	int insertAddress(Address address);
}
