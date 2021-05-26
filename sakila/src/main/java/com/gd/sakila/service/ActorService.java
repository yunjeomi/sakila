package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.ActorMapper;
import com.gd.sakila.vo.Actor;
import com.gd.sakila.vo.Page;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class ActorService {
	@Autowired ActorMapper actorMapper;
	
	public Map<String, Object> getActorList(int currentPage, int rowPerPage, String searchWord){
		log.debug("●◆■◆●▶ currentPage-> "+currentPage);
		log.debug("●◆■◆●▶ rowPerPage-> "+rowPerPage);
		log.debug("●◆■◆●▶ searchWord-> "+searchWord);
		
		//페이징용 beginRow, rowPerPage, lastPage, totalPage
		int beginRow = (currentPage-1)*rowPerPage;
		int totalPage = actorMapper.selectActorTotal(searchWord);
		int lastPage = totalPage/rowPerPage;
		if(totalPage % rowPerPage != 0) {
			lastPage += 1;
		}
		
		log.debug("●◆■◆●▶ beginRow-> "+beginRow);
		log.debug("●◆■◆●▶ totalPage-> "+totalPage);
		log.debug("●◆■◆●▶ lastPage-> "+lastPage);
		
		//vo에 넣어서 보내주기
		Page page = new Page();
		page.setBeginRow(beginRow);
		page.setRowPerPage(rowPerPage);
		page.setSearchWord(searchWord);
		log.debug("●◆■◆●▶ page-> "+page);
		
		List<Map<String, Object>> actorList = actorMapper.selectActorInfoList(page);
		Map<String, Object> map = new HashMap<>();
		map.put("actorList", actorList);
		map.put("lastPage", lastPage);
		
		return map;
	}
	
	public int addActor(Actor actor) {
		log.debug("●◆■◆●▶ actor-> "+actor);
		return actorMapper.insertActor(actor);
	}
}
