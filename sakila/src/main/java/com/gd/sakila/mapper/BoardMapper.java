package com.gd.sakila.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Board;
import com.gd.sakila.vo.Page;

@Mapper
public interface BoardMapper {
	List<Board> selectBoardList(Page page);
	int selectBoardTotal(String searchWord);
	Board selectBoardOne(int boardId);
	int insertBoard(Board board);
	int deleteBoard(Board board);
}
