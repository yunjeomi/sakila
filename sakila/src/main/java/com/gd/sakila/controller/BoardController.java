package com.gd.sakila.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.BoardService;
import com.gd.sakila.vo.Board;
import com.gd.sakila.vo.BoardForm;
import com.gd.sakila.vo.Staff;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")	//얘를 쓰면 class 내의 메소드는 /admin+ get&postMappeing /~ => /admin/~ 합쳐진다.
public class BoardController {
	@Autowired
	private BoardService boardService;
	
	//get/post mapping은 get과 post요청만 받음
	@GetMapping("/modifyBoard")
	public String modifyBoard(Model model, @RequestParam(value = "boardId", required = true) int boardId) {
		log.debug("▷▶▷▶▷param: "+boardId);
		
		//기존의 적어놓은 값들을 가져오기 위해 getBoardOne메소드를 실행해서 forward한다.
		Map<String, Object> map = boardService.getBoardOne(boardId);
		model.addAttribute("boardOne", map.get("boardOne"));
		return "modifyBoard";
	}
	
	@PostMapping("/modifyBoard")
	public String modifyBoard(Board board) {
		int cnt = boardService.modifyBoard(board);
		log.debug("▷▶▷▶▷입력성공1, 실패0-> "+cnt);
		if(cnt == 0) {
			return "redirect:/admin/modifyBoard?boardId="+board.getBoardId();
		}
		return "redirect:/admin/getBoardOne?boardId="+board.getBoardId();
	}

	
	//리턴타입 뷰이름 문자열 c -> v
	@GetMapping("/removeBoard")
	public String removeBoard(Model model, @RequestParam(value = "boardId", required = true) int boardId) {
		log.debug("▷▶▷▶▷param: "+boardId);
		model.addAttribute("boardId", boardId);
		return "removeBoard";
	}
	
	//c -> m -> c(redirect)
	@PostMapping("/removeBoard")
	public String removeBoard(Board board) {
		int cnt = boardService.removeBoard(board);
		log.debug("▷▶▷▶▷입력성공1, 실패0-> "+cnt);
		if(cnt == 0) {
			return "redirect:/admin/removeBoard?boardId="+board.getBoardId();
		}
		return "redirect:/admin/getBoardList";
	}
	
	@GetMapping("/addBoard")	//one에서 추가 클릭했을 때
	public String addBoard(Model model, HttpSession session) {
		log.debug("▷▶▷▶▷로그인 정보->"+session);
		Staff loginStaff = (Staff)session.getAttribute("loginStaff");
		model.addAttribute("loginStaff", loginStaff);
		return "addBoard";
	}
	
	//동일한 mapping이면 에러 발생 -> get/post mapping이 다를 땐 이름 같아도 된다.
	//동일한 메소드명 -> 매개변수가 다르다. 오버로딩 되었음
	@PostMapping("/addBoard")	//addBoard.jsp에서 form submit 클릭했을 때
	//Board board - 커맨드객체; form하나의 모양과 같다.
	public String addBoard(BoardForm boardForm) {	//form안에 입력되는 값 전부를 vo(db의 필드)값으로 아예 받아버린다. -> boardfile 추가로 board대신 boardForm을 받는다.
		log.debug("▷▶▷▶▷boardForm-> "+boardForm);
		boardService.addBoard(boardForm);
		//System.out.println("입력성공1, 실패0-> "+cnt);
		//log.debug("▷▶▷▶▷입력성공1, 실패0-> "+cnt);
		return "redirect:/admin/getBoardList";	//redirect: <- request.sendRedirect((request.getContextPath+)"/주소"); '/주소'로 페이지 이동하라. 
	}
	
	
	@GetMapping("/getBoardOne")
	public String getBoardOne(Model model, @RequestParam(value = "boardId", required = true) int boardId,
								HttpSession session) {
		log.debug("▷▶▷▶▷로그인 정보->"+session);
		Staff loginStaff = (Staff)session.getAttribute("loginStaff");
		
		Map<String, Object> map = boardService.getBoardOne(boardId);
		log.debug("▷▶▷▶▷map-boardOne"+map.get("boardOne"));
		log.debug("▷▶▷▶▷map-boardfileList"+map.get("boardfileList"));
		log.debug("▷▶▷▶▷map-commentList"+map.get("commentList"));
		
		//map으로 묶어온 보드와 코멘트를 다시 나누어 jsp에서 좀 더 간결하게 받도록 한다.
		model.addAttribute("boardOne", map.get("boardOne"));
		model.addAttribute("boardfileList", map.get("boardfileList"));
		model.addAttribute("commentList", map.get("commentList"));
		model.addAttribute("loginStaff", loginStaff);	//로그인 정보도 함께 보내준다.
		return "getBoardOne";
	}
	
	@GetMapping("/getBoardList")
	//required에 true 적을 시 값 안 들어오면 에러발생
	public String getBoardList(Model model,	//request, response의 역할
								@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
								@RequestParam(value = "rowPerPage", defaultValue = "10") int rowPerPage,
								@RequestParam(value = "searchWord", required = false) String searchWord) {
		
		//System.out.println("searchWord-> "+searchWord);
		log.debug("▷▶▷▶▷이슈 설정 전 searchWord ->"+searchWord);
		
		//searchWord ''값 이슈 설정
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		log.debug("▷▶▷▶▷이슈 설정 후 searchWord ->"+searchWord);
		
		//서비스 호출 후 포워딩
		Map<String, Object> map = boardService.getBoardList(currentPage, rowPerPage, searchWord);
		//System.out.println("map-> "+map); //디버깅
		model.addAttribute("boardList", map.get("boardList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("totalRow", map.get("totalRow"));
		
		
		return "getBoardList";
	}
}
