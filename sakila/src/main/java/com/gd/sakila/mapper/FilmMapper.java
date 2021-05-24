package com.gd.sakila.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Page;

@Mapper
public interface FilmMapper {
	List<Map<String, Object>> selectFilmList(Page page);
	int selectFilmTotal(String searchWord);
	List<Integer> selectFilmInStock(Map<String, Object> map);
}
