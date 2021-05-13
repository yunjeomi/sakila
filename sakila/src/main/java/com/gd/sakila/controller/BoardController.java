package com.gd.sakila.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.BoardService;
import com.gd.sakila.vo.Board;

@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	@GetMapping("/addBoard")	//one에서 추가 클릭했을 때
	public String addBoard() {
		
		return "addBoard";
	}
	
	//동일한 mapping이면 에러 발생 -> get/post mapping이 다를 땐 이름 같아도 된다.
	//동일한 메소드명 -> 매개변수가 다르다. 오버로딩 되었음
	@PostMapping("/addBoard")	//addBoard.jsp에서 form submit 클릭했을 때
	//Board board - 커맨드객체; form하나의 모양과 같다.
	public String addBoard(Board board) {	//form안에 입력되는 값 전부를 vo(db의 필드)값으로 아예 받아버린다.
		int cnt = boardService.addBoard(board);
		System.out.println("입력성공1, 실패0-> "+cnt);
		return "redirect:/getBoardList";	//redirect: <- request.sendRedirect((request.getContextPath+)"/주소"); '/주소'로 페이지 이동하라. 
	}
	
	
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
