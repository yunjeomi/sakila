package com.gd.sakila.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Film;

@Mapper
public interface FilmMapper {
	List<Map<String, Object>> selectFilmList(Map<String, Object> map);
	int selectFilmTotal(Map<String, Object> map);
	Map<String, Object> selectFilmOne(int filmId);
	List<Film> selectFilmTitleList(String keyWord);
	List<Integer> selectFilmInStock(Map<String, Object> map);
	int insertFilm(Film film);
	int insertFilmCategory(Map<String, Object> map);
}
