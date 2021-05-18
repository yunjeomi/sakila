package com.gd.sakila.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Comment;

@Mapper
public interface CommentMapper {
	List<Comment> selectCommentListByBoard(int boardId);
	int deleteCommentByBoardId(int boardId);
	int deleteCommentByCommentId(Comment comment);
	int insertComment(Comment comment);
}
