package com.gd.sakila.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.FilmService;
import com.gd.sakila.vo.Film;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/admin")
@Controller
public class FilmController {
	@Autowired FilmService filmService;
	
	@GetMapping("/getFilmOne")
	public String getFilmOne(Model model, @RequestParam(value = "title", required = true) String title) {
		log.debug("●●●●▶title-> "+title);
		Film getFilmOne = new Film();
		getFilmOne = filmService.getFilmOne(title);
		log.debug("●●●●▶getFilmOne-> "+getFilmOne);
		
		//new store 고려x -> 나중에 한번에 보내서 for문으로 출력하도록 수정
		Map<String, Object> store1 = filmService.getFilmOne(getFilmOne.getFilmId(), 1);	//film_id, store_id 넣어주면 몇개 남았나 알려준다.
		Map<String, Object> store2 = filmService.getFilmOne(getFilmOne.getFilmId(), 2);
		log.debug("●●●●▶store1-> "+store1);
		log.debug("●●●●▶store2-> "+store2);
		model.addAttribute("getFilmOne", getFilmOne);
		model.addAttribute("store1", store1);
		model.addAttribute("store2", store2);
		
		return "getFilmOne";
	}
	
	@GetMapping("/getFilmList")
	public String getFilmList(Model model, 
								@RequestParam(value ="currentPage", defaultValue = "1") int currentPage, 
								@RequestParam(value = "rowPerPage", defaultValue = "10") int rowPerPage,
								@RequestParam(value = "searchWord", required = false) String searchWord,
								@RequestParam(value = "selectSearch", required = false) String selectSearch) {
		log.debug("●●●●▶currentPage-> "+currentPage);
		log.debug("●●●●▶rowPerPage-> "+rowPerPage);
		log.debug("●●●●▶searchWord-> "+searchWord);
		log.debug("●●●●▶selectSearch-> "+selectSearch);
		
		Map<String, Object> map = filmService.getFilmList(currentPage, rowPerPage, searchWord, selectSearch);
		model.addAttribute("filmList", map.get("filmList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("selectSearch", selectSearch);
		return "getFilmList";
	}
	
}
