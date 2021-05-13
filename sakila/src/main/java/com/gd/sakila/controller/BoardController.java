package com.gd.sakila.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.BoardService;
import com.gd.sakila.vo.Board;

@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	@GetMapping("/getBoardOne")
	public String getBoardOne(Model model, @RequestParam(value = "boardId", required = true) int boardId) {
		Map<String, Object> boardOne = boardService.getBoardOne(boardId);
		System.out.println("boardOne-> "+boardOne);	//디버깅
		model.addAttribute("boardOne", boardOne);
		return "getBoardOne";
	}
	
	@GetMapping("/getBoardList")
	//required에 true 적을 시 값 안 들어오면 에러발생
	public String getBoardList(Model model,	//request, response의 역할
								@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
								@RequestParam(value = "rowPerPage", defaultValue = "10") int rowPerPage,
								@RequestParam(value = "searchWord", required = false) String searchWord) {
		
		System.out.println("searchWord-> "+searchWord);
		
		//서비스 호출 후 포워딩
		Map<String, Object> map = boardService.getBoardList(currentPage, rowPerPage, searchWord);
		System.out.println("map-> "+map); //디버깅
		model.addAttribute("boardList", map.get("boardList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("lastPage", map.get("lastPage"));
		
		
		return "getBoardList";
	}
}
