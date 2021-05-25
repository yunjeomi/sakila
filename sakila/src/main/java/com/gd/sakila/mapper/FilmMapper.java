package com.gd.sakila.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FilmMapper {
	List<Map<String, Object>> selectFilmList(Map<String, Object> map);
	int selectFilmTotal(Map<String, Object> map);
	Map<String, Object> selectFilmOne(String title);
	List<Integer> selectFilmInStock(Map<String, Object> map);
}
