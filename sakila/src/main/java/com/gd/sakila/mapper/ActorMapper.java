package com.gd.sakila.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Actor;

@Mapper
public interface ActorMapper {
	List<Map<String, Object>> selectActorInfoList(Map<String, Object> map);
	int selectActorTotal(String searchWord, String searchSelect);
	int insertActor(Actor actor);
}
