package com.gd.sakila.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.gd.sakila.service.BoardfileService;
import com.gd.sakila.vo.Boardfile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class BoardfileController {
	@Autowired BoardfileService boardfileService;
	
	@GetMapping("/addBoardfile")
	public String addBoardfile(Model model, @RequestParam(value = "boardId", required = true) int boardId) {
		model.addAttribute("boardId", boardId);
		return "addBoardfile";
	}
	
	@PostMapping("/addBoardfile")
	public String addBoardfile(MultipartFile multipartFile, @RequestParam(value = "boardId", required = true) int boardId) {
		log.debug("●●●●▶addBoardfile multipartFile-> "+multipartFile);
		log.debug("●●●●▶addBoardfile boardId-> "+boardId);
		boardfileService.addBoardfile(multipartFile, boardId);
		//log.debug("●●●●▶추가 완료1, 실패0-> "+boardId);
		return "redirect:/admin/getBoardOne?boardId="+boardId;
	}
	
	@GetMapping("/removeBoardfile")
	public String deleteBoardfileOne(Boardfile boardfile) {
		log.debug("●●●●▶선택한 boardfile-> "+boardfile);
		//현재는 아무나 삭제 가능한 상태. 추후에 글쓴이만 삭제 가능하도록 수정
		boardfileService.deleteBoardfileOne(boardfile);
		return "redirect:/admin/getBoardOne?boardId="+boardfile.getBoardId();
	}
}
