package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.ActorMapper;
import com.gd.sakila.mapper.CategoryMapper;
import com.gd.sakila.mapper.FilmMapper;
import com.gd.sakila.vo.Category;
import com.gd.sakila.vo.Film;
import com.gd.sakila.vo.FilmForm;
import com.gd.sakila.vo.Page;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class FilmService {
	@Autowired FilmMapper filmMapper;
	@Autowired CategoryMapper categoryMapper;
	@Autowired ActorMapper actorMapper;
	
	public Map<String, Object> getFilmList(int currentPage, int rowPerPage, String searchWord, String selectSearch, String categoryName, Double price, Integer duration, String rating) {
		log.debug("●●●●▶currentPage-> "+currentPage);
		log.debug("●●●●▶rowPerPage-> "+rowPerPage);
		log.debug("●●●●▶searchWord-> "+searchWord);
		log.debug("●●●●▶selectSearch-> "+selectSearch);
		log.debug("●●●●▶categoryName-> "+categoryName);
		log.debug("●●●●▶price-> "+price);
		log.debug("●●●●▶duration-> "+duration);
		log.debug("●●●●▶rating-> "+rating);
		
		
		//selectFilmTotal, selectFilmList에 매개값으로 넘겨줄 새로운 Map을 하나 만들고, 값을 넣어준다.
		Map<String, Object> getMap = new HashMap<>();
		getMap.put("searchWord", searchWord);
		getMap.put("selectSearch", selectSearch);
		getMap.put("categoryName", categoryName);
		getMap.put("price", price);
		getMap.put("duration", duration);
		getMap.put("rating", rating);
		
		//view에서 보여줄 rating list 작성
		String[] ratingList = {"G", "NC-17", "PG", "PG-13", "R"};
			
		//페이징 시 필요한 것
		//rowPerPage, beginRow, lastPage, currentPage
			
		int totalPage = filmMapper.selectFilmTotal(getMap);
		int lastPage = (int)totalPage/rowPerPage;
		if(totalPage%rowPerPage != 0) {
			lastPage += 1;
		}
		int beginRow = (currentPage-1)*rowPerPage;
		log.debug("●●●●▶totalPage-> "+totalPage);
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
		
		List<Category> categoryList = categoryMapper.selectCategoryList();
		log.debug("●●●●▶categoryList-> "+categoryList);
		
		Map<String, Object> map = new HashMap<>();
		map.put("filmList", filmList);
		map.put("categoryList", categoryList);
		map.put("lastPage", lastPage);
		map.put("totalPage", totalPage);
		map.put("ratingList", ratingList);
		log.debug("●●●●▶map-> "+map);
		return map;
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
	
	public Map<String, Object> getFilmOne(int filmId) {
		return filmMapper.selectFilmOne(filmId);		
	}
	
	public Map<String, Object> addActorInFilmOne(int filmId){
		//0->출연중인 배우 리스트, 1->미출연 배우 리스트
		List<Map<String, Object>> actorListInFilm = actorMapper.selectActorInFilmOne(filmId, 0);
		List<Map<String, Object>> actorListNotInFilm = actorMapper.selectActorInFilmOne(filmId, 1);
		log.debug("●●●●▶actorListInFilm-> "+actorListInFilm);
		log.debug("●●●●▶actorListNotInFilm-> "+actorListNotInFilm);
		
		//리턴값이 2개니까 map에 넣어준다
		Map<String, Object> actorList = new HashMap<>();
		actorList.put("actorListInFilm", actorListInFilm);
		actorList.put("actorListNotInFilm", actorListNotInFilm);
		
		return actorList;
	}
	
	public void modifyActorInFilmOne(int filmId, int[] actorId) {
		//service에서 해야할 일
		//1) delete from film_actor where film_id = filmId -> 영화-배우 정보에서 배우id를 먼저 삭제한다
		//2) insert into film_actor(actor_id, film_id) values( , )
		
		//1. 기존의 배우 정보 지우기
		int delCnt = actorMapper.deleteActorInFilmOne(filmId);
		log.debug("●●●●▶delCnt 삭제 완료 "+delCnt+". 실패0-> "+delCnt);
		
		//2. 영화 정보에 배우 정보 넣기
		for(int i=0; i<actorId.length; i++) {
			int inCnt = actorMapper.insertActorInFilmOne(filmId, actorId[i]);
			log.debug("●●●●▶"+actorId[i]+" 추가 완료 1. 실패0-> "+inCnt);
		}
	}
	
	//입력된 addFilm 메소드 실행 시 filmId값을 리턴한다
	public int addFilm(FilmForm filmForm) {
		Film film = filmForm.getFilm();
		Category category = filmForm.getCategory();
		log.debug("●●●●▶film-> "+film);
		log.debug("●●●●▶category-> "+category);
		
		
		//film.setSpecialFeatures(filmForm.getFilm().getSpecialFeatures());
		
		
		//1. 필름을 film 테이블에 먼저 등록한다.
		int filmCnt = filmMapper.insertFilm(film);	//filmId가 생성된 후 film.getFilmId 호출함
		log.debug("●●●●▶addFilmCnt 등록 완료1, 실패0-> "+filmCnt);
		
		//..2를 위한 사전작업..
		Map<String, Object> map = new HashMap<>();
		map.put("filmId", film.getFilmId());
		map.put("categoryId", category.getCategoryId());
		
		//2. 위에 저장된 film 정보를 film_category 테이블에도 등록해준다.
		int fAndC = filmMapper.insertFilmCategory(map);
		log.debug("●●●●▶addFilmAndCategoryCnt 등록 완료1, 실패0-> "+fAndC);
		
		return film.getFilmId();
	}
}
