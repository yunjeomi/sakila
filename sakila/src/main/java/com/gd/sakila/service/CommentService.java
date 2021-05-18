package com.gd.sakila.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.sakila.mapper.CommentMapper;
import com.gd.sakila.vo.Comment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommentService {
	@Autowired CommentMapper commentMapper;
	
	//comment 추가
	public int addComment(Comment comment) {
		log.debug("▷▶▷▶▷addComment comment-> "+comment);
		return commentMapper.insertComment(comment);
	}
	
	//comment 한 개 삭제
	public int removeComment(Comment comment) {
		log.debug("▷▶▷▶▷removeComment comment-> "+comment);
		return commentMapper.deleteCommentByCommentId(comment);
	}
}
