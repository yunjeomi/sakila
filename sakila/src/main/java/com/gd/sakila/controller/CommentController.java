package com.gd.sakila.controller;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.CommentService;
import com.gd.sakila.vo.Comment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Mapper
@Controller
@RequestMapping("/admin")
public class CommentController {
	@Autowired CommentService commentService;
	
	//form으로 진행 -> post
	@PostMapping("/addComment")
	public String addComment(Comment comment) {
		log.debug("▷▶▷▶▷addComment comment-> "+comment);
		
		//서비스 메소드 실행
		int cnt = commentService.addComment(comment);
		log.debug("▷▶▷▶▷입력성공1, 실패0-> "+cnt);
		
		//원래의 페이지로 이동위해 boardId 함께 넘겨준다.
		return "redirect:/admin/getBoardOne?boardId="+comment.getBoardId();
	}
	
	//삭제버튼 눌러서 진행 -> get
	@GetMapping("/removeComment")
	public String removeComment(@RequestParam(value = "commentId", required = true) int commentId, @RequestParam(value = "boardId", required = true) int boardId) {
		log.debug("★★★★★받아온 commentId-> "+commentId);
		log.debug("★★★★★받아온 boardId-> "+boardId);
		
		//서비스 메소드 실행
		int cnt = commentService.removeComment(commentId);
		log.debug("▷▶▷▶▷삭제성공1, 실패0-> "+cnt);
		
		//원래의 페이지로 이동위해 boardId 함께 넘겨준다.
		return "redirect:/admin/getBoardOne?boardId="+boardId;
	}
}
