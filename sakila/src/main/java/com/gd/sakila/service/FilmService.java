package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.FilmMapper;
import com.gd.sakila.vo.Film;
import com.gd.sakila.vo.Page;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class FilmService {
	@Autowired FilmMapper filmMapper;
	
	public Film getFilmOne(String title) {
		return filmMapper.selectFilmOne(title);		
	}
	
	public Map<String, Object> getFilmOne(int filmId, int storeId){
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("filmId", filmId);
		paramMap.put("storeId", storeId);
		int filmCount = 0;
		paramMap.put("filmCount", filmCount);
		
		//프로시저 실행
		List<Integer> list = filmMapper.selectFilmInStock(paramMap);
		log.debug("●●●●▶filmCount-> "+paramMap.get("filmCount"));
		log.debug("●●●●▶list-> "+list);
		log.debug("●●●●▶paramMap-> "+paramMap);
		
		return paramMap;
	}
	
	
	public Map<String, Object> getFilmList(int currentPage, int rowPerPage, String searchWord, String selectSearch) {
		log.debug("●●●●▶currentPage-> "+currentPage);
		log.debug("●●●●▶rowPerPage-> "+rowPerPage);
		log.debug("●●●●▶searchWord-> "+searchWord);
		log.debug("●●●●▶selectSearch-> "+selectSearch);
		
		//페이징 시 필요한 것
		//rowPerPage, beginRow, lastPage, currentPage
		
		Map<String, Object> getMap = new HashMap<>();
		getMap.put("searchWord", searchWord);
		getMap.put("selectSearch", selectSearch);
		
		int totalPage = filmMapper.selectFilmTotal(getMap);
		int lastPage = totalPage/rowPerPage;
		if(totalPage%rowPerPage == 0) {
			lastPage += 1;
		}
		int beginRow = (currentPage-1)*rowPerPage;
		log.debug("●●●●▶lastPage-> "+lastPage);
		
		//vo page 채워넣고 요 값들을 메소드에 넘겨준다
		Page page = new Page();
		page.setBeginRow(beginRow);
		page.setRowPerPage(rowPerPage);
		page.setSearchWord(searchWord);
		log.debug("●●●●▶page-> "+page);
		
		getMap.put("beginRow", beginRow);
		getMap.put("rowPerPage", rowPerPage);
		
		List<Map<String, Object>> filmList = filmMapper.selectFilmList(getMap);
		log.debug("●●●●▶filmList-> "+filmList);
		
		Map<String, Object> map = new HashMap<>();
		map.put("filmList", filmList);
		map.put("lastPage", lastPage);
		
		return map;
	}
}
