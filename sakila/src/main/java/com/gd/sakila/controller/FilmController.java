package com.gd.sakila.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.CategoryService;
import com.gd.sakila.service.FilmService;
import com.gd.sakila.service.LanguageService;
import com.gd.sakila.vo.Category;
import com.gd.sakila.vo.FilmForm;
import com.gd.sakila.vo.Language;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/admin")
@Controller
public class FilmController {
	@Autowired FilmService filmService;
	@Autowired CategoryService categoryService;
	@Autowired LanguageService languageService;
	
	@GetMapping("/getFilmList")
	public String getFilmList(Model model, 
								@RequestParam(value ="currentPage", defaultValue = "1") int currentPage, 
								@RequestParam(value = "rowPerPage", defaultValue = "10") int rowPerPage,
								@RequestParam(value = "searchWord", required = false) String searchWord,
								@RequestParam(value = "selectSearch", required = false) String selectSearch,
								@RequestParam(value = "categoryName", required = false) String categoryName,
								@RequestParam(value = "price", required = false) Double price,	//wrapper type은 null, 0 둘 다 가능
								@RequestParam(value = "duration", required = false) Integer duration,
								@RequestParam(value = "rating", required = false) String rating){
		log.debug("●●●●▶currentPage-> "+currentPage);
		log.debug("●●●●▶rowPerPage-> "+rowPerPage);
		log.debug("●●●●▶searchWord-> "+searchWord);
		log.debug("●●●●▶selectSearch-> "+selectSearch);
		log.debug("●●●●▶categoryName-> "+categoryName);
		log.debug("●●●●▶price-> "+price);
		log.debug("●●●●▶duration-> "+duration);
		log.debug("●●●●▶rating-> "+rating);
		
		//search 없이 상세보기만 검색했을 경우 공백으로 출력되는 현상 수정
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		if(selectSearch != null && selectSearch.equals("")) {
			selectSearch = null;
		}
		
		//카테고리, 가격, 기간 선택하지 않고 검색했을 때 생기는 버그 수정
		if(categoryName != null && (categoryName.equals("null") || categoryName.equals(""))) {
			categoryName = null;
		}
		if(price != null && price == 0.0) {
			price = null;
		}
		if(duration != null && duration == 0) {
			duration = null;
		}
		if(rating != null && (rating.equals("null") || rating.equals(""))) {
			rating = null;
		}
		
		Map<String, Object> map = filmService.getFilmList(currentPage, rowPerPage, searchWord, selectSearch, categoryName, price, duration, rating);
		
		model.addAttribute("filmList", map.get("filmList"));
		model.addAttribute("categoryList", map.get("categoryList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("totalPage", map.get("totalPage"));
		model.addAttribute("ratingList", map.get("ratingList"));
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("selectSearch", selectSearch);
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("price", price);
		model.addAttribute("duration", duration);
		model.addAttribute("rating", rating);
		
		return "getFilmList";
	}
	
	@GetMapping("/getFilmOne")
	public String getFilmOne(Model model, @RequestParam(value = "filmId", required = true) int filmId) {
		log.debug("●●●●▶filmId-> "+filmId);
		Map<String, Object> getFilmOne = filmService.getFilmOne(filmId);
		log.debug("●●●●▶getFilmOne-> "+getFilmOne);
		
		
		//new store 고려x
		Map<String, Object> store1 = filmService.getFilmOne(filmId, 1);	//film_id, store_id 넣어주면 몇개 남았나 알려준다.
		Map<String, Object> store2 = filmService.getFilmOne(filmId, 2);
		log.debug("●●●●▶store1-> "+store1);
		log.debug("●●●●▶store2-> "+store2);
		
		model.addAttribute("getFilmOne", getFilmOne);
		model.addAttribute("store1", store1);
		model.addAttribute("store2", store2);
		
		return "getFilmOne";
	}
	
	@GetMapping("/modifyActorInFilmOne")
	public String modifyActorInFilmOne(Model model, 
									@RequestParam(value = "filmId", required = true) int filmId) {
		log.debug("●●●●▶filmId-> "+filmId);
		
		Map<String, Object> actorList = filmService.addActorInFilmOne(filmId);
		log.debug("●●●●▶actorList-> "+actorList);
		
		model.addAttribute("actorListInFilm", actorList.get("actorListInFilm"));
		model.addAttribute("actorListNotInFilm", actorList.get("actorListNotInFilm"));
		model.addAttribute("filmId", filmId);
		return "modifyActorInFilmOne";
	}
	
	@PostMapping("/modifyActorInFilmOne")
	public String modifyActorInFilmOne(@RequestParam(value = "filmId", required = true) int filmId,
										@RequestParam(value = "actorCk") int[] actorCk) {
		log.debug("●●●●▶filmId-> "+filmId);
		log.debug("●●●●▶actorCk-> "+actorCk);
		log.debug("●●●●▶actorCk.length-> "+actorCk.length);
		
		filmService.modifyActorInFilmOne(filmId, actorCk);
		
		return "redirect:/admin/getFilmOne?filmId="+filmId;
	}
	
	@GetMapping("/addFilm")
	public String addFilm(Model model) {
		//addFilm에 카테고리 리스트를 출력하기 위해 카테고리 출력 매퍼를 호출한다.
		List<Category> categoryList = categoryService.getCategoryList();
		List<Language> languageList = languageService.getLanguageList();
		log.debug("●●●●▶categoryList-> "+categoryList);
		log.debug("●●●●▶languageList-> "+languageList);
		
		//등급, specialFeatures을 배열값으로 넘겨준다
		String[] ratingList = {"G", "NC-17", "PG", "PG-13", "R"};
		String[] specialFeaturesList = {"Trailers", "Commentaries", "Deleted Scenes", "Behind the Scenes"};
		
		//카테고리 리스트를 넘긴다
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("languageList", languageList);
		model.addAttribute("ratingList", ratingList);
		model.addAttribute("specialFeaturesList", specialFeaturesList);
		return "addFilm";
	}
	
	@PostMapping("/addFilm")
	//1) 매개변수의 이름을 동일하게 한다. 2)RequestParam을 사용한다. 3)Command 타입을 사용한다.
	public String addFilm(FilmForm filmForm) {
		log.debug("●●●●▶filmForm-> "+filmForm);
		log.debug("●●●●▶specialFeatures-> "+filmForm.getSpecialFeatures());
		
		//가져온 값들은 service에서 풀도록 한다.
		//filmId는 값을 보존하기 위한 역할. One으로 이동해서 actor를 추가하려면 filmId가 필요하다
		int filmId = filmService.addFilm(filmForm);
		log.debug("●●●●▶filmId-> "+filmId);
		
		return "redirect:/admin/getFilmOne?filmId="+filmId;
	}
}
