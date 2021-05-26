package com.gd.sakila.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.ActorService;
import com.gd.sakila.vo.Actor;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class ActorController {
	@Autowired ActorService actorService;
	
	@GetMapping("/getActorList")
	public String getActorList(Model model, 
								@RequestParam(value = "currentPage", defaultValue = "1") int currentPage, 
								@RequestParam(value = "rowPerPage", defaultValue = "10") int rowPerPage, 
								@RequestParam(value = "searchWord", required = false) String searchWord,
								@RequestParam(value = "searchSelect", required = false) String searchSelect) {
		log.debug("●◆■◆●▶ currentPage-> "+currentPage);
		log.debug("●◆■◆●▶ rowPerPage-> "+rowPerPage);
		log.debug("●◆■◆●▶ searchWord-> "+searchWord);
		log.debug("●◆■◆●▶ searchSelect-> "+searchSelect);
		
		if(searchSelect != null && searchSelect.equals("")) {
			searchSelect = null;
		}
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		//service호출
		Map<String, Object> map = actorService.getActorList(currentPage, rowPerPage, searchWord, searchSelect);
		log.debug("●◆■◆●▶Controller에서 호출한 Service의 map-> "+map);
		
		//service에서 가져온 값 model로 넘겨주기
		model.addAttribute("actorList", map.get("actorList"));
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("totalPage", map.get("totalPage"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchSelect", searchSelect);
		return "getActorList";
	}
	
	@GetMapping("/addActor")
	public String addActor() {
		return "addActor";
	}
	
	@PostMapping("/addActor")
	public String addActor(Actor actor) {
		log.debug("●◆■◆●▶입력한 actor 정보-> "+actor);
		int cnt = actorService.addActor(actor);
		log.debug("●◆■◆●▶addActor 완료 1, 실패 0-> "+cnt);
		return "redirect:/admin/getActorList";
	}
}
