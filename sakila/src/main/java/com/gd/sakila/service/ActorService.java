package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.ActorMapper;
import com.gd.sakila.vo.Actor;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class ActorService {
	@Autowired ActorMapper actorMapper;
	
	public Map<String, Object> getActorList(int currentPage, int rowPerPage, String searchWord, String searchSelect){
		log.debug("●◆■◆●▶ currentPage-> "+currentPage);
		log.debug("●◆■◆●▶ rowPerPage-> "+rowPerPage);
		log.debug("●◆■◆●▶ searchWord-> "+searchWord);
		log.debug("●◆■◆●▶ searchSelect-> "+searchSelect);
		
		//totalRow구하기 위해 값들을 map에 넣어준다.	
		Map<String, Object> putMap = new HashMap<>();
		putMap.put("searchWord", searchWord);
		putMap.put("searchSelect", searchSelect);
		
		//페이징용 beginRow, rowPerPage, lastPage, totalPage
		int beginRow = (currentPage-1)*rowPerPage;
		int totalRow = actorMapper.selectActorTotal(searchWord, searchSelect);
		int lastPage = totalRow/rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		
		log.debug("●◆■◆●▶ beginRow-> "+beginRow);
		log.debug("●◆■◆●▶ totalRow-> "+totalRow);
		log.debug("●◆■◆●▶ lastPage-> "+lastPage);
		
		//vo에 넣어서 보내주기
		//actorList 실행위해 페이징값들을 putMap에 넣어준다.
		putMap.put("beginRow", beginRow);
		putMap.put("rowPerPage", rowPerPage);
		log.debug("●◆■◆●▶ putMap-> "+putMap);
		
		List<Map<String, Object>> actorList = actorMapper.selectActorInfoList(putMap);
		log.debug("●◆■◆●▶ actorList-> "+actorList);
		Map<String, Object> map = new HashMap<>();
		map.put("actorList", actorList);
		map.put("lastPage", lastPage);
		map.put("totalRow", totalRow);
		
		return map;
	}
	
	public int addActor(Actor actor) {
		log.debug("●◆■◆●▶ actor-> "+actor);
		return actorMapper.insertActor(actor);
	}
}
