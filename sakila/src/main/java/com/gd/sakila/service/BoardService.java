package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.BoardMapper;
import com.gd.sakila.mapper.CommentMapper;
import com.gd.sakila.vo.Board;
import com.gd.sakila.vo.Comment;
import com.gd.sakila.vo.Page;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service	//BoardService의 객체를 생성
@Transactional
public class BoardService {
	//BoardMapper의 객체를 생성
	@Autowired BoardMapper boardMapper;
	@Autowired CommentMapper commentMapper;
	
	//수정
	public int modifyBoard(Board board) {
		log.debug("▷▶▷▶▷modifyBoard-> "+board.toString());
		return boardMapper.updateBoard(board);
	}
	
	//삭제; 보드 삭제 전에 달려있는 댓글 전부 삭제 되도록 한다.
	public int removeBoard(Board board) {
		log.debug("▷▶▷▶▷removeBoard-> "+board.toString());
		//게시글 삭제 -> 게시글 삭제 후 댓글 삭제로 순서 변경. 단) 외래키 지정하지 않거나 no action일 경우
		int boardRow = boardMapper.deleteBoard(board);
		log.debug("▷▶▷▶▷removeBoard boardRow-> "+boardRow);
		
		//외래키 board_id를 no action 수정해도 에러 발생하여 외래키를 끊어버림
		if(boardRow == 0) {
			return 0;
		}
		
		//댓글 삭제
		int commentRow = commentMapper.deleteCommentByBoardId(board.getBoardId());
		log.debug("▷▶▷▶▷removeBoard commentRow-> "+commentRow);
		
		return boardRow;
	}
	
	//추가
	public int addBoard(Board board) {
		log.debug("▷▶▷▶▷addBoard-> "+board.toString());
		return boardMapper.insertBoard(board);
	}
	
	//하나보기 + 댓글보기!!
	public Map<String, Object> getBoardOne(int boardId){
		log.debug("▷▶▷▶▷getBoardOne.boardId-> "+boardId);
		//하나보기
		Map<String, Object> boardOne = boardMapper.selectBoardOne(boardId);
		log.debug("▷▶▷▶▷boardOne-> "+boardOne);
		
		//댓글보기
		List<Comment> commentList = commentMapper.selectCommentListByBoard(boardId);
		log.debug("▷▶▷▶▷commentList.size()-> "+commentList.size());
		
		//Map에 하나보기와 댓글보기를 넣어준다!! - 쿼리를 2개 실행하지만 트랜잭션 처리 할 필요가 없음. <-select
		Map<String, Object> map = new HashMap<>();
		map.put("boardOne", boardOne);
		map.put("commentList", commentList);
		
		return map;
	}
	
	//리스트 출력
	public Map<String, Object>	getBoardList(int currentPage, int rowPerPage, String searchWord){
		//매개변수 값 가공&처리
		//전체 list 수(boardTotal), 마지막 페이지(lastPage) 구하기
		int boardTotal = boardMapper.selectBoardTotal(searchWord);
		int lastPage = boardTotal/rowPerPage;
		if(boardTotal%rowPerPage != 0) {
			lastPage += 1;
		}
		//int lastPage = (int)(Math.ceil((double)boardTotal/rowPerPage));
		int beginRow = (currentPage-1)*rowPerPage;
		
		//전처리
		Page page = new Page();
		page.setBeginRow(beginRow);
		page.setRowPerPage(rowPerPage);
		page.setSearchWord(searchWord);
		//System.out.println("Page-> "+page.toString());
		log.debug("▷▶▷▶▷getBoardList.page-> "+page.toString());
		
		//쿼리 호출
		List<Board> boardList = boardMapper.selectBoardList(page);	//Page
		
		Map<String, Object> map = new HashMap<>();
		map.put("boardList", boardList);
		map.put("lastPage", lastPage);
		
		return map;
	}
}
