package com.gd.sakila.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RentalMapper {
	List<Map<String, Object>> selectRentalList();
	int selectRentalListTotal();
}
