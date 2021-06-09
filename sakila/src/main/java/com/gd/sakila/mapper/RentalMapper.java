package com.gd.sakila.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Rental;

@Mapper
public interface RentalMapper {
	List<Map<String, Object>> selectRentalList(Map<String, Object> map);
	int selectRentalListTotal(Map<String, Object> map);
	int insertRental(Rental rental);
}
