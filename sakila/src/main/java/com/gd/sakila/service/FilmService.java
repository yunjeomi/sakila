package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.FilmMapper;
import com.gd.sakila.vo.Page;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class FilmService {
	@Autowired FilmMapper filmMapper;
	
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
		
		Map<String, Object> returnMap = new HashMap<>();
		
		return returnMap;
	}
	
	
	public Map<String, Object> getFilmList(int currentPage, int rowPerPage, String searchWord) {
		log.debug("●●●●▶currentPage-> "+currentPage);
		log.debug("●●●●▶rowPerPage-> "+rowPerPage);
		log.debug("●●●●▶searchWord-> "+searchWord);
		
		//페이징 시 필요한 것
		//rowPerPage, beginRow, lastPage, currentPage
		
		int totalPage = filmMapper.selectFilmTotal(searchWord);
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
		
		List<Map<String, Object>> filmList = filmMapper.selectFilmList(page);
		log.debug("●●●●▶filmList-> "+filmList);
		
		Map<String, Object> map = new HashMap<>();
		map.put("filmList", filmList);
		map.put("lastPage", lastPage);
		
		return map;
	}
}
