package com.gd.sakila.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Film;
import com.gd.sakila.vo.Page;

@Mapper
public interface FilmMapper {
	List<Map<String, Object>> selectFilmList(Map<String, Object> map);
	int selectFilmTotal(Map<String, Object> map);
	List<Integer> selectFilmInStock(Map<String, Object> map);
	Film selectFilmOne(String title);
}
