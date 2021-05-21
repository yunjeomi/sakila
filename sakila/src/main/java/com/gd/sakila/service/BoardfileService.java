package com.gd.sakila.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.gd.sakila.mapper.BoardfileMapper;
import com.gd.sakila.vo.Boardfile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class BoardfileService {
	@Autowired BoardfileMapper boardfileMapper;
	
	public int addBoardfile(MultipartFile multipartFile, int boardId) {
		//받아온 multipart의 파일명을 UUID명으로 바꿔주자.
		String oriName = multipartFile.getOriginalFilename();
		
		//확장자 구하기
		int doIndex = oriName.lastIndexOf(".");
		String ext = oriName.toString().substring(doIndex);
		
		//UUID이름 구하기
		String preName = UUID.randomUUID().toString().replace("-", "");
		
		//vo에 넣어줄 것 boardId, name, size, type
		Boardfile boardfile = new Boardfile();
		boardfile.setBoardId(boardId);
		boardfile.setBoardfileName(preName);
		boardfile.setBoardfileType(multipartFile.getContentType());
		boardfile.setBoardfileSize(multipartFile.getSize());
		
		//db 저장
		int cnt = boardfileMapper.insertBoardfile(boardfile);
		log.debug("●●●●▶파일추가 완료1, 실패0-> "+cnt);
		
		//물리적 파일 저장
		if(cnt == 1) {
			//파일명...
			File temp = new File(""); //multipart 안 파일을 빈 file로 복사
			String path = temp.getAbsolutePath();
			File file = new File(path+"\\src\\main\\webapp\\resource\\"+preName+ext);
			log.debug("●●●●▶file 위치 정보 -> "+file);
			try {
				multipartFile.transferTo(file);
			} catch (Exception e) {
				throw new RuntimeException();	//try절에 문제 생기면 RuntimeException 발생시켜줘
			}	
		}
		
		return cnt;
	}
	
	public int deleteBoardfileOne(Boardfile boardfile) {
		log.debug("●●●●▶선택한 boardfile-> "+boardfile);
		
		//프로젝트 내 file삭제
		File temp = new File("");
		String path = temp.getAbsolutePath();
		File file = new File(path+"\\src\\main\\webapp\\resource\\"+boardfile.getBoardfileName());
		if(file.exists()) {
			log.debug("●●●●▶file-> "+file);
			file.delete();
		}
		
		//db 삭제
		return boardfileMapper.deleteBoardfileOne(boardfile.getBoardfileId());
	}
}
