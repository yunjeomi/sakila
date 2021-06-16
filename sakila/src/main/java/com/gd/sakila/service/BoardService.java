package com.gd.sakila.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gd.sakila.mapper.BoardMapper;
import com.gd.sakila.mapper.BoardfileMapper;
import com.gd.sakila.mapper.CommentMapper;
import com.gd.sakila.vo.Board;
import com.gd.sakila.vo.BoardForm;
import com.gd.sakila.vo.Boardfile;
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
	@Autowired BoardfileMapper boardfileMapper;
	
	//수정
	public int modifyBoard(Board board) {
		log.debug("●●●●▶modifyBoard-> "+board.toString());
		return boardMapper.updateBoard(board);
	}
	
	//삭제; 보드 삭제 전에 달려있는 댓글 전부 삭제 되도록 한다. + 첨부파일도 삭제하도록 한다.
	public int removeBoard(Board board) {
		log.debug("●●●●▶removeBoard-> "+board.toString());
		//게시글 삭제 -> 게시글 삭제 후 댓글 삭제로 순서 변경. 단) 외래키 지정하지 않거나 no action일 경우
		int boardRow = boardMapper.deleteBoard(board);
		log.debug("●●●●▶removeBoard boardRow-> "+boardRow);
		
		//외래키 board_id를 no action 수정해도 에러 발생하여 외래키를 끊어버림
		if(boardRow == 0) {
			return 0;
		}
		
		//댓글 삭제
		int commentRow = commentMapper.deleteCommentByBoardId(board.getBoardId());
		log.debug("●●●●▶removeBoard commentRow-> "+commentRow);
		
		//프로젝트 내(resource) 파일 삭제
		List<Boardfile> boardfileList = boardfileMapper.selectBoardfileByBoardId(board.getBoardId());
		if(boardfileList != null) {
			for(Boardfile f : boardfileList) {	//select해서 가져온 리스트를 출력
				//프로젝트 경로 얻기 위해
				File temp = new File("");
				String path = temp.getAbsolutePath();
				
				//위에서 얻은 프로젝트 경로(path)를 이용해 프로젝트 내 파일들을 삭제한다.
				File file = new File(path+"\\src\\main\\webapp\\resource\\"+f.getBoardfileName());
				file.delete();
			}
		}
		
		//DB 행 삭제 -> db 행을 먼저 삭제할 경우 위의 boardfileList를 출력할 수 없음
		int boardfileRow = boardfileMapper.deleteBoardfileByBoardId(board.getBoardId());
		log.debug("●●●●▶removeBoard boardfileRow-> "+boardfileRow);
		
		return boardRow;
	}
	
	//추가
	public void addBoard(BoardForm boardForm) {
		log.debug("●●●●▶addBoard-> "+boardForm.toString());
		//BoardForm을 board & boardFile로 쪼개자
		
		//1)board호출
		Board board = boardForm.getBoard();	//입력할 때 boardId는 autoIncreament니까 아직 생성이 안 된 상태..!
		log.debug("●●●●▶boardId 이전의 board-> "+board);	//0
		//입력시 만들어진 key값을 리턴받아야 함 -> 
		boardMapper.insertBoard(board);	//실행
		log.debug("●●●●▶boardId 이후의 board-> "+board);	//INSERT 후 autoIncreament로 생성된 boardId를 가져온다
		
		//2)boardfile 호출; boardForm에서 유일하게 꺼낼 수 있는 List<multipartFile>!!
		//multipartFile을 boardFile로 바꿔준다.
		List<MultipartFile> list = boardForm.getBoardfile();
		
		if(list != null) {
			for(MultipartFile f : list) {
				//boardFile채워넣기
				Boardfile boardfile = new Boardfile();	//임시적인 것이라 DI사용하지 않는다.
				//원래는 boardId가 null이지만 mapper.xml 쿼리 수정(<selectKey>)하여 boardId를 가져옴
				boardfile.setBoardId(board.getBoardId());	
				//boardFile.setBoardfileName(f.getOriginalFilename()); //중복으로 인해 덮어쓸 수 있는 **이슈**
				
				//test.txt -> newName.txt 바꾸는 과정
				String originalFilename = f.getOriginalFilename();
				int dotPosition = originalFilename.lastIndexOf(".");	//text.txt의 .의 위치를 인덱스값으로 가져온다.
				String ext = originalFilename.substring(dotPosition).toLowerCase();	//.부터 가져오고~ 소문자로 바꿔라
				String prename = UUID.randomUUID().toString().replace("-", "");	//랜덤의문자를 스트링 변환후 -를 없애라
				String filename = prename+ext;
				boardfile.setBoardfileName(filename);
				boardfile.setBoardfileSize(f.getSize());
				boardfile.setBoardfileType(f.getContentType());
				log.debug("●●●●▶새로운 파일 이름 boardFile-> "+boardfile);	//0
				
				//2-1) 메소드 실행
				boardfileMapper.insertBoardfile(boardfile);
				
				//2-2) 파일을 저장
				try {
					File temp = new File(""); //프로젝트 폴더에 빈파일이 만들어진다.
					String path = temp.getAbsolutePath();	//프로젝트 폴더의 주소
					//file.getAbsolutePath();	//프로젝트 폴더 위치
					f.transferTo(new File(path+"\\src\\main\\webapp\\resource\\"+filename));	//괄호안에서 이스케이프 문자 사용
				} catch (Exception e) {
					throw new RuntimeException();	//예외 발생하면 발생한걸 알 수 있도록!
				}
			}
		}
	}
	
	//하나보기 + 댓글보기!! + 파일보기 -> 원래의 리턴이 map이기 때문에 추가만 하면 된다.
	public Map<String, Object> getBoardOne(int boardId){
		log.debug("●●●●▶getBoardOne.boardId-> "+boardId);
		//하나보기
		Map<String, Object> boardOne = boardMapper.selectBoardOne(boardId);
		log.debug("●●●●▶boardOne-> "+boardOne);
		
		//파일출력 boardfile
		List<Boardfile> boardfileList = boardfileMapper.selectBoardfileByBoardId(boardId);
		log.debug("●●●●▶boardfileList-> "+boardfileList);
		
		//댓글보기
		List<Comment> commentList = commentMapper.selectCommentListByBoard(boardId);
		log.debug("●●●●▶commentList.size()-> "+commentList.size());
		
		//Map에 하나보기와 댓글보기를 넣어준다!! - 쿼리를 2개 실행하지만 트랜잭션 처리 할 필요가 없음. <-select
		Map<String, Object> map = new HashMap<>();
		map.put("boardOne", boardOne);
		map.put("boardfileList", boardfileList);
		map.put("commentList", commentList);
		
		return map;
	}
	
	//리스트 출력
	public Map<String, Object>	getBoardList(int currentPage, int rowPerPage, String searchWord){
		//매개변수 값 가공&처리
		//전체 list 수(boardTotal), 마지막 페이지(lastPage) 구하기
		int totalRow = boardMapper.selectBoardTotal(searchWord);
		int lastPage = totalRow/rowPerPage;
		if(totalRow%rowPerPage != 0) {
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
		log.debug("●●●●▶getBoardList.page-> "+page.toString());
		
		//쿼리 호출
		List<Board> boardList = boardMapper.selectBoardList(page);	//Page
		
		Map<String, Object> map = new HashMap<>();
		map.put("boardList", boardList);
		map.put("lastPage", lastPage);
		map.put("totalRow", totalRow);
		
		return map;
	}
}
